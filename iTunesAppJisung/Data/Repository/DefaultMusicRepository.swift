import Foundation

final class DefaultMusicRepository: MusicRepository {
    private let fetchMusicDataSource: FetchMusicDataSource

    init(fetchMusicDataSource: FetchMusicDataSource) {
        self.fetchMusicDataSource = fetchMusicDataSource
    }

    func fetch(keyword: String, limit: Int?, completion: @escaping (Result<[Media], Error>) -> Void) {
        fetchMusicDataSource.execute(for: keyword, limit: limit) { result in
            switch result {
            case let .success(items):
                let musics = items.map { item in
                    Media(
                        title: item.trackName,
                        creatorName: item.artistName,
                        sourceTitle: item.collectionName,
                        artworkURL: item.artworkUrl100
                    )
                }

                completion(.success(musics))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
