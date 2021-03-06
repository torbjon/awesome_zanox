module AwesomeZanox
  class Resources
    attr_accessor :connect_id, :secret_key, :url

    def initialize(connect_id = '', secret_key = '')
      @connect_id = connect_id.strip
      @secret_key = secret_key.strip
      @publisher_url = 'https://api.zanox.com/wsdl/2011-03-01'
      @data_url = 'https://data.zanox.com/wsdl/2011-05-01'
    end

    def client(url)
      Savon.client do
        wsdl url
        convert_request_keys_to :none
        strip_namespaces true
        # log true
        # log_level :debug
        # pretty_print_xml true
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
      }.merge(parsed_opts(opts))
    end

    def message(opts = {})
      {
        'connectId' => connect_id
      }.merge(parsed_opts(opts))
    end

    def parsed_opts(opts)
      opts.dup.tap{ |h| h.delete(:nokogiried) }
    end
  end
end
