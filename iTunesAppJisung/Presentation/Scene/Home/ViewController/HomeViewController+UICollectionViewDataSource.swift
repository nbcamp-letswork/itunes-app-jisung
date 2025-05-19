import UIKit

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        homeViewModel.musicSections.value.count
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = homeViewModel.musicSections.value[section]

        switch section.season {
        case .spring:
            return section.musics.count
        default:
            let count = section.musics.count
            return count / 3 + (count % 3 == 0 ? 0 : 1)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = homeViewModel.musicSections.value[indexPath.section]
        let musics = section.musics

        switch section.season {
        case .spring:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MusicCarouselCell.identifier,
                for: indexPath
            ) as? MusicCarouselCell else {
                return UICollectionViewCell()
            }

            let index = indexPath.item

            let isEven = index % 2 == 0

            let yellow = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
            let peach = UIColor(red: 1.0, green: 0.5, blue: 0.4, alpha: 1.0)

            let backgroundColor: UIColor = isEven ? yellow : peach
            cell.updateUI(backgroundColor: backgroundColor)

            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MusicRegularCell.identifier,
                for: indexPath
            ) as? MusicRegularCell else {
                return UICollectionViewCell()
            }

            let startIndex = indexPath.item * 3
            let endIndex = min(startIndex + 3, musics.count)
            let musics = Array(musics[startIndex ..< endIndex])

            cell.updateUI(with: musics) { [weak self] media in
                self?.router?.trigger(.detail(media: media))
            }

            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MusicSectionHeaderView.identifier,
                for: indexPath
            ) as? MusicSectionHeaderView else {
                return UICollectionReusableView()
            }

            let season = homeViewModel.musicSections.value[indexPath.section].season
            header.updateUI(title: season.title, subTitle: season.subTitle)

            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MusicSectionFooterView.identifier,
                for: indexPath
            ) as? MusicSectionFooterView else {
                return UICollectionReusableView()
            }

            let section = homeViewModel.musicSections.value[indexPath.section]
            if section.season == .spring, let selectedMusic = homeViewModel.selectedMusic.value {
                footer.updateUI(with: selectedMusic)
            }

            return footer
        default:
            return UICollectionReusableView()
        }
    }
}
