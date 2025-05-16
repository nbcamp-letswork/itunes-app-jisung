import Foundation

protocol ParseFeedURLUseCase {
    func execute(feedURL: String, completion: @escaping (Result<URL?, Error>) -> Void)
}
