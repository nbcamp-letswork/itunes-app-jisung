import SnapKit
import UIKit

final class MusicSectionHeaderView: UICollectionReusableView, ReuseIdentifier {
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: HomeConstant.Header.titleSize)

        subTitleLabel.font = .systemFont(ofSize: HomeConstant.Header.subTitleSize)
        subTitleLabel.textColor = .secondaryLabel

        [titleLabel, subTitleLabel]
            .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(HomeConstant.Header.titleSize)
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(HomeConstant.Header.spacing)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }

    func updateUI(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
