import UIKit

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_: UIScrollView) {
        delegate?.scrollViewWillBeginDragging()
    }
}
