import UIKit


class RewardsVC: UIViewController {
    @IBOutlet weak var earnedPointsLabel: UILabel!
    @IBOutlet weak var progressBar: CustomProgressBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        PointsManager.shared.rewardsVC = self
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    func updateUI() {
        earnedPointsLabel.text = "\(PointsManager.shared.totalPoints)"
        let progress = Float(PointsManager.shared.totalPoints) / 5000.0
        progressBar.setProgress(progress, animated: true)

        if PointsManager.shared.totalPoints >= 5000 {
            PointsManager.shared.setTotalPoints(0)
            showRewardNotification()
        }
    }

    private func showRewardNotification() {
        showAlert(title: "Congratulations!", message: "You've earned a reward!", okHandler: {
            self.dismiss(animated: true)
        }, cancelHandler: nil)
    }
}
