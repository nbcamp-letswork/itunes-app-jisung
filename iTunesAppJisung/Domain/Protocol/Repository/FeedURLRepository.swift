import Foundation

protocol FeedURLRepository {
    func parse(feedURL: String, completion: @escaping (Result<URL?, Error>) -> Void)
}
