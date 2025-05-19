import RxSwift
import UIKit
import XCoordinator

final class MainViewController: UIViewController {
    var router: WeakRouter<MainRoute>?

    private let disposeBag = DisposeBag()

    var searchController = UISearchController()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        router?.trigger(.home)

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
            .filter { [weak self] _ in
                self?.searchController.searchBar.isFirstResponder == true
            }
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] query in
                self?.handleSuggestionInput(query)
            })
            .disposed(by: disposeBag)
    }

    private func home() {
        guard !(children.last is HomeViewController) else { return }
        router?.trigger(.home)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        searchController.searchBar.becomeFirstResponder()
    }

    private func suggestion(for query: String) {
        if !(children.last is SuggestionViewController) {
            router?.trigger(.suggestion)
        }
        updateQuery(query)
    }

    private func updateQuery(_ query: String) {
        if let updatable = children.last as? SearchUpdatable {
            updatable.updateQuery(query)
        }
    }

    func handleSuggestionInput(_ query: String) {
        if query.isEmpty {
            home()
        } else {
            suggestion(for: query)
        }
    }

    func handleSuggestionSelection(_ query: String) {
        searchController.searchBar.resignFirstResponder()
        searchController.searchBar.text = query
        searchController.searchBar.searchTextField.sendActions(for: .editingChanged)
        updateQuery(query)
        router?.trigger(.result)
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
