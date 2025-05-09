import RxCocoa
import RxSwift

final class HomeViewModel {
    private let fetchMusicUseCase: FetchMusicUseCase

    private let disposeBag = DisposeBag()

    let musicSections = BehaviorRelay<[MusicSection]>(value: [])
    let selectedMusic = BehaviorRelay<Music?>(value: nil)

    init(fetchMusicUseCase: FetchMusicUseCase) {
        self.fetchMusicUseCase = fetchMusicUseCase

        fetchAllSeasonsMusic()
    }

    private func fetchAllSeasonsMusic() {
        Observable.from(Season.allCases)
            .flatMap { [weak self] season -> Observable<MusicSection?> in
                guard let self else { return .just(nil) }

                return self.fetchMusicObservable(for: season)
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

    private func fetchMusicObservable(for season: Season) -> Observable<[Music]> {
        Observable.create { [weak self] observer in
            let limit: Int? = season == .spring ? HomeConstant.Carousel.itemCount : nil

            self?.fetchMusicUseCase.execute(for: season.keyword, limit: limit) { result in
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

    func selectMusic(_ music: Music) {
        selectedMusic.accept(music)
    }
}
