//
//  Time.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 29/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
extension Int {
    /// duringtime
    var convertIntToTime: String {
        let hrs = self / 60
        let min = self % 60
        return hrs > 0 ? String(format: "%1dh%02d mn", hrs, min) : String(format: "%1d mn", min)
    }
}

extension Date  {
    func convertStringDateToDate(stringDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "EEEE dd MMM yyyy"
        formatter.locale = Locale(identifier: "fr_FR")
        let dateFormatted: Date = formatter.date(from: stringDate)!
        return dateFormatted
    }
    
}
