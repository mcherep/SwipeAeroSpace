//
//  SwipeAeroSpaceApp.swift
//  SwipeAeroSpace
//
//  Created by Tricster on 1/25/25.
//

import SwiftUI

@main
struct SwipeAeroSpaceApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate


//    @StateObject var vm = ScreencaptureViewModel()
    @AppStorage("menuBarExtraIsInserted") var menuBarExtraIsInserted = true
    @Environment(\.openSettings) private var openSettings
    @Environment(\.openWindow) private var openWindow
    var body: some Scene {
        MenuBarExtra("Screenshots",
                     systemImage: "photo.badge.plus",
                     isInserted: $menuBarExtraIsInserted) {
            Button("Settings") {
                openSettings()
            }
            Button("About") {
                openWindow(id: "about")
            }
            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
        
        Settings {
            SettingsView()
        }.windowResizability(.contentSize)
        
        WindowGroup(id: "about") {
            AboutView()
        }.windowResizability(.contentSize)
    }
}
