final class DefaultFetchMediaUseCase: FetchMediaUseCase {
    private let mediaRepository: MediaRepository

    init(mediaRepository: MediaRepository) {
        self.mediaRepository = mediaRepository
    }

    func execute(
        for keyword: String,
        mediaType: MediaType,
        limit: Int?,
        completion: @escaping (Result<[Media], Error>) -> Void
    ) {
        mediaRepository.fetch(keyword: keyword, mediaType: mediaType, limit: limit, completion: completion)
    }
}
