//
//  glassMaterialExampleApp.swift
//  glassMaterialExample
//
//  Created by James Warren on 23/5/2024.
//

import SwiftUI

@main
struct glassMaterialExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
