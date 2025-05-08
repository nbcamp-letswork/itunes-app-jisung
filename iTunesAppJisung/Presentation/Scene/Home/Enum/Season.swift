enum Season: CaseIterable {
    case spring,
         summer,
         autumn,
         winter

    var keyword: String {
        switch self {
        case .spring: return HomeConstant.Keyword.spring
        case .summer: return HomeConstant.Keyword.summer
        case .autumn: return HomeConstant.Keyword.autumn
        case .winter: return HomeConstant.Keyword.winter
        }
    }

    var header: String {
        switch self {
        case .spring: return HomeConstant.Label.spring
        case .summer: return HomeConstant.Label.summer
        case .autumn: return HomeConstant.Label.autumn
        case .winter: return HomeConstant.Label.winter
        }
    }
}
