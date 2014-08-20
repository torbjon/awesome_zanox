module AwesomeZanox
  class Resources
    attr_accessor :connect_id, :secret_key, :url

    def initialize(connect_id = '', secret_key = '')
      @connect_id = connect_id.strip
      @secret_key = secret_key.strip
      @url = 'https://api.zanox.com/wsdl/2011-03-01'
    end

    def client(url)
      Savon.client do
        wsdl url
        # log true
      end
    end

    def signature(service_name, operation, date = nil, nonce = nil)
      nonce ||= get_nonce
      date  ||= get_date
      string_to_sign = [service_name.downcase, operation.downcase, date, nonce].join('')      
      raw_hmac = OpenSSL::HMAC.digest('sha1', @secret_key, string_to_sign)
      Base64.encode64(raw_hmac)[0..-2]
    end

    def get_nonce
      SecureRandom.hex
    end

    def get_date
      Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S')
    end

    def auth_message(service_name, operation, date = nil, nonce = nil, opts = {})
      date  ||= get_date
      nonce ||= get_nonce
      {
        'connectId' => connect_id,
        'timestamp' => date,
        'nonce' => nonce,
        'signature' => signature(service_name, operation, date, nonce)
      }.merge(opts)
    end

    def message(opts = {})
      {
        'connectId' => connect_id
      }.merge(opts)
    end
  end
end
