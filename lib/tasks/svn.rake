namespace :svn do
  task :add_untracked => :environment do
    status = `svn st`
    untracked_lines = status.split("\n").select{|line| line =~ /^\?/}.map do |line|
      line[1, line.size-1].strip
    end
        
    untracked_lines.each{|line| puts line}
    cmd = "svn add #{untracked_lines.join(' ')}"
    system cmd
  end
end
