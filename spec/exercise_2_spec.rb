# Amend the following to be testable in isolation.
## You can inject classes, not just instances.

class Diary
  attr_reader :entries
  def initialize
    @entries = []
  end

  def add(title, body, type_of_object = Entry)
    @entries << type_of_object.new(title, body)
  end

  def index
    titles = @entries.map do |entry|
      entry.title
    end
    titles.join("\n")
  end
end

class Entry
  def initialize(title, body)
    @title = title
    @body = body
  end

  attr_reader :title, :body
end

describe Diary do
  it 'can be added in isolation of entry' do
    my_diary = Diary.new

    entry_double = double("entry double")
    entry_class_double = double("entry class double", new: entry_double)

    my_diary.add("title", "body", entry_class_double)

    expect(my_diary.entries).to include(entry_double)
  end

  it 'can be indexed in isolation of entry' do
    my_diary = Diary.new
    entry_double = double("entry double", :title => "My title")
    entry_class_double = double("entry class double", new: entry_double)
    my_diary.add("title", "body", entry_class_double)
    my_diary.add("game of thrones", "body", entry_class_double)


    expect(my_diary.index()).to eq("My title\nMy title")
  end
end
