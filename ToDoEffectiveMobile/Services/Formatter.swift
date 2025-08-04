//
//  Formatter.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 31.07.2025.
//

import Foundation

final class Formatter {
    static func formatTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: date)
    }
}
