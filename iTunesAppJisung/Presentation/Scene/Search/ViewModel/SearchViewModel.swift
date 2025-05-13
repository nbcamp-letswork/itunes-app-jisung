import RxCocoa
import RxSwift

final class SearchViewModel {
    private let fetchMediaUseCase: FetchMediaUseCase

    private let disposeBag = DisposeBag()

    let query = BehaviorRelay<String>(value: "")
    let searchSections = BehaviorRelay<[SearchSection]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)

    init(fetchMediaUseCase: FetchMediaUseCase) {
        self.fetchMediaUseCase = fetchMediaUseCase

        bindQuery()
    }

    private func bindQuery() {
        query
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .do(onNext: { [weak self] _ in
                self?.searchSections.accept([])
                self?.isLoading.accept(true)
            })
            .flatMapLatest { [weak self] keyword -> Observable<[SearchSection]> in
                guard let self else { return .just([]) }

                return self.combineMedia(for: keyword)
                    .do(onNext: { [weak self] _ in
                        self?.isLoading.accept(false)
                    })
            }
            .bind(to: searchSections)
            .disposed(by: disposeBag)
    }

    private func combineMedia(for keyword: String) -> Observable<[SearchSection]> {
        let movie = fetchMediaObservable(for: keyword, type: .movie)
        let podcast = fetchMediaObservable(for: keyword, type: .podcast)

        return Observable.zip(movie, podcast)
            .map { movieItems, podcastItems in
                var sections: [SearchSection] = []

                if let spotlightMovie = movieItems.first {
                    sections.append(SearchSection(type: .movie, items: [spotlightMovie]))
                }

                if let spotlightPodcast = podcastItems.first {
                    sections.append(SearchSection(type: .podcast, items: [spotlightPodcast]))
                }

                let remainingMovies = Array(movieItems.dropFirst())
                sections.append(SearchSection(type: .movie, items: remainingMovies))

                let remainingPodcasts = Array(podcastItems.dropFirst())
                sections.append(SearchSection(type: .podcast, items: remainingPodcasts))

                return sections
            }
    }

    private func fetchMediaObservable(for keyword: String, type: SearchType) -> Observable<[Media]> {
        Observable.create { [weak self] observer in
            self?.fetchMediaUseCase.execute(for: keyword, mediaType: type.mediaType, limit: nil) { result in
                switch result {
                case let .success(media):
                    observer.onNext(media)
                case .failure:
                    observer.onNext([])
                }

                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    func updateQuery(_ text: String) {
        query.accept(text)
    }
}
