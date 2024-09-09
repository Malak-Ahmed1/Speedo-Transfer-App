import UIKit

protocol FavouritesEditView: FavouritesView {
    func presentEditViewController(for recipient: FavouriteRecipient, at indexPath: IndexPath)
    func removeFavourite(at indexPath: IndexPath)
    func updateFavourite(at indexPath: IndexPath)
}

class FavouritesVC: UIViewController, FavouritesView, FavouritesEditView {

    @IBOutlet weak var favouriteListTable: UITableView!
    var presenter: FavouritesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        presenter = FavouritesPresenter(view: self)
        presenter.getFavourites()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavourites()
    }
    
    func setUpTable() {
        favouriteListTable.delegate = self
        favouriteListTable.dataSource = self
        favouriteListTable.register(UINib(nibName: "FavouritesCell", bundle: nil), forCellReuseIdentifier: "FavouritesCell")
    }
     
    func displayFavourites() {
        DispatchQueue.main.async { [weak self] in
            self?.favouriteListTable.reloadData()
        }
    }
    
    func showError(message: String) {
        print(message)
    }
    
    func presentEditViewController(for recipient: FavouriteRecipient, at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let editVC = storyboard.instantiateViewController(withIdentifier: "EditVC") as? EditVC else {
            print("Error: EditVC not found")
            return
        }

        editVC.recipient = recipient

        editVC.onSave = { [weak self] updatedRecipient in
            self?.presenter.editFavourite(at: indexPath, with: updatedRecipient)
            self?.updateFavourite(at: indexPath)
        }

        editVC.modalPresentationStyle = .pageSheet
        if let sheet = editVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 50
        }

        present(editVC, animated: true)
    }

    func removeFavourite(at indexPath: IndexPath) {
        favouriteListTable.beginUpdates()
        favouriteListTable.deleteRows(at: [indexPath], with: .automatic)
        favouriteListTable.endUpdates()
    }

    func updateFavourite(at indexPath: IndexPath) {
        favouriteListTable.performBatchUpdates({
            favouriteListTable.reloadRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }
}

extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getFavouritesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteListTable.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! FavouritesCell
        let data = presenter.getFavouritesArr()[indexPath.row]
        cell.setUpCell(userName: data.userName!, accountNumber: data.accountNumber!)
        cell.backgroundColor = .clear

        // Configure actions
        cell.deleteAction = { [weak self] in
            self?.presenter.didTapDeleteButton(on: indexPath)
        }
        cell.editAction = { [weak self] in
            self?.presenter.didTapEditButton(on: indexPath)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}
