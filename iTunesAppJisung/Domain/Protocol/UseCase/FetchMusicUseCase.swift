protocol FetchMusicUseCase {
    func execute(for keyword: String, limit: Int?, completion: @escaping (Result<[Media], Error>) -> Void)
}
