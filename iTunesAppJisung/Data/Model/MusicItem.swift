import Foundation

struct MusicItem: Decodable {
    let trackName: String
    let artistName: String
    let artworkUrl100: URL
}
