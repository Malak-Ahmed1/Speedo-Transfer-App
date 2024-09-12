import UIKit

protocol CountrySelectionDelegate: AnyObject {
    func didSelectCountry(_ country: String)
}

class CountrySelectionVC: UIViewController {

    private let countries = ["United States", "Egypt", "Canada"]
    private let countryImages = [
        "United States": UIImage(named: "UnitedStates"),
        "Egypt": UIImage(named: "Egypt"),
        "Canada": UIImage(named: "Canada")
    ]

    weak var delegate: CountrySelectionDelegate?

    @IBOutlet weak var countriesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
    }

}

extension CountrySelectionVC: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountrySelectionCell else {
            return UITableViewCell()
        }

        // Set the country name and image
        let countryName = countries[indexPath.row]
        let countryImage = countryImages[countryName]

        // Configure the cell
        cell.configure(with: countryName, image: countryImage as! UIImage)
        
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
