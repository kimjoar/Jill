require 'rubygems'
require 'base64'

class Jill
  attr_accessor :dropbox_base_path
  
  def initialize(name=nil)
    @name = name == nil ? 'archive.tar.gz' : name
    @current = File.dirname(File.expand_path(__FILE__))
    @backup = File.join(@current, @name)

    # Make sure that we don't try to backup the backup
    exclude @backup
  end

  def dropbox_path
    return @path unless @path == nil

    File.open(dropbox_base_path + "host.db") do |f|
      f.readline
      @path = Base64.decode64(f.readline)
    end
    
    @path
  end
  
  def add(path)
    raise "The given path is not allowed. Must be a file or a directory." unless File.file?(path) or File.directory?(path)

    @paths = [] if @paths == nil
    @paths << path
  end

  def exclude(path)
    @excluded = [] if @excluded == nil
    @excluded << path
  end

  def encrypt(algorithm, password = nil)
    @encrypt = true
    @algorithm = algorithm
    @password = password
    @encrypted = File.join(@current, 'archive.enc')
  end

  def backup!
    paths = @paths.join(" ")
    excluded = @excluded.collect {|p| '--exclude "' + p + '"'}.join(" ")
    
    puts "Backing up the files ..."
    system("tar -czvf #{@backup} #{excluded} #{paths}")
    puts "... Done"

    if @encrypt
      puts "Encypting file using the algorithm %s" % @algorithm
      system("openssl enc -%s -salt -in %s -out %s -pass pass:%s" % [@algorithm, @backup, @encrypted, @password])
    end

    puts "Moving the file to the Dropbox folder ..."
    if @encrypt
      FileUtils.mv(@encrypted, File.join(dropbox_path, 'archive.enc'))
      FileUtils.rm(@backup)
    else
      FileUtils.mv(@backup, File.join(dropbox_path, @name))
    end
    puts "... Done"
  end
  
  def decrypt!(file, algorithm, password)
    system("openssl enc -d -%s -in %s -pass pass:%s" % [@algorithm, @file, @password])
  end
end