module AwesomeZanox
  class Publisher < Resources
    def get_profile(opts = {}, date = nil, nonce = nil)
      response = client(@url).call(:get_profile, message: auth_message('publisherservice', 'getprofile', date, nonce, opts))
      response.body
    end

    def get_program_applications(opts = {}, date = nil, nonce = nil)
      response = client(@url).call(:get_program_applications, message: auth_message('publisherservice', 'getprogramapplications', date, nonce, opts))
      response.body
    end

    def get_admedia(opts = {})
      response = client(@url).call(:get_admedia, message: message(opts))
      response.body
    end
  end
end
