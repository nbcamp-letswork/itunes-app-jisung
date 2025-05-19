import UIKit

extension ResultViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return searchViewModel.searchSections.value.count
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let isEmpty = searchViewModel.searchSections.value[section].items.isEmpty

        return isEmpty ? 0 : 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ResultHeaderView.identifier,
            for: indexPath
        ) as? ResultHeaderView else {
            return UICollectionReusableView()
        }

        if indexPath.section == 0 {
            header.isHidden = false
            header.updateUI(with: searchViewModel.query.value)
            header.onButtonTapped = { [weak self] in
                self?.delegate?.didTapTitleButton()
            }
        } else {
            header.isHidden = true
        }

        return header
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = searchViewModel.searchSections.value[indexPath.section]
        let type = section.type

        if indexPath.section <= 1 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ResultSpotlightCell.identifier,
                for: indexPath
            ) as? ResultSpotlightCell else { return UICollectionViewCell() }

            let item = section.items[indexPath.item]

            cell.updateUI(with: item, title: type.spotlightTitle, backgroundColor: type.backgroundColor)

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ResultRemainingCell.identifier,
                for: indexPath
            ) as? ResultRemainingCell else { return UICollectionViewCell() }

            cell.updateUI(
                title: type.remainingTitle,
                numberOfItems: { section.items.count },
                itemProvider: { section.items[$0] },
                onButtonTapped: { [weak self] media in
                    self?.router?.trigger(.detail(media: media))
                }
            )

            return cell
        }
    }
}
