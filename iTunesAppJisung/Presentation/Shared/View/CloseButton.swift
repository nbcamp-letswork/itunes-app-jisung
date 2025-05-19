import UIKit

final class CloseButton: UIButton {
    var onButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        guard let xmarkImage = UIImage(systemName: "xmark") else { return }
        let configuration = UIImage.SymbolConfiguration(weight: .heavy)
        setImage(xmarkImage.withConfiguration(configuration), for: .normal)
        tintColor = .tertiarySystemBackground
        backgroundColor = .secondaryLabel
        layer.cornerRadius = 18
        layer.masksToBounds = true
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }

    @objc
    private func didButtonTapped() {
        onButtonTapped?()
    }
}
