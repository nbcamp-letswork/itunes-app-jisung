import Foundation

final class DefaultParseFeedURLUseCase: ParseFeedURLUseCase {
    private let feedURLRepository: FeedURLRepository

    init(feedURLRepository: FeedURLRepository) {
        self.feedURLRepository = feedURLRepository
    }

    func execute(feedURL: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        feedURLRepository.parse(feedURL: feedURL, completion: completion)
    }
}
