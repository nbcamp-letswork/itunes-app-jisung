import Foundation

enum HomeConstant {
    enum Label {
        static let title = "Music"
        static let springTitle = "봄 Best"
        static let springSubTitle = "봄에 어울리는 음악 Best 5"
        static let summerTitle = "여름"
        static let summerSubTitle = "여름에 어울리는 음악"
        static let autumnTitle = "가을"
        static let autumnSubTitle = "가을에 어울리는 음악"
        static let winterTitle = "겨울"
        static let winterSubTitle = "겨울에 어울리는 음악"
    }

    enum Keyword {
        static let spring = "봄"
        static let summer = "여름"
        static let autumn = "가을"
        static let winter = "겨울"
    }

    enum SearchBar {
        static let placeholder = "영화, 팟캐스트"
    }

    enum Header {
        static let titleSize: CGFloat = 28
        static let subTitleSize: CGFloat = 16
        static let spacing: CGFloat = 4
        static let width: CGFloat = 1.0
        static let height: CGFloat = 60
    }

    enum Footer {
        static let cornerRadius: CGFloat = 8
        static let titleSize: CGFloat = 14
        static let artistSize: CGFloat = 12
        static let stackViewSpacing: CGFloat = 4
        static let leadingSpacing = 26
        static let imageSize = 32
        static let imageAndStackViewSpacing = 12
        static let width: CGFloat = 1.0
        static let height: CGFloat = 100
    }

    enum Carousel {
        static let itemCount = 5
        static let cornerRadius: CGFloat = 20
        static let iconName = "music.note"
        static let iconSize = 64
        static let itemWidth = 1.0
        static let itemHeight = 1.0
        static let groupWidth = 0.85
        static let groupHeight: CGFloat = 200
        static let groupSpacing: CGFloat = 20
        static let topInset: CGFloat = 16
        static let leadingInset: CGFloat = 16
        static let bottomInset: CGFloat = 0
        static let trailingInset: CGFloat = 16
    }

    enum Regular {
        static let cornerRadius: CGFloat = 16
        static let titleSize: CGFloat = 16
        static let artistSize: CGFloat = 14
        static let albumSize: CGFloat = 12
        static let stackViewSpacing: CGFloat = 2
        static let imageSize = 64
        static let imageAndLabelSpacing = 12
        static let itemWidth = 1.0
        static let itemHeight = 1.0
        static let itemTopInset: CGFloat = 0
        static let itemLeadingInset: CGFloat = 16
        static let itemBottomInset: CGFloat = 0
        static let itemTrailingInset: CGFloat = 0
        static let groupWidth = 0.85
        static let groupHeight: CGFloat = 260
        static let groupSpacing: CGFloat = 20
        static let topInset: CGFloat = 16
        static let leadingInset: CGFloat = 16
        static let bottomInset: CGFloat = 30
        static let trailingInset: CGFloat = 16
    }
}
