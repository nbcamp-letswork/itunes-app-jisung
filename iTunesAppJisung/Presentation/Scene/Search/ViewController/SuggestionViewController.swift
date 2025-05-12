import RxSwift
import UIKit

final class SuggestionViewController: UIViewController {
    let searchViewModel: SearchViewModel

    private let disposeBag = DisposeBag()

    private let suggestionTableView = SuggestionTableView()

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
        view.addSubview(suggestionTableView)

        suggestionTableView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func configureBindings() {
        searchViewModel.searchSections
            .map { sections in
                sections.flatMap { $0.items.map { $0.title } }
            }
            .bind(to: suggestionTableView.tableView.rx.items(
                cellIdentifier: SuggestionCell.identifier,
                cellType: SuggestionCell.self
            )) { _, suggestion, cell in
                cell.updateUI(with: suggestion)
            }
            .disposed(by: disposeBag)
    }
}
