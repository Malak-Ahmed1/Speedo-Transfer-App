import UIKit

class ProfileInfoVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PersonalInfoProtocol!
    var userInfo: [(title: String, info: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PersonalInfoPresenter(view: self)
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.loadUserInfo()
    }
    
    func displayUserInfo(userInfo: [(title: String, info: String)]) {
        self.userInfo = userInfo
        tableView.reloadData()
    }
}

extension ProfileInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath) as! ProfileInfoCell
        
        let userInfoItem = userInfo[indexPath.row]
        cell.title.text = userInfoItem.title
        cell.info.text = userInfoItem.info
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
