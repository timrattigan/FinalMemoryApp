// Views/SpatialMemory/SpatialMemoryView.swift
import SwiftUI

struct SpatialMemoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Spatial Memory")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding()

            Text("""
            Enhance your spatial awareness and memory by engaging in Spatial Memory games.
            """)
                .font(.body)
                .foregroundColor(Color.secondaryTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            NavigationLink(destination: SpatialMemoryGameView()) {
                Text("Start Game")
                    .modifier(MenuButtonStyle())
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("Spatial Memory", displayMode: .inline)
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct SpatialMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        SpatialMemoryView()
    }
}
