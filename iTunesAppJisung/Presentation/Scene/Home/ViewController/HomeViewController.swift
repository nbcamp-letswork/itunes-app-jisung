import SnapKit
import UIKit

class HomeViewController: UIViewController {
    var searchController = UISearchController()
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureSearchController()
        configureUI()
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
        scrollView.delegate = self

        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.width.equalTo(scrollView)
            $0.height.greaterThanOrEqualTo(view)
        }
    }
}
