import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    let homeViewModel: HomeViewModel

    weak var delegate: HomeViewControllerDelegate?

    private let disposeBag = DisposeBag()

    let musicCollectionView = MusicCollectionView()

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureUI()
        configureBindings()
    }

    private func configureNavigationBar() {
        title = HomeConstant.Label.title
    }

    private func configureUI() {
        musicCollectionView.collectionView.dataSource = self
        musicCollectionView.collectionView.delegate = self

        view.addSubview(musicCollectionView)

        musicCollectionView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func configureBindings() {
        homeViewModel.musicSections
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] sections in
                guard let self else { return }

                let seasons = sections.map { $0.season }
                self.musicCollectionView.updateUI(using: seasons)
                self.musicCollectionView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        homeViewModel.selectedMusic
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] selected in
                guard let self else { return }

                let footerIndexPath = IndexPath(item: 0, section: Season.spring.index)

                if let footer = self.musicCollectionView.collectionView.supplementaryView(
                    forElementKind: UICollectionView.elementKindSectionFooter,
                    at: footerIndexPath
                ) as? MusicSectionFooterView {
                    footer.updateUI(with: selected)
                }
            })
            .disposed(by: disposeBag)

        musicCollectionView.onCarouselChanged = { [weak self] itemIndex in
            guard let self else { return }

            let section = self.homeViewModel.musicSections.value[Season.spring.index]
            let music = section.musics[itemIndex]

            homeViewModel.selectMusic(music)
        }
    }
}
