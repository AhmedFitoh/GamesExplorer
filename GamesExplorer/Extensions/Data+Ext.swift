//
//  Data+Ext.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
}

extension StringProtocol {
    var html2String: String {
        return Data(utf8).html2AttributedString?.string ?? ""
    }
}
