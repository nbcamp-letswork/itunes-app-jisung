import SnapKit
import UIKit

final class SuggestionCell: UITableViewCell, ReuseIdentifier {
    private let iconImageView = UIImageView()
    private let suggestionLabel = UILabel()
    private let separator = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        iconImageView.image = UIImage(systemName: SuggestionConstant.Cell.iconName)
        iconImageView.tintColor = .secondaryLabel

        suggestionLabel.font = .systemFont(ofSize: SuggestionConstant.Cell.fontSize)

        separator.backgroundColor = .separator

        [iconImageView, suggestionLabel, separator]
            .forEach { contentView.addSubview($0) }

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(SuggestionConstant.Cell.iconLeadingSpacing)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(SuggestionConstant.Cell.iconSize)
        }

        suggestionLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(SuggestionConstant.Cell.labelSpacing)
            $0.trailing.verticalEdges.equalToSuperview().inset(SuggestionConstant.Cell.labelSpacing)
        }

        separator.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(SuggestionConstant.Cell.separatorSpacing)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(SuggestionConstant.Cell.separatorHeight)
        }
    }

    func updateUI(with suggestion: String) {
        suggestionLabel.text = suggestion
    }
}
