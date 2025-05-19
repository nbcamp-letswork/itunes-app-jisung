import Foundation

extension RSSFeedParser: XMLParserDelegate {
    func parser(
        _ parser: XMLParser,
        didStartElement name: String,
        namespaceURI _: String?,
        qualifiedName _: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        if name == "enclosure", let urlString = attributeDict["url"], let url = URL(string: urlString) {
            previewURL = url

            parser.abortParsing()
        }
    }

    func parser(_: XMLParser, parseErrorOccurred _: Error) {
        if completion != nil {
            completion?(previewURL)
            completion = nil
        }
    }

    func parserDidEndDocument(_: XMLParser) {
        completion?(previewURL)
        completion = nil
    }
}
