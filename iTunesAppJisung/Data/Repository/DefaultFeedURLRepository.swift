import Foundation

final class DefaultFeedURLRepository: FeedURLRepository {
    private let rssFeedParser: RSSFeedParser

    init(rssFeedParser: RSSFeedParser) {
        self.rssFeedParser = rssFeedParser
    }

    func parse(feedURL: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        rssFeedParser.parse(from: feedURL) { completion(.success($0)) }
    }
}
