extension MainViewController: ResultViewControllerDelegate {
    func didTapTitleButton() {
        searchController.isActive = false
        router?.trigger(.home)
    }
}
