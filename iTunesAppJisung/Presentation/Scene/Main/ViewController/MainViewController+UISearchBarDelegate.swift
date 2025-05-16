import UIKit

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_: UISearchBar) {
        router?.trigger(.result)
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        searchController.isActive = false
        handleSuggestionInput("")
    }
}
