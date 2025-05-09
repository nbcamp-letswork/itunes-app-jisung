import SnapKit
import UIKit

final class MusicSectionFooterView: UICollectionReusableView, ReuseIdentifier {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = HomeConstant.Footer.cornerRadius

        titleLabel.font = .boldSystemFont(ofSize: HomeConstant.Footer.titleSize)

        artistLabel.font = .systemFont(ofSize: HomeConstant.Footer.artistSize)
        artistLabel.textColor = .secondaryLabel

        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.spacing = HomeConstant.Footer.stackViewSpacing

        [imageView, labelStackView]
            .forEach { addSubview($0) }

        [titleLabel, artistLabel]
            .forEach { labelStackView.addArrangedSubview($0) }

        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(HomeConstant.Footer.leadingSpacing)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(HomeConstant.Footer.imageSize)
        }

        labelStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(HomeConstant.Footer.imageAndStackViewSpacing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

    func updateUI(with music: Music) {
        imageView.kf.setImage(with: music.artworkURL)
        titleLabel.text = music.title
        artistLabel.text = music.artist
    }
}
