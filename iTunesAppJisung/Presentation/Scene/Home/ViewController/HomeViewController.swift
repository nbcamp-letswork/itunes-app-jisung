import RxCocoa
import RxSwift
import SnapKit
import UIKit

class HomeViewController: UIViewController {
    let homeViewModel: HomeViewModel

    private let disposeBag = DisposeBag()

    var searchController = UISearchController()
    private let contentView = UIView()
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
        configureSearchController()
        configureUI()
        configureBindings()
    }

    private func configureNavigationBar() {
        title = HomeConstant.Label.title
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = HomeConstant.SearchBar.placeholder
    }

    private func configureUI() {
        musicCollectionView.collectionView.dataSource = self
        musicCollectionView.collectionView.delegate = self

        view.addSubview(contentView)

        contentView.addSubview(musicCollectionView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

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
                self.musicCollectionView.updateLayout(using: seasons)
                self.musicCollectionView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        homeViewModel.selectedMusic
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] selected in
                guard let self,
                      let index = Season.spring.index
                else {
                    return
                }

                let footerIndexPath = IndexPath(item: 0, section: index)

                if let footer = self.musicCollectionView.collectionView.supplementaryView(
                    forElementKind: UICollectionView.elementKindSectionFooter,
                    at: footerIndexPath
                ) as? MusicSectionFooterView {
                    footer.updateUI(with: selected)
                }
            })
            .disposed(by: disposeBag)

        musicCollectionView.onCarouselChanged = { [weak self] itemIndex in
            guard let self,
                  let sectionIndex = Season.spring.index
            else {
                return
            }

            let section = self.homeViewModel.musicSections.value[sectionIndex]
            let music = section.musics[itemIndex]

            homeViewModel.selectMusic(music)
        }
    }
}
