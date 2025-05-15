import UIKit

final class ResultRemainingViewController: UIViewController {
    private let resultRemainingTableView = ResultRemainingTableView()
    private let closeButton = CloseButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureBindings()
    }

    override var prefersStatusBarHidden: Bool {
        true
    }

    private func configureUI() {
        resultRemainingTableView.shouldTap = { false }

        [resultRemainingTableView, closeButton]
            .forEach { view.addSubview($0) }

        resultRemainingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        closeButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(ResultConstant.Remaining.closeButtonSpacing)
            $0.size.equalTo(ResultConstant.Remaining.closeButtonSize)
        }
    }

    private func configureBindings() {
        closeButton.onButtonTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }

    func updateUI(
        title: String,
        numberOfItems: @escaping () -> Int,
        itemProvider: @escaping (Int) -> Media
    ) {
        resultRemainingTableView.numberOfItems = numberOfItems
        resultRemainingTableView.itemProvider = itemProvider
        resultRemainingTableView.updateUI(title: title, isScrollEnabled: true)
    }
}
