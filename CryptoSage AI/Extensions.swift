//
//  Extensions.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

#if canImport(UIKit)
import UIKit

extension UIApplication {
    func endEditing() {
        #if targetEnvironment(macCatalyst)
        // On Mac Catalyst, do nothing
        #else
        // On iOS, dismiss the keyboard
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
        #endif
    }
}
#endif
