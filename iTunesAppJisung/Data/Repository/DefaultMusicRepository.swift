import Foundation

final class DefaultMusicRepository: MusicRepository {
    private let fetchMusicDataSource: FetchMusicDataSource

    init(fetchMusicDataSource: FetchMusicDataSource) {
        self.fetchMusicDataSource = fetchMusicDataSource
    }

    func fetch(keyword: String, completion: @escaping (Result<[Music], Error>) -> Void) {
        fetchMusicDataSource.execute(for: keyword) { result in
            switch result {
            case let .success(items):
                let musics = items.map { item in
                    Music(title: item.trackName, artist: item.artistName, artworkURL: item.artworkUrl100)
                }

                completion(.success(musics))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
