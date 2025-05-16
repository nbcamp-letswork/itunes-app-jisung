import UIKit

final class ResultRemainingViewController: UIViewController {
    private let resultRemainingTableView = ResultRemainingTableView()
    private let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    override var prefersStatusBarHidden: Bool {
        true
    }

    private func configureUI() {
        resultRemainingTableView.shouldTap = { false }

        guard let xmarkImage = UIImage(systemName: "xmark") else { return }
        let configuration = UIImage.SymbolConfiguration(weight: .heavy)
        closeButton.setImage(xmarkImage.withConfiguration(configuration), for: .normal)
        closeButton.tintColor = .tertiarySystemBackground
        closeButton.backgroundColor = .secondaryLabel
        closeButton.layer.cornerRadius = 18
        closeButton.layer.masksToBounds = true
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

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

    @objc
    private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
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
