import SnapKit
import UIKit

final class ResultCollectionView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(
            ResultHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ResultHeaderView.identifier
        )
        collectionView.register(ResultSpotlightCell.self, forCellWithReuseIdentifier: ResultSpotlightCell.identifier)
        collectionView.register(ResultRemainingCell.self, forCellWithReuseIdentifier: ResultRemainingCell.identifier)

        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
