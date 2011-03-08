class Code
  attr_accessor :name, :commit, :complexity

  def initialize name, commit, complexity
    @name = name
    @commit = commit
    @complexity = complexity
  end
  
  def tip
    name + ": commit=> " + (commit.to_s) + " complexity=> " + (complexity.to_s)
  end
end