# Amend the following to be testable in isolation.

class Note
  def initialize(title, body, note_formatter)
    @title = title
    @body = body
    @formatter = note_formatter
  end

  def display
    @formatter.format(self)
  end

  attr_reader :title, :body
end

class NoteFormatter
  def format(note)
    "Title: #{note.title}\n#{note.body}"
  end
end

describe Note do
  it 'can initialize' do
    formatter = double("My formatter")
    note = Note.new("This is the title", "This is the body.", formatter)

    expect(note).to be_kind_of(Note)
  end

  it 'can respond to title' do
    formatter = double("My formatter")
    note = Note.new("This is the title", "This is the body.", formatter)

    expect(note.title).to eq("This is the title")
  end

  it 'can respond to body' do
    formatter = double("My formatter")
    note = Note.new("This is the title", "This is the body.", formatter)

    expect(note.body).to eq("This is the body.")
  end

  it 'can use the formatter to display information' do
    formatter = double("My formatter")
    allow(formatter).to receive(:format).and_return("formatted note")
    note = Note.new("This is the title", "This is the body.", formatter)

    expect(note.display).to eq("formatted note")
  end
end

describe NoteFormatter do
  it 'can initialize' do
    formatter = NoteFormatter.new
    expect(formatter).to be_kind_of(NoteFormatter)
  end

  it 'can formate a note' do
    formatter = NoteFormatter.new
    note = double("my note", :title => "This is a title", :body => "Body")

    formatted_note = formatter.format(note)

    expect(formatted_note).to eq("Title: This is a title\nBody")
  end
end
