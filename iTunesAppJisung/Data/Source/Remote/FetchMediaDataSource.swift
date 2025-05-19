import Alamofire

struct FetchMediaDataSource {
    func execute(
        for keyword: String,
        mediaType: MediaType,
        limit: Int?,
        completion: @escaping (Result<[MediaItem], Error>) -> Void
    ) {
        var parameters: Parameters = [
            "media": mediaType.rawValue,
            "term": keyword,
        ]

        if limit != nil {
            parameters["limit"] = limit
        }

        AF.request(DataConstant.baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: MediaResponse.self) { response in
                switch response.result {
                case let .success(mediaResponse):
                    completion(.success(mediaResponse.results))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
