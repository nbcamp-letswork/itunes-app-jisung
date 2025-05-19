import UIKit

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_: UIScrollView) {
        delegate?.scrollViewWillBeginDragging()
    }

    func collectionView(_: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        indexPath.section == 0
    }

    func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
        guard let media = homeViewModel.selectedMusic.value else { return }

        router?.trigger(.detail(media: media))
    }
}
