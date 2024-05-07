import SwiftUI

struct ContentView: View {
    var body: some View {

        ZStack(content: {
            Color.blue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("User Name")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("User Name")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("User Name")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("User Name")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("User Name")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("User Name")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            
        })
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SwiftUIView: View {
    var body: some View {
        ZStack {
            Color.pink
            Button("Hello, SwiftUI!") {
                
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("SwiftUI View")
    }
}
