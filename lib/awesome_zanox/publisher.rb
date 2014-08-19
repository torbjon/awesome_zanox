module AwesomeZanox
  class Publisher < Resources
    def get_profile(opts = {}, date = nil, nonce = nil)
      response = client(@url).call(:get_profile, message: message('publisherservice', 'getprofile', date, nonce, opts))
      response.body
    end

    def get_program_applications(opts = {}, date = nil, nonce = nil)
      response = client(@url).call(:get_program_applications, message: message('publisherservice', 'getprogramapplications', date, nonce, opts))
      response.body
    end
  end
end
