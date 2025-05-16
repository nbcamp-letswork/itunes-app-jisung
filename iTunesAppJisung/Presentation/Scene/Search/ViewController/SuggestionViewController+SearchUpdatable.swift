extension SuggestionViewController: SearchUpdatable {
    func updateQuery(_ text: String) {
        searchViewModel.updateQuery(text)
    }
}
