# Amend the following class to be testable in isolation, then write the tests for it.
# Hint: can you spot the class that Greeter interacts with?

class Greeter
  def greet
    puts "What is your name?"
    name = Kernel.gets.chomp
    puts "Hello, #{name}"
  end
end
