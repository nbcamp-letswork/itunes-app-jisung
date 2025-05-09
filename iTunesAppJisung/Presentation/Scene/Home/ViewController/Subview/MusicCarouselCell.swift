import SnapKit
import UIKit

final class MusicCarouselCell: UICollectionViewCell, ReuseIdentifier {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        contentView.layer.cornerRadius = HomeConstant.Carousel.cornerRadius
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: HomeConstant.Carousel.iconName)

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(HomeConstant.Carousel.iconSize)
        }
    }

    func updateUI(backgroundColor: UIColor) {
        contentView.backgroundColor = backgroundColor
    }
}
