import Foundation

struct MediaItem: Decodable {
    let trackName: String
    let artistName: String
    let collectionName: String?
    let artworkUrl100: URL

    var highQualityArtworkURL: URL {
        let highResString = artworkUrl100.absoluteString.replacingOccurrences(of: "100x100", with: "600x600")

        return URL(string: highResString) ?? artworkUrl100
    }
}
