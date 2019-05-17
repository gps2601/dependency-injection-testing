class EmailClient
  def message(content = Message)
    content.new
  end
end

class Message
  def send(to, body)
    # Imagine I'm sending an email
  end
end

class SayHelloToMyLittleFriend
  def run(email_client = EmailClient)
    email = email_client.new
    email.message.send(
      "friend@example.com",
      "HELLO!"
    )
  end
end


describe SayHelloToMyLittleFriend do
  it 'can run' do
    my_shtmlf = SayHelloToMyLittleFriend.new

    message_double = double("message_double")
    expect(message_double).to receive(:send).and_return("sending an email")

    email_client_double = double("email_client_double")
    expect(email_client_double).to receive(:message).and_return(message_double)

    email_client_class_double = double("email_client_class_double", new: email_client_double)

    expect(my_shtmlf.run(email_client_class_double)).to eq("sending an email")
  end
end
