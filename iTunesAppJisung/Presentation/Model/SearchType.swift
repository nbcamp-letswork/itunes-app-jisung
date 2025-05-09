enum SearchType {
    case movie,
         podcast

    var mediaType: MediaType {
        switch self {
        case .movie: .movie
        case .podcast: .podcast
        }
    }
}
