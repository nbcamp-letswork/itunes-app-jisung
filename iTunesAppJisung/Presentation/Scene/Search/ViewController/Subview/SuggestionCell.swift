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
        iconImageView.image = UIImage(systemName: SearchConstant.Suggestion.iconName)
        iconImageView.tintColor = .secondaryLabel

        suggestionLabel.font = .systemFont(ofSize: SearchConstant.Suggestion.fontSize)

        separator.backgroundColor = .separator

        [iconImageView, suggestionLabel, separator]
            .forEach { contentView.addSubview($0) }

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(SearchConstant.Suggestion.iconLeadingSpacing)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(SearchConstant.Suggestion.iconSize)
        }

        suggestionLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(SearchConstant.Suggestion.labelSpacing)
            $0.trailing.verticalEdges.equalToSuperview().inset(SearchConstant.Suggestion.labelSpacing)
        }

        separator.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(SearchConstant.Suggestion.separatorSpacing)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(SearchConstant.Suggestion.separatorHeight)
        }
    }

    func updateUI(with suggestion: String) {
        suggestionLabel.text = suggestion
    }
}
