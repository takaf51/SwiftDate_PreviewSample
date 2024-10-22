//
//  _2_SwiftDataProjectApp.swift
//  12_SwiftDataProject
//
//  Created by Taka on 2024-10-22.
//

import SwiftUI
import SwiftData

@main
struct _2_SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
