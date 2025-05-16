extension MainViewController: SuggestionViewControllerDelegate {
    func didSelectSuggestion(_ suggestion: String) {
        handleSuggestionSelection(suggestion)
    }
}
