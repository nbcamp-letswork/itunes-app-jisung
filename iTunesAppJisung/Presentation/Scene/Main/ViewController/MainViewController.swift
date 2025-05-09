import UIKit

final class MainViewController: UIViewController {
    var searchController = UISearchController()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchController()
        configureUI()
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

    func unembedAll() {
        children.forEach { unembed($0) }
    }
}
