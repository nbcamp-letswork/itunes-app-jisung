protocol MediaRepository {
    func fetch(
        keyword: String,
        mediaType: MediaType,
        limit: Int?,
        completion: @escaping (Result<[Media], Error>) -> Void
    )
}
