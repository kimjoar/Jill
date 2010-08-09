require 'base64'
require 'fileutils'

# Jill.backup do
#   dropbox  '/Users/kimjoar/.dropbox/'
#   add      '/Users/kimjoar/Documents'
#   exclude  '/Users/kimjoar/Documents/Virtual Machines/'
#   encrypt  'aes-256-cbc', 'password'
#   filename 'archive'
# end
class Jill
  class << self
    def backup(&block)
      raise unless block_given?

      jill = new
      if block.arity == 1
        block.call(jill)
      else
        jill.instance_eval(&block)
      end
      jill.backup!
    end
  end

  def dropbox(path)
    encoded_path = File.readlines(path + "host.db")[1].chomp
    @dropbox_path = Base64.decode64(encoded_path)
  end

  def filename(filename = nil)
    @filename = filename if filename
    @filename = Time.new.strftime("%Y%m%d") + '_backup' unless @filename
    @filename
  end

  def add(path)
    paths << '"' + path + '"'
  end

  def exclude(path)
    excluded_paths << '--exclude="' + path + '"'
  end

  def encrypt(algorithm, password)
    self.algorithm = algorithm
    self.password  = password
  end

  def backup!
    system "tar -czPvf #{filename + '.tar.gz'} #{excluded_paths.join(' ')} #{paths.join(' ')}"
    encrypt! if encrypt?
    move!
  end

  private

  attr_accessor :algorithm, :password
  attr_reader   :dropbox_path

  def move!
    FileUtils.mv File.join(Dir.pwd, file), to
  end

  def file
    filename + '.' + (algorithm || 'tar.gz')
  end

  def paths
    @paths ||= []
  end

  def excluded_paths
    @excluded_paths ||= []
  end

  def encrypt?
    !!algorithm
  end

  def to
    dropbox_path.chomp('/') + '/' + file
  end

  def encrypt!
    system("openssl enc -%s -salt -in %s -out %s -pass pass:%s" % [algorithm, filename + '.tar.gz', filename + '.' + algorithm, password])
  end
end
