//
//  CalendarItemModel.swift
//  CalendarVD
//
//  Created by Victor Capilla Borrego on 6/6/18.
//  Copyright © 2018 Victor Capilla Borrego. All rights reserved.
//

import Foundation

public enum MyTheme {
    case light
    case dark
}

public struct CalendarItemModel: Codable {
    // swiftlint:disable identifier_name
    var id: Int
    var date: String
    var state: String
    var state_id: Int
    // swiftlint:enable identifier_name
    var link: String
    var desc: String
}
