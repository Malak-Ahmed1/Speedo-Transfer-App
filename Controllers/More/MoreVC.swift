//
//  MoreVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit

class MoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    var moreCellsArr: [MoreCellModel] = []
    
    
    
    @IBOutlet weak var moreTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        moreTableView.delegate = self
        moreTableView.dataSource = self
        moreCellsArr.append(MoreCellModel.init(icon: UIImage.init(named: "TransferIcon"), title: "Transfer From Website"))
        moreCellsArr.append(MoreCellModel.init(icon: UIImage.init(named: "favourites"), title: "Favourites"))
        moreCellsArr.append(MoreCellModel.init(icon: UIImage.init(named: "user"), title: "Profile"))
        moreCellsArr.append(MoreCellModel.init(icon: UIImage.init(named: "help"), title: "Help"))
        moreCellsArr.append(MoreCellModel.init(icon: UIImage.init(named: "logout"), title: "Log Out"))
        
        
        moreTableView.register(UINib(nibName: "MoreTableCell", bundle: nil),
                               forCellReuseIdentifier: "MoreTableCell")
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreCellsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moreTableView.dequeueReusableCell(withIdentifier: "MoreTableCell", for: indexPath) as! MoreTableCell
        
        let data = moreCellsArr[indexPath.row]
        
        cell.setUpCell(image: data.icon!, title: data.title!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    private func tableView(_ tableView: UITableView, willDisplay cell: FavouriteListCell, forRowAt indexPath: IndexPath) {
        
        var frame = cell.contentView.frame
        frame.size.width = 343
        cell.contentView.frame = frame
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewControllerToPresent: UIViewController?
        
        switch indexPath.row {
        case 0:
           print("Transfer From Website")

        case 1:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            viewControllerToPresent = sb.instantiateViewController(withIdentifier: "FavouritesVC") as! FavouritesVC
            navigationController?.title = "Favourite"
                //To.Do: reload table
            
        case 2:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            viewControllerToPresent = sb.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC

        case 3:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            viewControllerToPresent = sb.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
           
                
            
        case 4:
            
            
            // To.Do: remove token
            
            
            let signInSB = UIStoryboard(name: "Main2", bundle: nil)
            viewControllerToPresent = signInSB.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC

        default:
            break
        }
        
        // Present the view controller modally with full-screen presentation
        if let viewController = viewControllerToPresent {
            if indexPath.row != 3 {  // check if not help sheet
            viewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(viewController, animated: true)
            self.navigationItem.backButtonTitle = ""


            } else {
                viewControllerToPresent?.modalPresentationStyle = .pageSheet
                if let sheet = viewControllerToPresent?.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.preferredCornerRadius = 50
                    
            }
                present(viewControllerToPresent!, animated: true)
           }
    }
     
        // Deselect the row after the action
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
     
 }

