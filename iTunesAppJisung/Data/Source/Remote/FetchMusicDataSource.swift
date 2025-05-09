import Alamofire

struct FetchMusicDataSource {
    func execute(for keyword: String, limit: Int?, completion: @escaping (Result<[MediaItem], Error>) -> Void) {
        var parameters: Parameters = [
            "media": "music",
            "term": keyword,
        ]

        if limit != nil {
            parameters["limit"] = limit
        }

        AF.request(DataConstant.baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: MediaResponse.self) { response in
                switch response.result {
                case let .success(musicResponse):
                    completion(.success(musicResponse.results))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
