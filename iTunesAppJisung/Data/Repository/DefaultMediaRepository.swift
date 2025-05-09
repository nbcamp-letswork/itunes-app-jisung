import Foundation

final class DefaultMediaRepository: MediaRepository {
    private let fetchMediaDataSource: FetchMediaDataSource

    init(fetchMediaDataSource: FetchMediaDataSource) {
        self.fetchMediaDataSource = fetchMediaDataSource
    }

    func fetch(
        keyword: String,
        mediaType: MediaType,
        limit: Int?,
        completion: @escaping (Result<[Media], Error>) -> Void
    ) {
        fetchMediaDataSource.execute(for: keyword, mediaType: mediaType, limit: limit) { result in
            switch result {
            case let .success(items):
                let media = items.map { item in
                    Media(
                        title: item.trackName,
                        creatorName: item.artistName,
                        sourceTitle: item.collectionName,
                        artworkURL: item.artworkUrl100
                    )
                }

                completion(.success(media))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
