protocol FetchMediaUseCase {
    func execute(
        for keyword: String,
        mediaType: MediaType,
        limit: Int?,
        completion: @escaping (Result<[Media], Error>) -> Void
    )
}
