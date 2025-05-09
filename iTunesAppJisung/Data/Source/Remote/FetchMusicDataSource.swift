import Alamofire

struct FetchMusicDataSource {
    func execute(for keyword: String, limit: Int?, completion: @escaping (Result<[MusicItem], Error>) -> Void) {
        let baseURL = "https://itunes.apple.com/search"
        var parameters: Parameters = [
            "media": "music",
            "term": keyword,
        ]

        if limit != nil {
            parameters["limit"] = limit
        }

        AF.request(baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: MusicResponse.self) { response in
                switch response.result {
                case let .success(musicResponse):
                    completion(.success(musicResponse.results))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
