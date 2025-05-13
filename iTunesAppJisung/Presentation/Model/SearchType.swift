import UIKit

enum SearchType {
    case movie,
         podcast

    var mediaType: MediaType {
        switch self {
        case .movie: .movie
        case .podcast: .podcast
        }
    }

    var spotlightTitle: String {
        switch self {
        case .movie: "MOVIE SPOTLIGHT"
        case .podcast: "PODCAST SPOTLIGHT"
        }
    }

    var remainingTitle: String {
        switch self {
        case .movie: "Popular Movies"
        case .podcast: "Popular Podcasts"
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .movie: UIColor(red: 0.8, green: 0.92, blue: 0.95, alpha: 1.0)
        case .podcast: UIColor(red: 1.0, green: 0.97, blue: 0.85, alpha: 1.0)
        }
    }
}
