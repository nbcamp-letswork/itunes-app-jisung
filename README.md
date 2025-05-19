# 프로젝트 개요
- 프로젝트명: 실전중심의 패턴 및 RxSwift 적용
- 개발 기간: 2025.05.07 ~ 2025.05.19
- 사용 기술: Swift, UIKit, Alamofire, Kingfisher, RxSwift, SnapKit, Swinject, XCoordinator

# 프로젝트 구조
```
iTunesAppJisung/
├── Application/
│   ├── DI/
│   │   └── AppDIContainer.swift
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Data/
│   ├── Model/
│   │   ├── MediaItem.swift
│   │   └── MediaResponse.swift
│   ├── Repository/
│   │   ├── DefaultFeedURLRepository.swift
│   │   └── DefaultMediaRepository.swift
│   ├── Source/
│   │   └── Remote/
│   │       ├── FetchMediaDataSource.swift
│   │       ├── RSSFeedParser.swift
│   │       └── RSSFeedParser+XMLParserDelegate.swift
│   └── DataConstant/
├── Domain/
│   ├── Entity/
│   │   ├── Media.swift
│   │   └── MediaType.swift
│   ├── Protocol/
│   │   ├── Repository/
│   │   │   ├── FeedURLRepository.swift
│   │   │   └── MediaRepository.swift
│   │   └── UseCase/
│   │       ├── FetchMediaUseCase.swift
│   │       └── ParseFeedURLUseCase.swift
│   └── Protocol/
│       ├── DefaultFetchMediaUseCase.swift
│       └── DefaultParseFeedURLUseCase.swift
├── Presentation/
│   ├── Model/
│   │   ├── MusicSection.swift
│   │   ├── SearchSection.swift
│   │   ├── SearchType.swift
│   │   └── Season.swift
│   └── Scene/
│       ├── Detail/
│       │   ├── ViewController/
│       │   │   └── DetailViewController.swift
│       │   ├── ViewModel/
│       │   │   └── DetailViewModel.swift
│       │   └── DetailConstant.swift
│       ├── Home/
│       │   ├── Coordinator/
│       │   │   ├── HomeCoordinator.swift
│       │   │   └── HomeRoute.swift
│       │   ├── ViewController/
│       │   │   ├── SubView/
│       │   │   │   ├── MusicCarouselCell.swift
│       │   │   │   ├── MusicCollectionView.swift
│       │   │   │   ├── MusicCollectionView+CompositionalLayout.swift
│       │   │   │   ├── MusicItemView.swift
│       │   │   │   ├── MusicRegularCell.swift
│       │   │   │   ├── MusicSectionFooterView.swift
│       │   │   │   └── MusicSectionHeaderView.swift
│       │   │   ├── HomeViewController.swift
│       │   │   ├── HomeViewController+UICollectionViewDataSource.swift
│       │   │   ├── HomeViewController+UICollectionViewDelegate.swift
│       │   │   └── HomeViewControllerDelegate.swift
│       │   ├── ViewModel/
│       │   │   └── HomeViewModel.swift
│       │   └── HomeConstant.swift
│       ├── Main/
│       │   ├── Coordinator/
│       │   │   ├── MainCoordinator.swift
│       │   │   └── MainRoute.swift
│       │   └── ViewController/
│       │       ├── MainViewController.swift
│       │       ├── MainViewController+HomeViewControllerDelegate.swift
│       │       ├── MainViewController+ResultViewControllerDelegate.swift
│       │       ├── MainViewController+SuggestionViewControllerDelegate.swift
│       │       └── MainViewController+UISearchBarDelegate.swift
│       ├── Search/
│       │   ├── Coordinator/
│       │   │   ├── ResultCoordinator.swift
│       │   │   ├── ResultRemainingCoordinator.swift
│       │   │   ├── ResultRemainingRoute.swift
│       │   │   └── ResultRoute.swift
│       │   ├── ViewController/
│       │   │   ├── SubView/
│       │   │   │   ├── ResultCollectionView.swift
│       │   │   │   ├── ResultHeaderView.swift
│       │   │   │   ├── ResultRemainingCell.swift
│       │   │   │   ├── ResultRemainingTableCell.swift
│       │   │   │   ├── ResultRemainingTableView.swift
│       │   │   │   ├── ResultRemainingTableView+UITableViewDataSource.swift
│       │   │   │   ├── ResultRemainingTableView+UITableViewDelegate.swift
│       │   │   │   ├── ResultSpotlightCell.swift
│       │   │   │   ├── SuggestionCell.swift
│       │   │   │   └── SuggestionTableView.swift
│       │   │   ├── ResultRemainingViewController.swift
│       │   │   ├── ResultViewController.swift
│       │   │   ├── ResultViewController+SearchUpdatable.swift
│       │   │   ├── ResultViewController+UICollectionViewDataSource.swift
│       │   │   ├── ResultViewController+UICollectionViewDelegate.swift
│       │   │   ├── ResultViewController+UICollectionViewDelegateFlowLayout.swift
│       │   │   ├── ResultViewControllerDelegate.swift
│       │   │   ├── SearchUpdatable.swift
│       │   │   ├── SuggestionViewController.swift
│       │   │   ├── SuggestionViewController+SearchUpdatable.swift
│       │   │   └── SuggestionViewControllerDelegate.swift
│       │   ├── ViewModel/
│       │   │   └── SearchViewModel.swift
│       │   ├── ResultConstant.swift
│       │   └── SuggestionConstant.swift
│       └── Shared/
│           ├── Util/
│           │   └── ReuseIdentifier.swift
│           └── View/
│               ├── CloseButton.swift
│               └── OpenButton.swift
└── Resource/
    ├── Assets.xcassets
    ├── Info.plist
    └── LaunchScreen.storyboard
```

## 재사용성 (Reusability)
상세 화면으로 진입하기 위한 `OpenButton`과 모달을 닫기 위한 `CloseButton`을 `Shared`로 분리하여 여러 화면에서 재사용

## 모듈화 (Modularity)
클린 아키텍처의 의존성 규칙에 따라 계층 분리

## 의존성 주입 (Dependency Injection)
Swinject를 통해 의존성 등록 및 주입

## 추상화 (Abstraction)
DIP를 준수하기 위해 Repository와 UseCase 추상화

## 사용성 UX(User Experience)
`ActivityIndicator`를 통해 검색 중 로딩 상태를 표시

# 트러블 슈팅
## RSS Feed 파싱 속도 지연 문제
- 문제 상황: 검색 결과에서 podcast 아이템의 `feedURL`을 파싱할 때 속도가 너무 느려 사용자 경험이 저하됨
- 원인 추론: `XMLParser`를 비동기적으로 여러개 동시 실행하면서 네트워크 병목 및 timeout 오류 발생
- 해결 방안: RSS 파싱을 검색 시점이 아닌 상세 화면 진입 시점으로 미루어 속도 개선

# 메모리 관리 분석
![스크린샷 2025-05-19 오후 1 27 09](https://github.com/user-attachments/assets/7ce1dc99-c340-49e5-b88a-b7071ec18e4f)
- `DetailViewController` 진입 시 Instruments(Leaks)에서 `1 new leak`이 감지됨
- 이후 동일 화면 재진입 시에는 `no new leak`으로 표시됨(새로운 누수는 발생하지 않음)
- AVPlayer에서 누수가 발생하는 것을 확인하였으나, 상세 원인은 아직 파악되지 않음
