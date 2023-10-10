module LeonardoAI
  module HTTP
    def get(path:)
      to_json(conn.get(uri(path: path)) do |req|
        req.headers = headers
      end&.body)
    end

    def json_post(path:, parameters:)
      to_json(conn.post(uri(path: path)) do |req|
        req.headers = headers
        req.body = parameters.to_json
      end&.body)
    end

    def multipart_post(path:, parameters: nil)
      to_json(conn(multipart: true).post(uri(path: path)) do |req|
        req.headers = headers.merge({ "Content-Type" => "multipart/form-data" })
        req.body = multipart_parameters(parameters)
      end&.body)
    end

    def delete(path:)
      to_json(conn.delete(uri(path: path)) do |req|
        req.headers = headers
      end&.body)
    end

    private

    def to_json(string)
      return unless string

      JSON.parse(string)
      rescue JSON::ParserError
        # Convert a multiline string of JSON objects to a JSON array.
        JSON.parse(string.gsub("}\n{", "},{").prepend("[").concat("]"))
    end

    def conn(multipart: false)
      Faraday.new do |f|
        f.options[:timeout] = @request_timeout
        f.request(:multipart) if multipart
      end
    end

    def uri(path:)
      File.join(@uri_base, @api_version, path)
    end

    def headers
      leonardoai_headers.merge(@extra_headers || {})
    end

    def leonardoai_headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@access_token}",
      }
    end

    def multipart_parameters(parameters)
      parameters&.transform_values do |value|
        next value unless value.respond_to?(:close) # File or IO object.

        # Doesn't seem like OpenAI needs mime_type yet, so not worth
        # the library to figure this out. Hence the empty string
        # as the second argument.
        Faraday::UploadIO.new(value, "", value.path)
      end
    end
  end
end