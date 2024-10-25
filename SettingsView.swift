// Views/Settings/SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @AppStorage("reduceAnimations") private var reduceAnimations: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Accessibility")) {
                Toggle("Reduce Animations", isOn: $reduceAnimations)
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
