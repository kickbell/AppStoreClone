# 포트폴리오 - AppStore 클론 앱

## 1. 개발 환경

- Xcode 14.3.1
- Deployment target iOS13 이상
- iTunes Search API
- [https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html#//apple_ref/doc/uid/TP40017632-CH3-SW1](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html#//apple_ref/doc/uid/TP40017632-CH3-SW1)
- SPM(의존성 관리도구)

## 2. 사용 오픈 소스

평소 라이브러리를 과하게 사용하는 편은 아닙니다. 결국엔 서드파티이고, 버전업 관련 이슈도 많이 겪어보았기 때문입니다. 하지만, 개발기간이나 편의성 등을 무시할 수는 없으므로 되도록 적게 사용하되 별 1천개 이상의 검증된 라이브러리만 주로 사용하였습니다.

- **ReactorKit, RxSwift(RxCoCoa)**: 아키텍쳐, 반응형 프로그래밍을 위한 사용
- **Cosmos** : 평점 뷰를 활용하기 위해 사용
- **Kingfisher**: 이미지 캐싱, 다운로드를 위해 사용
- **Swinject**: 의존성 주입을 위해 사용

## 3. 아키텍쳐 선정과 이유

1. 일단 주어진 `개발기간`이 짧았고, 참고화면으로 제공된 검색 탭의 UITableView으로 전체 가득 차있어 상대적으로 복잡한 아키텍쳐는 사용하지 않아도 될 것으로 판단했습니다. 
2. 기능 단위별로 Ribs을 만들어 모듈화하는 대형 프로젝트보다는 상대적으로 간편한 MVC, MVVM, ReactorKit 으로 방향이 정해졌고, 그 중에서 `사용해본 경험`도 있고 개인마다 각각인 MVVM+Rx와는 다르게 어느정도 템플릿이 지원된다는 점과 단방향 아키텍쳐라는 점을 기준으로 ReactorKit으로 구현하기로 하였습니다.
3. 다만 ReactorKit은 화면이동에 관한 라우팅의 작업은 없으므로 평소에 즐겨쓰던 Coordinator 패턴을 적용해서 최종적으로 ReactorKit-C의 아키텍쳐를 선정하게 되었습니다. 

## 4. UI 설계

### 검색화면

- 상단뷰는 NavagionBar + SearchController 로 구현하였습니다. 이건 실제로 앱스토어도 그렇게 구현되어 있고, 검색바의 디자인이 커스텀되지도 않은 상태이기도 해서 고민의 여지가 없었습니다.
- 테이블뷰에는 총 3가지 타입의 뷰가 보이는데요. 최근검색어, 검색중, 검색결과의 화면입니다. 코드에서는 DisplayItem 라는 타입으로 ItemType 열거형의 연관값을 사용해서 검색결과를 보여주거나 최근검색어를 보여주는 식으로 작업했습니다.
- 최근검색뷰와 검색 중 같은 경우, 기본 UITableViewCell의 이미지와 크게 다르지 않기 때문에 동작에 따라서 Label의 컬러값을 바꿔주고 cell.imageView에 검색 이미지를 넣어주는 식으로 따로 셀을 생성하지 않고 사용했습니다.
- 검색결과를 나타내는 SearchedTableViewCell 은 1개의 스택뷰에 AppIconListView와 ScreenshotsPreviewView를 vertical로 조합해서 구현되었습니다. 각 뷰들이 컴포넌트화 되어있어서 어디서든 재사용할 수 있습니다. ScreenshotsPreviewView는 스크롤되지않게 지정해서 상세화면에서도 재사용하고 있습니다.

<img src="https://velog.velcdn.com/images/dev_kickbell/post/77862374-c1e9-48f9-87a3-c73ee6dc59b7/image.PNG" width="300" height="600"/><img src="https://velog.velcdn.com/images/dev_kickbell/post/0a5c5ff8-870e-43cd-a67d-dd9328eb1f01/image.PNG" width="300" height="600"/>

### 상세화면

- 상세화면은 하나의 vertical stackview를 스크롤뷰가 감싸서 아래로만 스크롤링이 가능한 방식으로 구현되어 있습니다.  UITableView, UICollectionView 또는 iOS 13 부터 지원되는 새로운 레이아웃인 UICollectionViewCompositionalLayout 도 고려하였으나, 각 View를 언제든지 쉽게 빼고 넣을 수 있다는 점, 접근성을 적용했을때 axis의 변동으로 대응이 가능하다는 점, 스크린 샷 같은 경우 셀의 이미지 개수가 정해져있고 변경될 확률도 적다는 점등을 적용해서 구현 방향을 결정했습니다.
- 순서대로 AppIconDetailView, AppInfoDetailView, NewFeatureView, ShowMoreView, ScreenshotsPreviewView, ShowMoreView, SubtitleView 으로 스택뷰에 쌓여있으며 보시는 것처럼 ShowMoreView 같은 경우는 재사용이 되었고 ScreenshotsPreviewView 같은 경우도 검색화면에서 재사용되어 유용하게 동작하였습니다.
- 별개로 중간중간 구분선인 SeparatorView와 스택뷰의 빈공간을 조절하는 SpacerView 가 재사용되어 사용되고 있습니다.

<img src="https://velog.velcdn.com/images/dev_kickbell/post/f8cff7bb-3544-42a7-a761-3e489ab20086/image.PNG" width="300" height="600"/><img src="https://velog.velcdn.com/images/dev_kickbell/post/61dceb47-bfee-449b-a956-cd5a2e118934/image.PNG" width="300" height="600"/>

## 5. UI 재사용성, 컴포넌트화, 더보기

### 각각의 컴포넌트뷰들을 블록처럼 조립

UI를 작성할 때, 가장 중요하게 고려했던 부분은 `UI의 재사용성과 컴포넌트화` 입니다. 따라서 작성된 모든 뷰는 ComponentView 입니다. 화면을 그릴 때, 미리 작성된 ComponentView를 활용해서 `블록을 조립하듯이 재사용해서 쉽게 생성하도록 하는 것이 핵심`이었습니다. 

예를 들면, 아래의 코드와 그림을 볼까요. 코드는 현재 제가 구현한 앱스토어 상세화면의 뷰를 addSubview하는 로직 전체입니다.  마치 SwiftUI의 VStack을 연상시키는 구조이죠. 현재 상세화면에는 앱 아이콘뷰(appIconDetailView), 평점뷰(appInfoDetailView), 새로운 기능뷰(newFeatureView), 스크린샷뷰(screenshotsPreviewView), 앱설명뷰(descriptionView), 개발자뷰(subtitleView)가 있습니다. 

```swift
private func setupViews() {
		stackView.addArrangedSubviews([
        appIconDetailView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        appInfoDetailView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        newFeatureView,
        releaseNoteView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        screenshotsPreviewView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        descriptionView,
				SpacerView(),
        subtitleView,
    ])
    contentView.addSubview(stackView)
    scrollView.addSubview(contentView)
    view.addSubview(scrollView)
}
```

각 뷰들은 각각 컴포넌트화 되어있고, 자세히 보시면 새로운 기능뷰(newFeatureView)는 releaseNoteView 라는 뷰와 조합되어 ContainerView를 이루고 있습니다. 또, 앱설명뷰(descriptionView)와 개발자뷰(subtitleView)도 하나로 조합되어 ContainerView를 이루고 있지요. 각 컴포넌트 뷰들을 조합해서 하나의 큰 컨테이너뷰를 생성하는 것이죠. 

또한 스크린샷뷰(screenshotsPreviewView) 같은 경우에는 검색 탭의 테이블뷰 리스트에서 리스트 컨테이너뷰의 일부로 재사용되고 있습니다. 다른 컴포넌트뷰도 얼마든지 다른 화면에서 재사용 될 수 있죠.

### SeperatorView, SpacerView 들을 생성해서 적극 사용

마지막으로 스택뷰의 구성요소를 보면 눈에 띄는 것이 바로  SeperatorView 인데요. 말그대로 스택뷰의 구분선을 그려주기 위해 생성한 클래스 입니다. direction을 설정할 수 있게 하여 horizontal, vertical 에 대응되도록 하였습니다. 상세화면의 평점 뷰에서 SeparatorView의 horizontal 타입이 유용하게 재사용되고 있지요. 

```swift
private func setupViews() {
	  buttonsStackView.addArrangedSubviews([downloadButton, shareButton])
	  vStackView.addArrangedSubviews([titleLabel, subtitleLabel, SpacerView(for: .vertical), buttonsStackView])
	  totalStackView.addArrangedSubviews([iconImageView, vStackView])
	  addSubview(totalStackView)
}
```

SpacerView라는 컴포넌트 뷰도 있습니다. SpacerView는 스택뷰의 빈공간을 채워주기 위해 존재하는데요. space와 axis라는 2가지 매개변수가 있습니다. space 값을 넣으면 그 값만큼의 높이 값이 적용되게 되고, axis 값을 넣으면 ContentHugging과 CompressionResistance 가 해당 방향에 맞게 우선순위가 최저로 할당되어 SpacerView가 그만큼 늘어나게 되어 빈공간을 차지합니다. 

### 더 보기 애니메이션

더 보기를 누르면 레이블이 넓어지면서 가려졌던 레이블이 나오는 액션은 ShowMoreView 라는 컴포넌트 뷰에서 작성되었습니다. 어디든 ShowMoreView 를 추가하면 얼마든지 더 보기 기능을 쉽게 추가할 수 있습니다. 

핵심 로직은 의외로 매우 간단한데요. 처음에는 오토레이아웃의 isActive, priority 라던지 또는 스택뷰의 hidden 애니메이션 등 다양한 방법을 시도 했지만, 아래의 코드가 가장 간단하고 효과도 좋아서 사용하게 되었습니다. 

바로 label의 numberOfLines 속성을 사용하는 것인데요. 버튼을 탭하면 isExpanded 라는 플래그값을 바꿔주고 그 값에 따라서 numberOfLines 을 변경하는 것만으로 우아한 애니메이션을 완성하였습니다. 

```swift
@objc private func toggleExpand() {
    guard isExpanded == false else { return }
    isExpanded = true
    label.numberOfLines = isExpanded ? 0 : 6
    showMoreButton.isHidden = true
}
```

## 6. 비즈니스 로직

검색 탭에서 대표적인 비즈니스 로직을 찾으라면 리뷰갯수 포매팅, 릴리즈 노트 업로드 날짜, 네트워킹 등이 있을 겁니다. 

- **ReviewFormatter.swift** : 리뷰갯수 포매팅 로직
    - ReviewFormatter 라는 명확한 네이밍으로 표현
    - 휴먼 에러가 발생하지 않도록 숫자를 thousandLimit, tenThousandLimit의 상수값으로 선언
    - maximumFractionDigits 속성값을 사용해서 필요한 경우에만 1.2만과 같이 소수점 숫자를 추가
    - 테스트 코드 추가
- **ReleasesDateCalculator.swift :** 릴리즈 노트 업로드 날짜 계산 로직
    - dateFormatter, timeZone을 생성자 주입 받도록 해서 테스트에 용이하도록 설계됨
    - 날짜 문자를 Date 객체로 변환할 수 없을 때, 명확하게 **“알 수 없음”**을 리턴
    - (Calendar.Component, String) 를 정의하고 for 문으로 루프를 돌면서 단위를 반환하여 가독성 증가
- **Networks, AppSearchService.swift**
    - Networks 폴더에서는 EndPoint, HttpMethod 과 URLRequest 를 생성하고 파싱하는 로직이 추상화되어 있습니다. 따라서 사용하는 쪽에서는 AppSearch 폴더처럼 각 프로토콜을 준수해서 EndPoint를 정희하고 Request를 생성하고 간략하게 네트워킹을 요청하면 됩니다.
    - Networks를 SPM으로 만들어놓고 어디서든 import 해서 기존 코드는 수정하지 ㅇ낳고, 새로운 서비스를 만들면되니 OCP(개방폐쇄원칙)을 준수한다고 할 수 있을 것 같습니다.
    - 개발 기간상 작성하지는 못했으나 Network 프로토콜을 실제로 구현하는 NetworkImp 클래스에는 생성자로 URLSession을 바도록 지정되어있습니다. 이렇게 하면 아래와 같이 ephemeral 설정값과 MockURLProtocol 을 사용해서 가상의 데이터를 제공해서 네트워킹 유닛테스트를 진행할 수 있을 것 같습니다.
        
        ```swift
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        ```
        

## 7. 접근성

### Dynamic Font  적용

UIFont 값을 `한곳에서 관리`하고 `폰트값 변경에 유연하게 대처`하기 위해 유틸리티를 생성하였습니다. 이렇게 해두면 나중에 폰트값이 변경되어도 한 곳에서만 폰트 크기를 변경하면 되어 유지보수에 이점이 있습니다. 

또한, 접근성 대응에서도 Max, MinPointSize 를 지정하여 폰트가 너무 커질 경우 선제적으로 UI가 깨지는 것에 대응할 수 있습니다. 

```swift
import UIKit

struct FontStyle {
    var size: CGFloat
    var weight: UIFont.Weight
}

enum TextStyles {
    case title3
		//...
    var fontStyle: FontStyle {
        switch self {
        case .title3:
            return FontStyle(size: 20, weight: .regular)
				//...
        }
    }
}

extension UIFont {
    static func dynamicSystemFont(
        for style: TextStyles,
        minPointSize: CGFloat = 10.0,
        maxPointSize: CGFloat = 50.0
    ) -> UIFont {
        let font = UIFont.systemFont(ofSize: style.fontStyle.size, weight: style.fontStyle.weight)
        let metrics = UIFontMetrics(forTextStyle: .body)
        return metrics.scaledFont(for: font, maximumPointSize: maxPointSize, compatibleWith: nil)
    }
}
```

### Dynamic Font 최적화

폰트가 너무 커지는 경우 UILabel의 `intrinsicContentSize` 속성을 기준으로 `UIStackView의 axis`를 활용해서 horizontal 로 되어있는 UI를 vertical로 변경해서 접근성을 향상시켰습니다. 폰트 값이 바로 바뀔 수 있도록 `UIContentSizeCategory.didChangeNotification` 을 등록해서 바로 대응할 수 있도록 하였습니다. 

<img src="https://velog.velcdn.com/images/dev_kickbell/post/1a24efb5-14cd-4a34-a731-246a747f3ad2/image.PNG" width="300" height="600"/><img src="https://velog.velcdn.com/images/dev_kickbell/post/246d9800-66be-405c-995b-5932057ce7bc/image.PNG" width="300" height="600"/>

```swift
private func setupViews() {
    vStackView.addArrangedSubviews([titleLabel, subtitleLabel, SpacerView()])
    totalStackView.addArrangedSubviews([iconImageView, vStackView, downloadButton])
    addSubview(totalStackView)
}

@objc
private func handleContentSize() {
    titleLabel.font = UIFont.dynamicSystemFont(for: .title3b)
    subtitleLabel.font = UIFont.dynamicSystemFont(for: .caption1)
    
    let intrinsicContentWidth = titleLabel.intrinsicContentSize.width
    let screenWidth = UIScreen.main.bounds.width
    
    if intrinsicContentWidth > (screenWidth/2) {
        self.totalStackView.axis = .vertical
    } else {
        self.totalStackView.axis = .horizontal
    }
}
```

### VoiceOver 최적화

VoiceOver는 기본적으로 적용되는 기능과는 별개로 네트워크에 대한 응답같은 것들은 자동으로 적용되지 않죠. 따라서, `서버 통신을 완료`했다거나 하는 경우에는 그 `변경된 상태를 읽어주도록 구현`해서 최적화 하였습니다. 

```swift
reactor.state.map(\.displayItems)
    .do(onNext: { [weak self] items in
        if !items.isEmpty, let searchText = self?.searchController.searchBar.text {
            UIAccessibility.post(
                notification: .announcement,
                argument: "\(searchText)에 대한 \(items.count)개의 데이터가 로딩되었습니다."
            )
        }
    })
		.bind(to: tableView.rx.items) { (tableView, row, item) in
		.disposed(by: disposeBag)
```

또한, 받기, 버전 기록, 더 보기 같은 버튼의 경우도 기본 제공되는 VoiceOver 에서는 단어 그대로만 읽어주도록 되어있습니다. 이런 경우에도 정확히 어떤 앱에 대한 이벤트를 하는 것인지에 대한 값을 할당해서 사용자 경험을 개선할 수 있도록 최적화 시켰습니다. 

예를 들어, 아무 작업을 하지 않았다면 그냥 `“받기 버튼”` 이라고 읽어줄 때 아래와 같이 최적화를 진행해두면 `“카카오 뱅크 받기 버튼”`, `“카카오 뱅크의 새로운 기능 더보기”`, `“카카오 뱅크의 앱 설명 더보기”` 처럼 읽어주어 사용자 경험을 개선하였습니다. 

```swift
downloadButton.accessibilityLabel = "\(info.trackName) 받기"
newFeatureView.versionHistoryButton.accessibilityLabel = "\(info.trackName)의 버전 기록"
releaseNoteView.text = info.releaseNotes
releaseNoteView.showMoreButton.accessibilityLabel = "\(info.trackName)의 새로운 기능 더보기"
descriptionView.showMoreButton.accessibilityLabel = "\(info.trackName)의 앱 설명 더보기"
```

### 다크 모드 대응

앱스토어 화면 디자인의 특성상 `Color Set` 을 사용할 기회는 없었으나, 사용할 줄은 압니다. 또한, iOS 13 부터 적용된 Dynamic Color 값인  ****`systemBackground, systemBlue, label, secondaryLabel` 를 적극 활용해서 다크모드에 대응하였습니다. 자세한 대응은 `별첨된 동작 영상`을 첨부하겠습니다. 

## 8. POP(프로토콜 지향 프로그래밍)

최근 검색어를 불러오는 로직을 프로토콜을 사용해서 추상화하였습니다.

```swift
protocol RecentSearchService {
    func read() -> [String]
    func create(text: String) -> String
}

class RecentSearchServiceImp: RecentSearchService {
    private let repository: Storable
    
    init(repository: Storable) {
        self.repository = repository
    }
    
    func read() -> [String] {//...}

    func create(text: String) -> String {//...}
}

protocol Storable {
    func read() -> [String]
    func save(todos: [String])
}

class UserDefaultService: Storable {
    typealias RecentSearchType = String
    
    private let key = String(describing: RecentSearchType.self)
    private var database: UserDefaults { UserDefaults.standard }
    
    func read() -> [RecentSearchType] {//...}
    
    func save(todos: [RecentSearchType]) {//...}
}
```

만약 최근검색어를 `앱 내부 DB인 UserDefault 에 저장하는 정책`에서 `서버에 저장하는 정책`으로 바뀐다고 하여도 Storable 프로토콜을 준수하는 ServerRepositoryService 를 클래스를 생성하고 내부 구현을 한 뒤 `해당 클래스로 교체`만 해주면 되므로 변화에 매우 유연합니다. 

```swift
class ServerRepositoryService: Storable {
    func load() -> [ToDo] {...}
    func save(todos: [ToDo]) {...}
}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //container.register(Repository.self) { _ in UserDefaultRepository() }
    container.register(Repository.self) { _ in ServerRepository() }
    container.register(ToDoService.self) { c in
        let repository = c.resolve(Repository.self)!
        return ToDoServiceImpl.init(repository: repository)
    }
    return true
}
```

## 9. 유닛테스트

**DoubleRoundingTests**, **ReviewFormatterTests**, **ReleaseDateCalculatorTests** 의 비즈니스로직에 대한 유닛 테스트가 작성되어 있습니다. 네트워킹 테스트도 하면 좋았겠지만, 개발 시간상 작성하지 못했습니다. 만약 작성했다면 대략적인 작성 방법은 `5. 비즈니스로직` - `Networks, AppSearchService.swift` 처럼 작성했을 것입니다. 

## 10. 개발하면서 겪은 이슈, 개선사항

### 1. SPM으로 모듈화

현재 폴더 구조는 크게 **Utils, ComponentViews, Networks, Screens, Coordinator** 으로 나뉘어져 있습니다. 그리고 여기서 뷰의 이동을 담당하는 Coordinator와 직접 화면을 그리는 틀인 Screens을 제외하고는 전부 각 SPM으로 모듈화를 해도 좋았을 겁니다. 실제로 카카오 뱅크에서도 ifkakao2022, **카카오뱅크 iOS 프로젝트의 모듈화 여정: Tuist를 활용한 모듈 아키텍처 설계 사례**에서 그렇게 설명하신 것으로 알고 있어요. 시간이 부족해서 모듈화까지는 하지 못했으나 중점적으로 개선하고 싶은 사항입니다.  ****

### 2. numberOfLine을 통한 간단한 애니메이션

위에서도 잠시 언급했지만, 상세화면의 더 보기 기능을 구현하기 위해 오토레이아웃의 isActive, priority 속성과 stackview.ishidden 애니메이션 등 다양한 시도를 했었습니다. 각자의 장단점이 있었고 애니메이션이 이상하게 동작한다거나 그런 부분도 있어서 결국에는 UILabel의 numberOfLine 값으로 해결을 했어요. 하나의 기능을 구현하기 위해 여러가지시도를 해보는 점이 참 재미있었고 코드는 더 간결해지고, 더 명료해져서 좋았습니다. 

### 3. Kingfisher의 UIImageView+Extension에 대한 생각

킹피셔는 아래와 같이 UIImageView에 대한 확장을 제공하지요. 그런데 생각해보니 저 방식이 View에 이미지를 로딩하는 비즈니스로직을 넘기는 것으로 보이더라구요. 그전에는 인터페이스를 참 편하게 해놨다는 생각에 사용했던 것인데, 이번에 사용해보니 좀 다르게 보였습니다. 

```swift
imageView.kf.setImage(with: URL(string: imageURL))
```

물론 킹피셔 내부에서도 이미지를 다운로드하는 Downloader, 메모리나 디스크캐시를 관리하는 ImageCache 등이 있어서 그쪽에서 이미지를 다운로드하는 동작을 하겠지만 저 인터페이스 자체가 그냥 뷰에게 비즈니스로직을 전가하는 느낌이었습니다. 

그래서 다음에 킹피셔를 사용할 일이 있으면 아래와 같이 KingfisherManager 를 사용해서 이미지를 로딩하는 ImageLoader 클래스를 생성하고 ViewModel이나 Reactor에서는 일단 뷰를 그리는데 필요한 다른 ViewModel의 항목들은 먼저 리턴하고, 이미지가 비동기적으로 다운로드되다가 완료되면 순차적으로 이미지를 방출해서 UI를 업데이트 하는 식으로 바꿔서 사용할 생각입니다.  

```swift
import Combine
import Kingfisher

class ViewModel {
    private let imageLoader = ImageLoader()
    private var cancellables: Set<AnyCancellable> = []

    var imagePublisher: AnyPublisher<UIImage?, Never> {
        return imageLoader.imagePublisher
            .eraseToAnyPublisher()
    }

    func loadImage() {
        imageLoader.loadImage()
    }
}

class ImageLoader {
    private let imageSubject = PassthroughSubject<UIImage?, Never>()

    var imagePublisher: AnyPublisher<UIImage?, Never> {
        return imageSubject.eraseToAnyPublisher()
    }

    func loadImage() {
        let imageUrl = URL(string: "https://example.com/image.jpg")!
        KingfisherManager.shared
            .retrieveImage(with: imageUrl)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { image in
                    self.imageSubject.send(image)
                  })
            .store(in: &cancellables)
    }
}
```
