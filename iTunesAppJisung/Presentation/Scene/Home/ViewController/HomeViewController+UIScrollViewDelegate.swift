import UIKit

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_: UIScrollView) {
        searchController.isActive = false
        searchController.searchBar.resignFirstResponder()
    }
}
