//
//  UISearchBar.swift
//  RawGameApp
//
//  Created by kamilcal on 25.01.2023.
//

import UIKit

public extension UISearchBar {

    public func setNewcolor(color: UIColor) {
        let clrChange = subviews.flatMap { $0.subviews }
        guard let sc = (clrChange.filter { $0 is UITextField }).first as? UITextField else { return }
        sc.textColor = color
    }
}
