module AwesomeZanox
  class Client < Resources
    def publisher
      @publisher ||= AwesomeZanox::Publisher.new(connect_id, secret_key)
    end
  end
end
