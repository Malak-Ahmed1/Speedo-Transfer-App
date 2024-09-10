//
//  PointsManager.swift
//  Speedo Transfer App
//
//  Created by 1234 on 10/09/2024.
//

import Foundation

class PointsManager {
    static let shared = PointsManager()
    private(set) var totalPoints = 0
    weak var rewardsVC: RewardsVC?

    private init() {}

    func incrementPoints(by amount: Int) {
        totalPoints += amount
        rewardsVC?.updateUI() // Notify view to update UI
    }
    func setTotalPoints(_ totalPoints: Int) {
        self.totalPoints = totalPoints
    }
}
