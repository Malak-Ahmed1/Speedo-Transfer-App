// ProfileVC.swift

import UIKit
class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileView {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameChar: UILabel!
    var presenter: ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter = ProfilePresenter(view: self)
        presenter.viewDidLoad()
        displayUserName((UserManager.shared.currentUser?.name)!)
        updateUserInitials(from: (UserManager.shared.currentUser?.name)!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayUserName((UserManager.shared.currentUser?.name)!)
        updateUserInitials(from: (UserManager.shared.currentUser?.name)!)
    }
    func displayUserName(_ name: String) {
        nameLabel.text = name
    }
    func updateUserInitials(from name: String) {
        let components = name.split(separator: " ")
        
        let initials = components.map { $0.prefix(1).uppercased() }.joined()
        
        userNameChar.text = initials
    }

      
    func updateTableView() {
        tableView.reloadData()
    }
    
    // TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.firstLabel.text = "Personal information"
            cell.secondLabel.text = "Your information"
            cell.profileImageView.image = UIImage(named: "personG")
            cell.actionBtn.setTitle("", for: .normal)
        case 1:
            cell.firstLabel.text = "Setting"
            cell.secondLabel.text = "Your information"
            cell.profileImageView.image = UIImage(named: "settingG")
            cell.actionBtn.setTitle("", for: .normal)
        case 2:
            cell.firstLabel.text = "Payment history"
            cell.secondLabel.text = "view your transactions"
            cell.profileImageView.image = UIImage(named: "payG")
            cell.actionBtn.setTitle("", for: .normal)
        case 3:
            cell.firstLabel.text = "My Favourite list"
            cell.secondLabel.text = "view your favourites"
            cell.profileImageView.image = UIImage(named: "favG")
            cell.actionBtn.setTitle("", for: .normal)
        default:
            break
        }
        
        return cell
    }
    
    // TableView Delegate Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped row \(indexPath.row)")
        
        switch indexPath.row {
        case 0:
            navigateToPersonalInfo()
        case 1:
            navigateToSettings()
        case 2:
            navigateToPaymentHistory()
        case 3:
            navigateToFavourites()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Navigation Methods
    func navigateToPersonalInfo() {
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let personalInfoVC = storyboard.instantiateViewController(withIdentifier: "ProfileInfoVC") as? ProfileInfoVC {
            navigationController?.pushViewController(personalInfoVC, animated: true)
        }
    }

    func navigateToSettings() {
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC {
            navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    func navigateToPaymentHistory() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let paymentHistoryVC = storyboard.instantiateViewController(withIdentifier: "TransactionsVC") as? TransactionsVC {
            navigationController?.pushViewController(paymentHistoryVC, animated: true)
        }
    }
    
    func navigateToFavourites() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let favouritesVC = storyboard.instantiateViewController(withIdentifier: "FavouritesVC") as? FavouritesVC {
            navigationController?.pushViewController(favouritesVC, animated: true)
        }
    }
}
