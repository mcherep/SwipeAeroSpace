//
//  SwipeAeroSpaceApp.swift
//  SwipeAeroSpace
//
//  Created by Tricster on 1/25/25.
//

import SwiftUI

func requestAccessibilityPermission(completion: @escaping () -> Void) {
    let isAccessibilityPermissionGranted =
        PrivacyHelper.isProcessTrustedWithPrompt()
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

@available(macOS 14.0, *)
struct SettingsButton: View {
    @Environment(\.openSettings) private var openSettings

    var body: some View {
        Button("Settings") {
            openSettings()
        }
    }
}

@main
struct SwipeAeroSpaceApp: App {
    @AppStorage("menuBarExtraIsInserted") var menuBarExtraIsInserted = true
    @Environment(\.openWindow) private var openWindow

    init() {
        requestAccessibilityPermission {
            SwipeManager.start()
        }
    }

    var body: some Scene {
        MenuBarExtra(
            "Screenshots",
            image: "MenubarIcon",
            isInserted: $menuBarExtraIsInserted
        ) {
            Button("Next Workspace") {
                SwipeManager.nextWorkspace()
            }
            Button("Prev Workspace") {
                SwipeManager.prevWorkspace()
            }

            if #available(macOS 14.0, *) {
                SettingsButton()
            }
            else {
                Button(action: {
                    NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                }, label: {
                    Text("Settings")
                })
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
