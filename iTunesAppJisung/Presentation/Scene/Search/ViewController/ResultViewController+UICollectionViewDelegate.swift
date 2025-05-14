import UIKit

extension ResultViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0, 1:
            break
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
