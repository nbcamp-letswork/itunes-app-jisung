import RxCocoa
import RxSwift

final class HomeViewModel {
    private let fetchMusicUseCase: FetchMusicUseCase

    private let disposeBag = DisposeBag()

    let query = PublishSubject<String>()
    let searchTrigger: Observable<String>
    let cancelSearchTrigger = PublishSubject<Void>()
    let musicSections = BehaviorRelay<[MusicSection]>(value: [])

    init(fetchMusicUseCase: FetchMusicUseCase) {
        self.fetchMusicUseCase = fetchMusicUseCase

        searchTrigger = query
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()

        fetchAllSeasonsMusic()
    }

    private func fetchAllSeasonsMusic() {
        Observable.from(Season.allCases)
            .flatMap { [weak self] season -> Observable<MusicSection?> in
                guard let self else { return .just(nil) }

                return self.fetchMusicObservable(for: season.keyword)
                    .map { musics in
                        MusicSection(season: season, musics: musics)
                    }
            }
            .compactMap { $0 }
            .toArray()
            .asObservable()
            .bind(to: musicSections)
            .disposed(by: disposeBag)
    }

    private func fetchMusicObservable(for keyword: String) -> Observable<[Music]> {
        return Observable.create { [weak self] observer in
            self?.fetchMusicUseCase.execute(for: keyword) { result in
                switch result {
                case let .success(musics):
                    observer.onNext(musics)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
