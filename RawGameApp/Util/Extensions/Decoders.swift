//
//  Decoders.swift
//  RawGameApp
//
//  Created by kamilcal on 24.01.2023.
//

import Foundation


extension String {
    func changeDateFormat() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyy-MM-dd"
        
        let originalDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: originalDate ?? Date())
    }
}
