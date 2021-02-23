begin
  require 'rubygems'
  require 'pry'
  require 'pry-editline'
rescue LoadError
end

class Object
  def own_methods
    methods - Object.methods
  end
end

if defined?(Pry)
  Pry.start
  exit
end
