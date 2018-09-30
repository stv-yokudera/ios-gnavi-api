### MVP


---
## 構成

![mvp](https://user-images.githubusercontent.com/25205138/46253590-319af480-c4ba-11e8-87ca-a16147a64ebf.png)

---?code=MVP/ios-gnavi-api/ios-gnavi-api/View/Protocol/BaseView.swift

各Viewで共通で使用する処理を<br>BaseView Protocolに定義する。

---?code=MVP/ios-gnavi-api/ios-gnavi-api/View/AreaList/AreaListView.swift

特定のViewの固有の処理は、<br>それぞれのView Protocolに定義する。

---
### View Protocolに準拠した<br>Viewを実装する

ViewControllerクラスのextensionで<br>View Protocolに準拠する

```
extension AreaListViewController: AreaListView {
    
    func showError(message: String) {
        showSingleButtonAlert(title: "Error".localized(), message: message)
    }
    
    func reloadAreaList() {
        tableView.reloadData()
    }
    
    func transition(vc: RestaurantListViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
```

---?code=MVP/ios-gnavi-api/ios-gnavi-api/Presenter/Protocol/BasePresenter.swift

Viewを参照する処理、Viewをnilにする処理を<br>BasePresenter Protocolに定義する。

---?code=MVP/ios-gnavi-api/ios-gnavi-api/Presenter/AreaList/AreaListPresenter.swift

BasePresenter Protocolに準拠した<br>Presenterを実装する

---
### ModelのProtocolを定義する

```
/// エリア情報読み込み結果を通知するProtocol
public protocol AreasLoadResult: class {
    func loadSucceeded(areas: [Area])
    func loadFailed(errorMessage: String)
}
```

---
### Modelの実装をする

delegateを使用して、処理結果を<br>呼び出し元のpresenterに通知する。

```
/// エリア情報を読み込むクラス
final public class AreaListService {

    public init() {}

    public weak var delegate: AreasLoadResult?

    public func load(prefName: String = "東京都") {

        do {
            guard let jsonData = try JSONFileReader.read(fileName: Constants.areaJsonFileName) else {
                print("jsonData is nil.")
                delegate?.loadFailed(errorMessage: Constants.loadFailedMessage)
                return
            }

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let gAreaLarge = try jsonDecoder.decode(GAreaLarge.self, from: jsonData).gareaLarge else {
                print("gareaLarge is nil.")
                delegate?.loadFailed(errorMessage: Constants.loadFailedMessage)
                return
            }

            let areas = gAreaLarge.filter {
                $0.pref?.prefName == prefName
            }
            delegate?.loadSucceeded(areas: areas)

        } catch {
            print(error)
            delegate?.loadFailed(errorMessage: Constants.loadFailedMessage)
        }
    }
}
```
