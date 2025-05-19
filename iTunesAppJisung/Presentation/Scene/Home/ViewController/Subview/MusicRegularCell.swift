import UIKit

final class MusicRegularCell: UICollectionViewCell, ReuseIdentifier {
    private let stackView = UIStackView()
    private var itemViews: [MusicItemView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually

        contentView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        for _ in 0 ..< 3 {
            let itemView = MusicItemView()
            stackView.addArrangedSubview(itemView)
            itemViews.append(itemView)
        }
    }

    func updateUI(with musics: [Media], onButtonTapped: @escaping (Media) -> Void) {
        for (index, itemView) in itemViews.enumerated() {
            if index < musics.count {
                itemView.isHidden = false
                itemView.updateUI(with: musics[index], onButtonTapped: onButtonTapped)
            } else {
                itemView.isHidden = true
            }
        }
    }
}
