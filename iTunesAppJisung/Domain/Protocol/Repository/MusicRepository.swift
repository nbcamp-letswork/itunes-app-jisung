protocol MusicRepository {
    func fetch(keyword: String, completion: @escaping (Result<[Music], Error>) -> Void)
}
