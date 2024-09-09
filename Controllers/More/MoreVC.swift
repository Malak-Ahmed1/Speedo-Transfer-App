//
//  MoreVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit

protocol MoreView: AnyObject {
    func displayCells(with models: [MoreCellModel])
}

class MoreVC: UIViewController, MoreView {
    
    private var presenter: MorePresenterProtocol!
    
    
    @IBOutlet weak var moreTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCell()
        presenter = MorePresenter(view: self)
        presenter.viewDidLoad()
    }
    
    func setUpCell() {
        moreTableView.delegate = self
        moreTableView.dataSource = self
        
        moreTableView.register(UINib(nibName: "MoreTableCell", bundle: nil),
                               forCellReuseIdentifier: "MoreTableCell")
    }
    func displayCells(with models: [MoreCellModel]) {
        moreTableView.reloadData()
    }

    
    @IBAction func backBtnClicked(_ sender: Any) {
            tabBarController?.selectedIndex = 0
        }
    
}

extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getMoreCellsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreTableView.dequeueReusableCell(withIdentifier: "MoreTableCell", for: indexPath) as! MoreTableCell
        let data = presenter.getMoreCellData(at: indexPath)
        
        if let icon = data.icon, let title = data.title {
            cell.setUpCell(image: icon, title: title)
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              if let viewControllerToPresent = presenter.didSelectCell(at: indexPath) {
                  if indexPath.row != 3 {  // Not help sheet
                      viewControllerToPresent.modalPresentationStyle = .fullScreen
                      navigationController?.pushViewController(viewControllerToPresent, animated: true)
                      navigationItem.title = ""
                  } else {
                      viewControllerToPresent.modalPresentationStyle = .pageSheet
                      if let sheet = viewControllerToPresent.sheetPresentationController {
                          sheet.detents = [.medium()]
                          sheet.preferredCornerRadius = 50
                      }
                      present(viewControllerToPresent, animated: true)
                  }
              }
              tableView.deselectRow(at: indexPath, animated: true)
          }
    
}
