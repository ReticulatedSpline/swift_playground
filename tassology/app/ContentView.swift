import SwiftUI

struct ContentView: View {
    let teas = ["Black", "Green", "Herbal"]
    
    // @State allows SwiftUI to redraw the view when the value of teas is changed
    @State private var selectedTea  = "Black"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Selected Student", selection: $selectedTea) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Select a tea")
        }
    }
}

#Preview {
    ContentView() // Activate the view
}
