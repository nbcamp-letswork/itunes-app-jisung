protocol MusicRepository {
    func fetch(keyword: String, limit: Int?, completion: @escaping (Result<[Music], Error>) -> Void)
}
