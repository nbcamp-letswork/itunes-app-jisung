import RxSwift
import UIKit
import XCoordinator

final class MainViewController: UIViewController {
    private let suggestionViewController: SuggestionViewController

    var router: UnownedRouter<MainRoute>?

    private let disposeBag = DisposeBag()

    var searchController = UISearchController()
    private let contentView = UIView()

    init(suggestionViewController: SuggestionViewController) {
        self.suggestionViewController = suggestionViewController

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchController()
        configureUI()
        configureBindings()
    }

    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureBindings() {
        searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(onNext: { [weak self] query in
                self?.handleSearch(query)
            })
            .disposed(by: disposeBag)
    }

    private func handleSearch(_ query: String) {
        if query.isEmpty {
            if !(children.last is HomeViewController) {
                router?.trigger(.home)
            }

            return
        }

        if !(children.last is SuggestionViewController) {
            router?.trigger(.suggestion)
        }

        if let updatable = children.last as? SearchUpdatable {
            updatable.updateQuery(query)
        }
    }

    func embed(_ child: UIViewController) {
        addChild(child)

        contentView.addSubview(child.view)

        child.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        title = child.title

        child.didMove(toParent: self)
    }

    func unembed(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
