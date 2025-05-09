import RxCocoa
import RxSwift

final class SearchViewModel {
    private let fetchMediaUseCase: FetchMediaUseCase

    private let disposeBag = DisposeBag()

    let query = PublishRelay<String>()
    let searchSections = BehaviorRelay<[SearchSection]>(value: [])

    init(fetchMediaUseCase: FetchMediaUseCase) {
        self.fetchMediaUseCase = fetchMediaUseCase

        bindQuery()
    }

    private func bindQuery() {
        query
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .flatMapLatest { [weak self] keyword -> Observable<[SearchSection]> in
                guard let self else { return .just([]) }

                return self.combineMedia(for: keyword)
            }
            .bind(to: searchSections)
            .disposed(by: disposeBag)
    }

    private func combineMedia(for keyword: String) -> Observable<[SearchSection]> {
        let movie = fetchMediaObservable(for: keyword, type: .movie)
            .map { SearchSection(type: .movie, items: $0) }

        let podcast = fetchMediaObservable(for: keyword, type: .podcast)
            .map { SearchSection(type: .podcast, items: $0) }

        return Observable.zip(movie, podcast)
            .map { [$0, $1] }
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
