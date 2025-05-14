import Kingfisher
import SnapKit
import UIKit

final class ResultRemainingTableCell: UITableViewCell, ReuseIdentifier {
    private let artworkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let creatorNameLabel = UILabel()
    private let openButton = OpenButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none

        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.clipsToBounds = true
        artworkImageView.layer.cornerRadius = ResultConstant.Remaining.imageCornerRadius

        titleLabel.font = .boldSystemFont(ofSize: ResultConstant.Remaining.fontSize)
        creatorNameLabel.font = .systemFont(ofSize: ResultConstant.Remaining.fontSize)
        creatorNameLabel.textColor = .secondaryLabel

        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.spacing = ResultConstant.Remaining.labelSpacing

        [artworkImageView, labelStackView, openButton]
            .forEach { contentView.addSubview($0) }

        [titleLabel, creatorNameLabel]
            .forEach { labelStackView.addArrangedSubview($0) }

        artworkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(ResultConstant.Remaining.imageSize)
        }

        labelStackView.snp.makeConstraints {
            $0.leading.equalTo(artworkImageView.snp.trailing).offset(ResultConstant.Remaining.stackViewLeading)
            $0.centerY.equalToSuperview()
        }

        openButton.snp.makeConstraints {
            $0.leading.equalTo(labelStackView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }
    }

    func updateUI(with media: Media) {
        artworkImageView.kf.setImage(with: media.artworkURL)
        titleLabel.text = media.title
        creatorNameLabel.text = media.creatorName
    }
}
