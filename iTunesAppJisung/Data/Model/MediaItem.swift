import Foundation

struct MediaItem: Decodable {
    let trackName: String
    let artistName: String
    let collectionName: String?
    let artworkUrl100: URL
    let releaseDate: String
    let primaryGenreName: String
    let feedUrl: String?
    let previewUrl: URL?

    var highQualityArtworkURL: URL {
        let highResString = artworkUrl100.absoluteString.replacingOccurrences(of: "100x100", with: "600x600")

        return URL(string: highResString) ?? artworkUrl100
    }

    var formattedReleaseDate: String {
        let inputFormatter = ISO8601DateFormatter()
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: releaseDate) {
            return outputFormatter.string(from: date)
        } else {
            return releaseDate
        }
    }
}
