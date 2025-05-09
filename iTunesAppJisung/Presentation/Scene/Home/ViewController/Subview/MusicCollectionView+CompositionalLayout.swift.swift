import UIKit

extension MusicCollectionView {
    private typealias HCH = HomeConstant.Header
    private typealias HCF = HomeConstant.Footer
    private typealias HCC = HomeConstant.Carousel
    private typealias HCR = HomeConstant.Regular

    func createCompositionalLayout(using seasons: [Season]) -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }

            let season = seasons[sectionIndex]
            let isCarousel = season == .spring

            return isCarousel ? self.carouselSectionLayout() : self.regularSectionLayout()
        }
    }

    private func carouselSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(HCC.itemWidth),
            heightDimension: .fractionalHeight(HCC.itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(HCC.groupWidth),
            heightDimension: .absolute(HCC.groupHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [makeSectionHeader(), makeSectionFooter()]
        section.interGroupSpacing = HCC.groupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: HCC.topInset,
            leading: HCC.leadingInset,
            bottom: HCC.bottomInset,
            trailing: HCC.trailingInset
        )
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, offset, env in
            guard let self else { return }

            let centerX = offset.x + env.container.contentSize.width / 2

            guard let indexPath = visibleItems.min(by: {
                abs($0.frame.midX - centerX) < abs($1.frame.midX - centerX)
            })?.indexPath else {
                return
            }

            self.onCarouselChanged?(indexPath.item)
        }

        return section
    }

    private func regularSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(HCR.itemWidth),
            heightDimension: .fractionalHeight(HCR.itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: HCR.itemTopInset,
            leading: HCR.itemLeadingInset,
            bottom: HCR.itemBottomInset,
            trailing: HCR.itemTrailingInset
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(HCR.groupWidth),
            heightDimension: .absolute(HCR.groupHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: Array(repeating: item, count: 3)
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [makeSectionHeader()]
        section.interGroupSpacing = HCR.groupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: HCR.topInset,
            leading: HCR.leadingInset,
            bottom: HCR.bottomInset,
            trailing: HCR.trailingInset
        )

        return section
    }

    private func makeSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(widthDimension: .fractionalWidth(HCH.width), heightDimension: .absolute(HCH.height)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    private func makeSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(widthDimension: .fractionalWidth(HCF.width), heightDimension: .absolute(HCF.height)),
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
    }
}
