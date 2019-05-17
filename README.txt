# Dependency Injection in Testing

Dependency injection is a technique that can be used to help test classes in isolation.

It allows you to use either the real Dependency or a mock/double.

Consider:
~~~~
class Greeter
  def greet
    smiley = Smiley.new
    "Hello #{smiley.get}"
  end
end

class Smiley
  def get
    ":)"
  end
end
~~~~

Smiley has no dependencies so we can test like:

~~~~
it "returns a smiley" do
  smiley = Smiley.new
  expect(smiley.get).to eq ":)"
end
~~~~

But *Greeter* depends on *Smiley* so there is no easy way of testing it without Smiley.

But if we rearrange it like below:

~~~~
class Greeter
  def initialize(smiley = Smiley.new)
    @smiley = smiley
  end

  def greet
    "Hello #{@smiley.get}"
  end
end

class Smiley
  def get
    ":)"
  end
end
~~~~

We can test it like below:

~~~~
describe Greeter do
  describe "#greet" do
    it "prints a message and a smiley" do
      smiley_double = double :smiley, get: ":D"
      greeter = Greeter.new(smiley_double)
      expect(greeter.greet).to eq "Hello :D"
    end
  end
end

# smiley_spec.rb
describe Smiley do
  describe "#get" do
    it "returns a smiley" do
      smiley = Smiley.new
      expect(smiley.get).to eq ":)"
    end
  end
end
~~~~
