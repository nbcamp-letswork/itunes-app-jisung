protocol MusicRepository {
    func fetch(keyword: String, limit: Int?, completion: @escaping (Result<[Media], Error>) -> Void)
}
