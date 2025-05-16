import RxSwift
import UIKit
import XCoordinator

final class ResultViewController: UIViewController {
    let searchViewModel: SearchViewModel

    var router: WeakRouter<ResultRoute>?

    weak var delegate: ResultViewControllerDelegate?

    let disposeBag = DisposeBag()

    private let resultCollectionView = ResultCollectionView()
    private let activityIndicator = UIActivityIndicatorView()

    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureBindings()
    }

    private func configureUI() {
        resultCollectionView.collectionView.dataSource = self
        resultCollectionView.collectionView.delegate = self

        activityIndicator.style = .large

        [resultCollectionView, activityIndicator]
            .forEach { view.addSubview($0) }

        resultCollectionView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func configureBindings() {
        searchViewModel.searchSections
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }

                self.resultCollectionView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        searchViewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
