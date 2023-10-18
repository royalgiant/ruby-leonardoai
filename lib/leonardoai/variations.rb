module LeonardoAI
  class Variations
    def initialize(client: nil)
      @client = client
    end

    # params: {id: string|null, isVariation: boolean|null}
    def create_unzoom(parameters: {})
      @client.json_post(path: "/variations/unzoom", parameters: parameters)
    end

    # params: {id: string|null}
    def create_upscale(parameters: {})
      @client.json_post(path: "/variations/upscale", parameters: parameters)
    end

    def get_variation_by_id(id:)
      @client.get(path: "/variations/#{id}")
    end
  end
end