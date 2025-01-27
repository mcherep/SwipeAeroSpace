//
//  SwipeAeroSpaceApp.swift
//  SwipeAeroSpace
//
//  Created by Tricster on 1/25/25.
//

import SwiftUI


func requestAccessibilityPermission(completion: @escaping ()->()) {
    let isAccessibilityPermissionGranted = PrivacyHelper.isProcessTrustedWithPrompt()
    debugPrint("Accessibility permission", isAccessibilityPermissionGranted)
    if isAccessibilityPermissionGranted {
        completion()
    } else {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if AXIsProcessTrusted() {
                debugPrint("Accessibility permission granted")
                timer.invalidate()
                completion()
            }
        }
    }
}

@main
struct SwipeAeroSpaceApp: App {
//    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

    init() {
        requestAccessibilityPermission() {
            SwipeManager.start()
        }
    }

    @AppStorage("menuBarExtraIsInserted") var menuBarExtraIsInserted = true
    @Environment(\.openSettings) private var openSettings
    @Environment(\.openWindow) private var openWindow
    var body: some Scene {
        MenuBarExtra("Screenshots",
                     image: "MenuBarIcon",
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
