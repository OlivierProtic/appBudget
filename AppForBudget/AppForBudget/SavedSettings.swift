//
//  SavedSettings.swift
//  AppForBudget
//
//  Created by Olivier Rodrigue on 2021-06-05.
//

import Foundation
import UIKit

extension UserDefaults {
    // Currency
    private static let currencyKey = "currency_key"
    var currency: String {
        get { string(forKey: UserDefaults.currencyKey) ?? "" }
        set { set(newValue, forKey: UserDefaults.currencyKey) }
    }

    // Background color
    private static let backgroundColorKey = "background_color_key"
    var backgroundColor: UIColor? {
        get { color(forKey: UserDefaults.backgroundColorKey) }
        set { set(newValue, forKey: UserDefaults.backgroundColorKey) }
    }
}

// MARK: Extension to be able to save UIColor in UserDefaults

extension UserDefaults {
    func color(forKey key: String) -> UIColor? {
        guard let colorData = data(forKey: key) else { return nil }

        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch let error {
            print("color error \(error.localizedDescription)")
            return nil
        }
    }

    func set(_ value: UIColor?, forKey key: String) {
        guard let color = value else { return }

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
            set(data, forKey: key)
        } catch let error {
            print("error color key data not saved \(error.localizedDescription)")
        }

    }

}
