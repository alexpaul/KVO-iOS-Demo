//
//  Settings.swift
//  KVO-iOS-Project
//
//  Created by Alex Paul on 4/7/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

// Settings needs to be KVO-compliant 
@objc class Settings: NSObject {
  static var shared = Settings()
  @objc dynamic var fontSize: Int // property marked for observing
  @objc dynamic var iconName: String
  override private init() {
    fontSize = 17
    iconName = "sun.haze.fill"
  }
}
