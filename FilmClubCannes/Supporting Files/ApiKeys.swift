//
//  ApiKeys.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
func valueForAPIKey(named apiKey: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKey", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    let value = plist?.object(forKey: apiKey) as? String ?? ""
    return value
}
