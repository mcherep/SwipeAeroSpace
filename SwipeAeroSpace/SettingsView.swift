import SwiftUI


struct SettingsView: View {
    @AppStorage("aerospace") private static var aerospace = "/opt/homebrew/bin/aerospace"
    @AppStorage("threshold") private static var swipeThreshold: Double = 1.0

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Form {
                TextField("AeroSpace", text: SettingsView.$aerospace)
//                TextField("Swipe Threshold", value: SettingsView.$swipeThreshold, format: .number)
                LaunchAtLogin.Toggle {
                    Text("Launch at login")
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
