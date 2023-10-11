module LeonardoAI
  class Generations
    def initialize(client: nil)
      @client = client
    end

    def generate(parameters: {})
      @client.json_post(path: "/generations", parameters: parameters)
    end

    def get_generation(id:)
      @client.get(path: "/generations/#{id}")
    end

    def delete_generation(id:)
      @client.delete(path: "/generations/#{id}")
    end

    def get_user_generations(user_id:)
      @client.get(path: "/generations/user/#{user_id}")
    end

    def generate_texture_generation(parameters: {})
      @client.json_post(path: "/generations-texture", parameters: parameters)
    end

    def get_texture_generation_by_model_id(model_id:)
      @client.get(path: "/generations-texture/model/#{model_id}")
    end

    def get_texture_generation_by_id(id:)
      @client.get(path: "/generations-texture/model/#{id}")
    end

    def delete_texture_generation(id:)
      @client.delete(path: "/generations-texture/#{id}")
    end
  end
end