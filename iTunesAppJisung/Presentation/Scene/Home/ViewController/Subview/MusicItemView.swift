import Kingfisher
import SnapKit
import UIKit

final class MusicItemView: UIView {
    private let artworkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let albumLabel = UILabel()
    private let openButton = OpenButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.clipsToBounds = true
        artworkImageView.layer.cornerRadius = HomeConstant.Regular.cornerRadius

        titleLabel.font = .boldSystemFont(ofSize: HomeConstant.Regular.titleSize)
        artistLabel.font = .systemFont(ofSize: HomeConstant.Regular.artistSize)
        albumLabel.font = .systemFont(ofSize: HomeConstant.Regular.albumSize)
        albumLabel.textColor = .secondaryLabel

        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.spacing = HomeConstant.Regular.stackViewSpacing

        [artworkImageView, labelStackView, openButton]
            .forEach { addSubview($0) }

        [titleLabel, artistLabel, albumLabel]
            .forEach { labelStackView.addArrangedSubview($0) }

        artworkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(HomeConstant.Regular.imageSize)
        }

        labelStackView.snp.makeConstraints {
            $0.leading.equalTo(artworkImageView.snp.trailing).offset(HomeConstant.Regular.imageAndLabelSpacing)
            $0.centerY.equalToSuperview()
        }

        openButton.snp.makeConstraints {
            $0.leading.equalTo(labelStackView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }
    }

    func updateUI(with music: Media) {
        titleLabel.text = music.title
        artistLabel.text = music.creatorName
        albumLabel.text = music.sourceTitle
        artworkImageView.kf.setImage(with: music.artworkURL)
    }
}
