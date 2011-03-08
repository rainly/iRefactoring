require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Vcs::LogParser do
  describe 'knows source code postfix' do    
    it 'postfix should be .cs give language is csharp' do
      DDR_ENV[:language] = 'csharp'
      FakeVcs.new().source_code_postfix().should == '.cs'
    end
    
    it 'postfix should be .java give language is java' do
      DDR_ENV[:language] = 'java'
      FakeVcs.new().source_code_postfix().should == '.java'
    end
  end
  
  describe 'knows log file name' do
    before(:each) do
      DDR_ENV[:project_root] = 'temp'
    end
    
    it 'log file should be hg.txt given hg vcs' do
      DDR_ENV[:vcs] = 'hg'
      FakeVcs.new().log_file.should == "temp/hg.txt"
    end
    
    it 'log file should be svn.txt given svn vcs' do
      DDR_ENV[:vcs] = 'svn'
      FakeVcs.new().log_file.should == "temp/svn.txt"
    end
  end
end

class FakeVcs
  include Vcs::LogParser
  
  def initialize
    @language = DDR_ENV[:language]
    @vcs = DDR_ENV[:vcs]
  end
end