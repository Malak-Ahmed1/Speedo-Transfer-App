import UIKit

protocol CountrySelectionDelegate: AnyObject {
    func didSelectCountry(_ country: String)
}

class CountrySelectionVC: UIViewController {

    private let countries = ["United States", "Egypt", "Canada"]
    weak var delegate: CountrySelectionDelegate?

    @IBOutlet weak var countriesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    private func setupTableView() {
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        countriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension CountrySelectionVC: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        return cell
    }

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countries[indexPath.row]
        delegate?.didSelectCountry(selectedCountry)
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
