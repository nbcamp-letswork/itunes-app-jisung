import AVKit
import SnapKit
import UIKit

final class DetailViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let creatorNameLabel = UILabel()
    private let genreLabel = UILabel()
    private let infoStackView = UIStackView()
    private let releaseDateLabel = UILabel()
    var player: AVPlayer?
    private let avPlayerViewController = AVPlayerViewController()
    private let emptyMediaView = UIImageView()
    private let closeButton = CloseButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        configureBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        scrollView.setContentOffset(.zero, animated: false)
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground

        imageView.contentMode = .scaleAspectFit

        titleLabel.font = .boldSystemFont(ofSize: DetailConstant.Title.fontSize)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = DetailConstant.Title.numberOfLines

        creatorNameLabel.font = .systemFont(ofSize: DetailConstant.CreatorName.fontSize)
        creatorNameLabel.textColor = .systemOrange
        creatorNameLabel.textAlignment = .center

        genreLabel.font = .systemFont(ofSize: DetailConstant.Genre.fontSize)
        genreLabel.textColor = .secondaryLabel

        releaseDateLabel.font = .systemFont(ofSize: DetailConstant.ReleaseDate.fontSize)
        releaseDateLabel.textColor = .secondaryLabel

        infoStackView.axis = .horizontal
        infoStackView.distribution = .equalCentering
        infoStackView.alignment = .leading
        infoStackView.spacing = DetailConstant.StackView.labelSpacing

        addChild(avPlayerViewController)
        avPlayerViewController.didMove(toParent: self)
        avPlayerViewController.view.backgroundColor = .clear

        emptyMediaView.image = UIImage(systemName: "video.slash")
        emptyMediaView.contentMode = .scaleAspectFit
        emptyMediaView.tintColor = .secondaryLabel

        [scrollView, closeButton]
            .forEach { view.addSubview($0) }

        scrollView.addSubview(contentView)

        [
            imageView,
            titleLabel,
            creatorNameLabel,
            infoStackView,
            avPlayerViewController.view,
            emptyMediaView,
        ]
        .forEach { contentView.addSubview($0) }

        [genreLabel, releaseDateLabel]
            .forEach { infoStackView.addArrangedSubview($0) }
    }

    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        closeButton.snp.makeConstraints {
            $0.top.right.equalTo(view.safeAreaLayoutGuide).inset(DetailConstant.CloseButton.topRightSpacing)
            $0.size.equalTo(DetailConstant.CloseButton.size)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(DetailConstant.Title.topSpacing)
            $0.horizontalEdges.equalToSuperview()
        }

        creatorNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(DetailConstant.CreatorName.topSpacing)
            $0.horizontalEdges.equalToSuperview()
        }

        infoStackView.snp.makeConstraints {
            $0.top.equalTo(creatorNameLabel.snp.bottom).offset(DetailConstant.CreatorName.topSpacing)
            $0.centerX.equalToSuperview()
        }

        avPlayerViewController.view.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(DetailConstant.AVPlayer.topSpacing)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(DetailConstant.AVPlayer.bottomSpacing)
            $0.height.equalTo(avPlayerViewController.view.snp.width).multipliedBy(DetailConstant.AVPlayer.ratio)
        }

        emptyMediaView.snp.makeConstraints {
            $0.edges.equalTo(avPlayerViewController.view)
        }
    }

    private func configureBindings() {
        closeButton.onButtonTapped = { [weak self] in
            guard let self else { return }

            self.player?.pause()
            self.player = nil
            avPlayerViewController.player = nil
            self.dismiss(animated: true, completion: nil)
        }
    }

    func updateUI(media: Media) {
        imageView.kf.setImage(with: media.artworkURL) { [weak self] result in
            guard let self,
                  case let .success(value) = result
            else {
                return
            }

            let image = value.image
            let ratio = image.size.height / image.size.width

            self.imageView.snp.updateConstraints {
                $0.height.equalTo(self.imageView.snp.width).multipliedBy(ratio)
            }
        }
        titleLabel.text = media.title
        creatorNameLabel.text = media.creatorName
        genreLabel.text = media.genre
        releaseDateLabel.text = media.releaseDate

        if let url = media.previewURL {
            avPlayerViewController.view.isHidden = false
            emptyMediaView.isHidden = true

            player = AVPlayer(url: url)

            avPlayerViewController.player = player

            player?.play()
        } else {
            avPlayerViewController.view.isHidden = true
            emptyMediaView.isHidden = false
        }
    }
}
