//
//  SettingsVC.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 11/09/2024.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsView {

    @IBOutlet weak var tableView: UITableView!
    var presenter: SettingsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = SettingsPresenter(view: self)
        presenter?.viewDidLoad()
    }
    func updateTableView() {
           tableView.reloadData()
       }
       
    func navigateToChangePassword() {
        print("Navigating to Change Password screen")
        
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let changePasswordVC = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC {
            navigationController?.pushViewController(changePasswordVC, animated: true)
        }
    }

    func navigateToEditProfile() {
        print("Navigating to Edit Profile screen")
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC {
            navigationController?.pushViewController(editProfileVC, animated: true)
        }
    }

        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 2
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTableViewCell
           
           switch indexPath.row {
           case 0:
               cell.firstLabel.text = "Change password"
               cell.secondLabel.text = "Change password"
               cell.settingsImage.image = UIImage(named: "lock")
               cell.actionBtn.setTitle(">", for: .normal)
           case 1:
               cell.firstLabel.text = "Edit Profile"
               cell.secondLabel.text = "Change your information"
               cell.settingsImage.image = UIImage(named: "edit1")
               cell.actionBtn.setTitle(">", for: .normal)
           default:
               break
           }
           
           return cell
       }
       
       // MARK: - Table View Delegate Methods (optional)
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           presenter?.didSelectRow(at: indexPath)
       }
   }
