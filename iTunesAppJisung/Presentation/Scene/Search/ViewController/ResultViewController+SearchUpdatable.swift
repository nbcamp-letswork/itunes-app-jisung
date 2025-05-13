extension ResultViewController: SearchUpdatable {
    func updateQuery(_ text: String) {
        searchViewModel.updateQuery(text)
    }
}
