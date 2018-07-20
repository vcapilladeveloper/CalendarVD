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
    public var id: Int
    public var date: String
    public var state: String
    public var state_id: Int
    // swiftlint:enable identifier_name
    public var link: String
    public var desc: String
}
