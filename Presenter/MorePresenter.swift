// MorePresenter.swift
import Foundation
import UIKit

protocol MorePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectCell(at indexPath: IndexPath) -> UIViewController?
    func getMoreCellsCount() -> Int
    func getMoreCellData(at indexPath: IndexPath) -> MoreCellModel
}

class MorePresenter {
    private weak var view: MoreView?
    private var moreCellsArr: [MoreCellModel] = []

    init(view: MoreView) {
        self.view = view
    }
}

extension MorePresenter: MorePresenterProtocol {
    func viewDidLoad() {
        let models: [MoreCellModel] = [
            MoreCellModel(icon: UIImage(named: "TransferIcon"), title: "Transfer From Website"),
            MoreCellModel(icon: UIImage(named: "favourites"), title: "Favourites"),
            MoreCellModel(icon: UIImage(named: "user"), title: "Profile"),
            MoreCellModel(icon: UIImage(named: "help"), title: "Help"),
            MoreCellModel(icon: UIImage(named: "logout"), title: "Log Out")
        ]
        self.moreCellsArr = models
        view?.displayCells(with: models)
    }
    
    func didSelectCell(at indexPath: IndexPath) -> UIViewController? {
        switch indexPath.row {
        case 0:
            return nil
        case 1:
            return navigateToFavourites()
        case 2:
            return navigateToProfile()
        case 3:
            return navigateToHelp()
        case 4:
            return navigateToSignIn()
            
            
        default:
            return nil
        }
    }
    
    private func navigateToFavourites() -> UIViewController? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sb.instantiateViewController(withIdentifier: "FavouritesVC") as! FavouritesVC
        viewController.title = "Favourite"
        return viewController
    }
    
    private func navigateToProfile() -> UIViewController? {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let viewController = sb.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        viewController.title = "Profile"
        return viewController
    }
    
    private func navigateToHelp() -> UIViewController? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sb.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        return viewController
    }
    
    private func navigateToSignIn() -> UIViewController? {
        UserManager.shared.currentUser = nil
        let signInSB = UIStoryboard(name: "Main2", bundle: nil)
        let viewController = signInSB.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        return viewController
    }
    
    func getMoreCellsCount() -> Int {
        return moreCellsArr.count
    }
    
    func getMoreCellData(at indexPath: IndexPath) -> MoreCellModel {
        return moreCellsArr[indexPath.row]
    }
}
