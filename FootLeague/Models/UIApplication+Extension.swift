//
//  UIApplication+Extension.swift
//  FootLeague
//
//  Created by Aristide LAUGA on 20/06/2023.
//

import UIKit

extension UIApplication {
  func dismissKeyboard() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
