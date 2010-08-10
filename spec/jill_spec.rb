require File.join(File.dirname(__FILE__), 'spec_helper')

class Jill
  def backup!

  end
end

describe Jill do
  describe ".backup" do
    it "should yield an instance of Jill" do
      Jill.backup { |jill| jill.should be_kind_of(Jill) }
    end

    it "should evaluate the block within an instance of Jill if the variable is not specified" do
      yielded = nil
      Jill.backup { yielded = self }
      yielded.should be_kind_of(Jill)
    end

    it "should raise an error if no block is given" do
      lambda { Jill.backup }.should raise_error
    end
  end

  describe "#dropbox" do
    it "should set the dropbox base path based on the host.db file" do
      Jill.backup do |jill|
        jill.dropbox '/Users/kimjoar/.dropbox/'
        jill.send(:dropbox_path).should == '/Users/kimjoar/Dropbox'
      end
    end
  end

  describe "#add" do
    it "should add the given path to the list of paths to backup" do
      Jill.backup do |jill|
        jill.add '/Users/kimjoar/Documents'
        jill.add '/Users/kimjoar/Documents/test'

        jill.send(:paths).should == ["\"/Users/kimjoar/Documents\"", "\"/Users/kimjoar/Documents/test\""]
      end
    end
  end

  describe "#exclude" do
    it "should add the given path to the list of paths to not backup" do
      Jill.backup do |jill|
        jill.exclude '/Users/kimjoar/Documents/test'

        jill.send(:excluded_paths).should == ["--exclude=\"/Users/kimjoar/Documents/test\""]
      end
    end
  end

  describe "#filename" do
    it "should return a default name if no name is set" do
      Jill.backup do |jill|
        jill.filename[-7..-1].should == "_backup"
      end
    end

    it "should return the name that is set" do
      Jill.backup do |jill|
        jill.filename 'test'
        jill.filename.should == 'test'
      end
    end
  end

  describe "#file" do
    it "should return the encrypted file if encryption is set" do
      Jill.backup do |jill|
        jill.encrypt 'aes-256-cbc', 'password'
        jill.filename 'test'
        jill.send(:file).should == 'test.aes-256-cbc'
      end
    end

    it "should return the tar.gz file if encryption is not set" do
      Jill.backup do |jill|
        jill.filename 'test'
        jill.send(:file).should == 'test.tar.gz'
      end
    end
  end

  describe "#encrypt" do

  end

  describe "#backup!" do

  end
end
