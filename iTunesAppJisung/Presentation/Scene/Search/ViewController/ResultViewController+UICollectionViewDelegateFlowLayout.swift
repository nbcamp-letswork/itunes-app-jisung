import UIKit

extension ResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        section == 0 ? CGSize(width: collectionView.bounds.width, height: 60) : .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = searchViewModel.searchSections.value[indexPath.section]
        let items = section.items

        guard !items.isEmpty else {
            return .zero
        }

        if indexPath.section <= 1 {
            return CGSize(
                width: collectionView.bounds.width - ResultConstant.Spotlight.sectionVerticalSpacing,
                height: ResultConstant.Spotlight.sectionHeight
            )
        } else {
            let visibleCount = min(items.count, 5)
            let height = CGFloat(visibleCount)
                * ResultConstant.Remaining.tableCellHeight
                + ResultConstant.Remaining.headerHeight
                + ResultConstant.Remaining.sectionVerticalSpacing

            return CGSize(
                width: collectionView.bounds.width - ResultConstant.Remaining.sectionVerticalSpacing,
                height: height
            )
        }
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section > 1 else { return }

        let section = searchViewModel.searchSections.value[indexPath.section]

        router?.trigger(.remaining(
            title: section.type.remainingTitle,
            numberOfItems: { section.items.count },
            itemProvider: { section.items[$0] }
        ))
    }
}
