import UIKit

final class OpenButton: UIButton {
    var onButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)

        setTitle("열기", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 16)

        backgroundColor = .quaternaryLabel
        layer.cornerRadius = 16
        clipsToBounds = true
    }

    @objc
    private func didButtonTapped() {
        onButtonTapped?()
    }
}
