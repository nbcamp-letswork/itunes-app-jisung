extension MainViewController: HomeViewControllerDelegate {
    func scrollViewWillBeginDragging() {
        searchController.isActive = false
    }
}
