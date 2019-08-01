//
//  Date.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 31/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
extension Date {
    
    func convertStringDateToDate(stringDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        formatter.locale = Locale(identifier: "fr-FR")
        let dateFormatted: Date = formatter.date(from: stringDate)!
        return dateFormatted
        
}
}
