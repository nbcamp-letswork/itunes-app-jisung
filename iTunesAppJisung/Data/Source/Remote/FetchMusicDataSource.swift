import Alamofire

struct FetchMusicDataSource {
    func execute(for keyword: String, completion: @escaping (Result<[MusicItem], Error>) -> Void) {
        let baseURL = "https://itunes.apple.com/search"
        let parameters: Parameters = [
            "media": "music",
            "term": keyword,
        ]

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
