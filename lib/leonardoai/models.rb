module LeonardoAI
  class Models
    def initialize(client: nil)
      @client = client
    end

    def upload_3d_model(parameters: {})
      @client.json_post(path: "/models-3d/upload", parameters: parameters)
    end

    def get_3d_models_by_user_id(user_id:, offset: 0, limit: 10)
      @client.get(path: "/models-3d/user/#{user_id}?offset=#{offset}&limit=#{limit}")
    end

    def get_3d_models_by_id(id:, offset: 0, limit: 10)
      @client.get(path: "/models-3d/#{id}?offset=#{offset}&limit=#{limit}")
    end

    def delete_3d_model(id:)
      @client.delete(path: "/models-3d/#{id}")
    end

    def train(parameters: {})
      @client.json_post(path: "/models", parameters: parameters)
    end

    def get_custom_models_by_id(id:)
      @client.get(path: "/models/#{id}")
    end

    def delete_models_by_id(id:)
      @client.delete(path: "/models/#{id}")
    end

    def get_platform_models(offset: 0, limit: 10)
      @client.get(path: "/platformModels?offset=#{offset}&limit=#{limit}")
    end
  end
end