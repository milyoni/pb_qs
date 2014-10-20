#Console IO

module ConIO
  def prompt(msg)
    print msg
    STDIN.gets().chomp()
  end

  ## I was trying to stub out puts in tests, but can't figure out how to do it
  ## with this mixed-in module.
  #alias_method :kernel_puts, :puts
  #def puts(*args)
  #  kernel_puts *args
  #end
end
