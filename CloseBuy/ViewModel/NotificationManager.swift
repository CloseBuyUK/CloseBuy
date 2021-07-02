//
//  NotificationManager.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 21/06/2021.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    init(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }
}
