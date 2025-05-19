import SnapKit
import UIKit

final class ResultRemainingCell: UICollectionViewCell, ReuseIdentifier {
    let resultRemainingTableView = ResultRemainingTableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        resultRemainingTableView.shouldTap = { true }

        contentView.addSubview(resultRemainingTableView)

        resultRemainingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateUI(
        title: String,
        numberOfItems: @escaping () -> Int,
        itemProvider: @escaping (Int) -> Media,
        onButtonTapped: @escaping (Media) -> Void
    ) {
        resultRemainingTableView.numberOfItems = numberOfItems
        resultRemainingTableView.itemProvider = itemProvider
        resultRemainingTableView.onButtonTapped = onButtonTapped
        resultRemainingTableView.updateUI(title: title, isScrollEnabled: false)
    }
}
