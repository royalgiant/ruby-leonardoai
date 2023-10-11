module LeonardoAI
  class Client
    include LeonardoAI::HTTP

    CONFIG_KEYS = %i[
      api_type
      api_version
      access_token
      uri_base
      request_timeout
      extra_headers
    ].freeze
    attr_reader *CONFIG_KEYS

    def initialize(config = {})
      CONFIG_KEYS.each do |key|
        # Set instance variables like api_type & access_token. Fall back to global config
        # if not present.
        instance_variable_set("@#{key}", config[key] || LeonardoAI.configuration.send(key))
      end
    end

    def chat(parameters: {})
      json_post(path: "/chat/completions", parameters: parameters)
    end

    def generations
      @generations ||= LeonardoAI::Generations.new(client: self)
    end

    def models
      @models ||= LeonardoAI::Models.new(client: self)
    end
  end
end