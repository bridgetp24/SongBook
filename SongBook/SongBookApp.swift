//
//  SongBookApp.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/7/22.
//

import SwiftUI

@main
struct SongBookApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)        }
    }
}
