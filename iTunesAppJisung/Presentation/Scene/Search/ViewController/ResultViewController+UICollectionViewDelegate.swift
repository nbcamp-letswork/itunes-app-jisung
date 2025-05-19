import UIKit

extension ResultViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section

        switch section {
        case 0, 1:
            guard let media = searchViewModel.searchSections.value[section].items.first else { return }

            router?.trigger(.detail(media: media))
        default:
            let section = searchViewModel.searchSections.value[indexPath.section]

            router?.trigger(.remaining(
                title: section.type.remainingTitle,
                numberOfItems: { section.items.count },
                itemProvider: { section.items[$0] }
            ))
        }
    }
}
