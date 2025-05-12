enum Season: CaseIterable {
    case spring,
         summer,
         autumn,
         winter

    var index: Int? {
        Season.allCases.firstIndex(of: self)
    }

    var keyword: String {
        switch self {
        case .spring: return HomeConstant.Keyword.spring
        case .summer: return HomeConstant.Keyword.summer
        case .autumn: return HomeConstant.Keyword.autumn
        case .winter: return HomeConstant.Keyword.winter
        }
    }

    var title: String {
        switch self {
        case .spring: return HomeConstant.Label.springTitle
        case .summer: return HomeConstant.Label.summerTitle
        case .autumn: return HomeConstant.Label.autumnTitle
        case .winter: return HomeConstant.Label.winterTitle
        }
    }

    var subTitle: String {
        switch self {
        case .spring: return HomeConstant.Label.springSubTitle
        case .summer: return HomeConstant.Label.summerSubTitle
        case .autumn: return HomeConstant.Label.autumnSubTitle
        case .winter: return HomeConstant.Label.winterSubTitle
        }
    }
}
