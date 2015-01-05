module Request
  module EnvelopeHelpers
    def envelope_errors
      envelope_response[:errors]
    end

    def envelope_metadata
      envelope_response[:metadata]
    end

    def envelope_resource
      envelope_response[:resource]
    end

    def envelope_response
      @envelope_response ||= JSON.parse response.body, symbolize_names: true
    end

    def envelope_status
      envelope_metadata[:status]
    end
  end

  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse response.body, symbolize_names: true
    end
  end

  module HeadersHelpers
    def api_header(version = 1)
      request.headers["Accept"] == "application/vnd.users.v#{version}"
    end

    def api_token(token)
      request.headers["OMB-Authorization"] = token
    end

    def api_response_format(format = Mime::JSON)
      request.headers["Accept"] = "#{request.headers["Accept"]},#{format}"
      request.headers["Content-Type"] = format.to_s
    end

    def include_default_accept_headers
      api_header
      api_response_format
    end
  end
end
