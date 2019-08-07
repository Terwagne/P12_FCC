//
//  ExtensionsTestsCase.swift
//  FilmClubCannesTests
//
//  Created by ISABELLE Terwagne on 07/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import XCTest
@testable import FilmClubCannes

class ExtensionsTestsCase: XCTestCase {

    func testWhenTimeIsInt100_shouldReturn1h40() {
        let time2 = 100.convertIntToTime
        XCTAssertEqual(time2, "1h40")
    }
    
    func testWhenTimeIsInt30_shouldReturn30mn() {
        let time2 = 30.convertIntToTime
        XCTAssertEqual(time2, "30 mn")
    }
    
    let date: Date = {
        var components = DateComponents()
    components.year = 2019
    components.month = 9
    components.day = 10
    components.timeZone = TimeZone(secondsFromGMT: 0)
    return Calendar.current.date(from: components)!
 }()

func testConvertStringDateMardi10septembre2019_shouldReturn10092019() {
        let date = self.date
        let stringDate = "Mardi 10 Septembre 2019"
        let newDate = stringDate.convertStringDateToDate(stringDate: stringDate)
        XCTAssertEqual(newDate, date)
        
    }
}
