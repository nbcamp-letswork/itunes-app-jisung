protocol FetchMusicUseCase {
    func execute(for keyword: String, completion: @escaping (Result<[Music], Error>) -> Void)
}
