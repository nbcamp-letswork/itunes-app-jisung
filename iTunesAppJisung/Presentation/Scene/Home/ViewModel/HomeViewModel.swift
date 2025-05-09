import RxCocoa
import RxSwift

final class HomeViewModel {
    private let fetchMediaUseCase: FetchMediaUseCase

    private let disposeBag = DisposeBag()

    let musicSections = BehaviorRelay<[MusicSection]>(value: [])
    let selectedMusic = BehaviorRelay<Media?>(value: nil)

    init(fetchMediaUseCase: FetchMediaUseCase) {
        self.fetchMediaUseCase = fetchMediaUseCase

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

    private func fetchMusicObservable(for season: Season) -> Observable<[Media]> {
        Observable.create { [weak self] observer in
            let limit: Int? = season == .spring ? HomeConstant.Carousel.itemCount : nil

            self?.fetchMediaUseCase.execute(for: season.keyword, mediaType: .music, limit: limit) { result in
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

    func selectMusic(_ music: Media) {
        selectedMusic.accept(music)
    }
}
