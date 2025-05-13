extension MainViewController: SuggestionViewControllerDelegate {
    func didSelectSuggestion(_ suggestion: String) {
        searchController.searchBar.text = suggestion

        handleSuggestionSelection(suggestion)
    }
}
