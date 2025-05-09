final class DefaultFetchMusicUseCase: FetchMusicUseCase {
    private let musicRepository: MusicRepository

    init(musicRepository: MusicRepository) {
        self.musicRepository = musicRepository
    }

    func execute(for keyword: String, limit: Int?, completion: @escaping (Result<[Music], Error>) -> Void) {
        musicRepository.fetch(keyword: keyword, limit: limit, completion: completion)
    }
}
