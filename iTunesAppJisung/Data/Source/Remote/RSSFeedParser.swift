import Alamofire
import Foundation

final class RSSFeedParser: NSObject {
    var previewURL: URL?
    var completion: ((URL?) -> Void)?

    func parse(from feedURL: String, completion: @escaping (URL?) -> Void) {
        self.completion = completion

        AF.request(feedURL).responseData { response in
            switch response.result {
            case let .success(data):
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            case .failure:
                completion(nil)
            }
        }
    }
}
