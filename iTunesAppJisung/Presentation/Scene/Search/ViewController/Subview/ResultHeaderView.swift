import UIKit

final class ResultHeaderView: UICollectionReusableView, ReuseIdentifier {
    var onButtonTapped: (() -> Void)?

    private let titleButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        titleButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        titleButton.setTitleColor(.label, for: .normal)
        titleButton.setTitleColor(.tertiaryLabel, for: .highlighted)
        titleButton.titleLabel?.font = .boldSystemFont(ofSize: ResultConstant.Header.fontSize)
        titleButton.titleLabel?.numberOfLines = 1
        titleButton.titleLabel?.lineBreakMode = .byTruncatingTail
        titleButton.contentHorizontalAlignment = .left

        addSubview(titleButton)

        titleButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(ResultConstant.Header.spacing)
            $0.verticalEdges.equalToSuperview()
        }
    }

    func updateUI(with title: String) {
        titleButton.setTitle(title, for: .normal)
    }

    @objc
    private func didButtonTapped() {
        onButtonTapped?()
    }
}
