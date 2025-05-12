import Foundation

struct MusicItem: Decodable {
    let trackName: String
    let artistName: String
    let collectionName: String?
    let artworkUrl100: URL
}
