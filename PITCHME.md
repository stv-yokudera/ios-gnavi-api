### MVP


---
## 構成
![mvp](https://user-images.githubusercontent.com/25205138/46253103-8a649000-c4ae-11e8-89d1-81f9b72a9133.png)

---
### Viewプロトコルを定義する

各Viewで共通で使用する処理は、BaseViewプロトコルに定義する。

---?code=BaseView.swift

特定のViewの固有の処理は、それぞれのViewプロトコルに定義する。

---?code=AreaListView.swift

---
### Viewプロトコルに準拠したViewを実装する

ViewControllerクラスのextensionでViewプロトコルに準拠する

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

---
### BasePresenterプロトコルを定義する

BasePresenterプロトコルに以下を定義する。

- Viewを参照する処理
- Viewをnilにする処理

---?code=BasePresenter.swift

---
### BasePresenterプロトコルに準拠したPresenterを実装する

---?code=AreaListPresenter.swift

---
### Modelのプロトコルを定義する

```
/// エリア情報読み込み結果を通知するプロトコル
public protocol AreasLoadResult: class {
    func loadSucceeded(areas: [Area])
    func loadFailed(errorMessage: String)
}
```

---
### Modelの実装をする

delegateを使用して、処理結果を呼び出し元のpresenterに通知する。

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
