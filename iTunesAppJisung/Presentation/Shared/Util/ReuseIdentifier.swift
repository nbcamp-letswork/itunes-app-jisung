protocol ReuseIdentifier {
    static var identifier: String { get }
}

extension ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
