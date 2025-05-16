import RxRelay
import RxSwift

final class DetailViewModel {
    private let parseFeedURLUseCase: ParseFeedURLUseCase

    private let disposeBag = DisposeBag()

    let media: BehaviorRelay<Media>
    let isLoading = BehaviorRelay<Bool>(value: true)

    init(media: Media, parseFeedURLUseCase: ParseFeedURLUseCase) {
        self.media = BehaviorRelay(value: media)
        self.parseFeedURLUseCase = parseFeedURLUseCase

        parseFeedURL()
    }

    private func parseFeedURL() {
        let currentMedia = media.value

        guard let feedURL = currentMedia.feedURL else {
            isLoading.accept(false)

            return
        }

        parseFeedURLUseCase.execute(feedURL: feedURL) { [weak self] result in
            defer { self?.isLoading.accept(false) }

            switch result {
            case let .success(previewURL):
                var updatedMedia = currentMedia
                updatedMedia.previewURL = previewURL

                self?.media.accept(updatedMedia)
            case .failure:
                break
            }
        }
    }
}
