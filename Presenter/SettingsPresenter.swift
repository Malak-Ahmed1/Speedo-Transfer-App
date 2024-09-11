//
//  SettingsPresenter.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 11/09/2024.
//

import Foundation

protocol SettingsView: AnyObject {
    func updateTableView()
    func navigateToChangePassword()
    func navigateToEditProfile()
}

class SettingsPresenter {
    
    weak var view: SettingsView?
    
    init(view: SettingsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        print("Settings screen opened")
        view?.updateTableView()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            view?.navigateToChangePassword()
        case 1:
            view?.navigateToEditProfile()
        default:
            break
        }
    }
}
