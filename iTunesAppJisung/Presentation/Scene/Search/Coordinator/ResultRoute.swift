import XCoordinator

enum ResultRoute: Route {
    case remaining(title: String, numberOfItems: () -> Int, itemProvider: (Int) -> Media)
    case detail(media: Media)
}
