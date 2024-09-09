//
//  String+Trimmed.swift
//
//

import UIKit

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
