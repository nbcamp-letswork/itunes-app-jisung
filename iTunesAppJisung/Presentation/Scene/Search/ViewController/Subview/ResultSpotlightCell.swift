import Kingfisher
import SnapKit
import UIKit

final class ResultSpotlightCell: UICollectionViewCell, ReuseIdentifier {
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        contentView.layer.cornerRadius = ResultConstant.Spotlight.backgroundCornerRadius
        contentView.clipsToBounds = true

        titleLabel.font = .boldSystemFont(ofSize: ResultConstant.Spotlight.titleFontSize)
        titleLabel.textColor = .gray

        subTitleLabel.font = .boldSystemFont(ofSize: ResultConstant.Spotlight.subTitleFontSize)
        subTitleLabel.textColor = .black

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        [titleLabel, subTitleLabel, imageView]
            .forEach { contentView.addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(ResultConstant.Spotlight.titleSpacing)
            $0.height.equalTo(ResultConstant.Spotlight.titleHeight)
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(ResultConstant.Spotlight.subTitleTopSpacing)
            $0.horizontalEdges.equalToSuperview().inset(ResultConstant.Spotlight.subTitleHorizontalSpacing)
            $0.height.equalTo(ResultConstant.Spotlight.subTitleHeight)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(ResultConstant.Spotlight.imageTopSpacing)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func updateUI(with media: Media, title: String, backgroundColor: UIColor) {
        subTitleLabel.text = media.title
        imageView.kf.setImage(with: media.artworkURL)
        titleLabel.text = title
        contentView.backgroundColor = backgroundColor
    }
}
