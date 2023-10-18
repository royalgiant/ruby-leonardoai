module LeonardoAI
  class Datasets
    def initialize(client: nil)
      @client = client
    end

    # params: {name: string|null, description: string|null}
    def create_dataset(parameters: {})
      @client.json_post(path: "/datasets", parameters: parameters)
    end

    # id: string
    def get_dataset_by_id(id:)
      @client.get(path: "/datasets/#{id}")
    end

    # id: string
    def delete_dataset(id:)
      @client.delete(path: "/datasets/#{id}")
    end

    # dataset_id: string (req'd0, params: {extension: string|null}
    def upload_dataset_image(dataset_id:, parameters: {})
      @client.json_post(path: "/datasets/#{dataset_id}/upload", parameters: parameters)
    end

    # dataset_id: string (req'd0, params: {generatedImageId: string|null}
    def upload_dataset_image(dataset_id:, parameters: {})
      @client.json_post(path: "/datasets/#{dataset_id}/upload/gen", parameters: parameters)
    end
  end
end