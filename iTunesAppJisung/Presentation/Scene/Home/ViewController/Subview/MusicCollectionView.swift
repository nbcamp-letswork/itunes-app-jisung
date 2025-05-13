import UIKit

final class MusicCollectionView: UIView {
    var onCarouselChanged: ((Int) -> Void)?

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(MusicCarouselCell.self, forCellWithReuseIdentifier: MusicCarouselCell.identifier)
        collectionView.register(MusicRegularCell.self, forCellWithReuseIdentifier: MusicRegularCell.identifier)
        collectionView.register(
            MusicSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MusicSectionHeaderView.identifier
        )
        collectionView.register(
            MusicSectionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: MusicSectionFooterView.identifier
        )

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

    func updateUI(using seasons: [Season]) {
        collectionView.collectionViewLayout = createCompositionalLayout(using: seasons)
    }
}
