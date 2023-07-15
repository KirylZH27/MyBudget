//
//  String+Converter.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation

extension String {
    func convertTextInDouble() -> Double {
        let textWithOutSpace = self.replacingOccurrences(of: " ", with: "")
        guard let number = Formatter.formatterFromDouble.number(from: textWithOutSpace) as? Double
                else {
                    return 0
                }
        return number
    }
}
