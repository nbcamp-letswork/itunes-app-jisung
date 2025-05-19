import RxSwift
import UIKit

final class SuggestionViewController: UIViewController {
    let searchViewModel: SearchViewModel

    private let disposeBag = DisposeBag()

    weak var delegate: SuggestionViewControllerDelegate?

    private let suggestionTableView = SuggestionTableView()
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
        activityIndicator.style = .large

        [suggestionTableView, activityIndicator]
            .forEach { view.addSubview($0) }

        suggestionTableView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
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

        suggestionTableView.tableView.rx
            .modelSelected(String.self)
            .bind(onNext: { [weak self] suggestion in
                self?.delegate?.didSelectSuggestion(suggestion)
            })
            .disposed(by: disposeBag)

        searchViewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
