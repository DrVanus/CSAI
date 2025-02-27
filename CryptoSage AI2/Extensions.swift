//
//  Extensions.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//

import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
