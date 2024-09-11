import Foundation

class PointsManager {
    static let shared = PointsManager()
    
    private(set) var totalPoints: Int = UserManager.shared.currentUser?.points ?? 0
    weak var rewardsVC: RewardsVC?

    private init() {}

    func incrementPoints(by amount: Int) {
        totalPoints += amount
        if let email = UserManager.shared.currentUser?.email {
            UserManager.shared.updatePoints(for: email, newPoints: totalPoints)
        }
        rewardsVC?.updateUI()
    }

    func setTotalPoints(_ totalPoints: Int) {
        self.totalPoints = totalPoints
        if let email = UserManager.shared.currentUser?.email {
            UserManager.shared.updatePoints(for: email, newPoints: totalPoints)
        }
    }
}
