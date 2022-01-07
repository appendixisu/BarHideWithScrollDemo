//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import CoreGraphics

class MyNavigationViewContoller: UINavigationController {
    override func loadView() {
        super.loadView()
        self.navigationBar.backgroundColor = .yellow
    }
}

class MyViewController : UIViewController {
    
    weak var myTableView: UITableView!
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 750, height: 1334))
        view.backgroundColor = .systemGray

        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        view.addSubview(tableView)
        self.view = view
        self.myTableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyTableView"
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(MyTableViewCell.self,
                             forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(view.frame)
        myTableView.frame = view.frame
    }
}

extension MyViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y / 150 > 1) {
            self.navigationController?.isNavigationBarHidden = true
        } else {
            self.navigationController?.isNavigationBarHidden = false
            var alhpa = scrollView.contentOffset.y / 150
            alhpa = 1 - ((alhpa) > 1 ? 1 : (alhpa < 0) ? 0 : alhpa)
            print(alhpa)
            self.navigationController?.navigationBar.alpha = alhpa
        }
    }
    
}

extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? MyTableViewCell {
            cell.titleLabel.text = "index: \(indexPath.row)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
}

class MyTableViewCell: UITableViewCell {
    weak var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: 200, height: 32))
        label.textColor = .black
        contentView.addSubview(label)
        
        titleLabel = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Present the view controller in the Live View window
let vc = MyNavigationViewContoller(rootViewController: MyViewController())
vc.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true
