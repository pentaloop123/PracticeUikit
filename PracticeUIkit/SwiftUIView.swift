import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                TextField("Username", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                Spacer()
                TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
            }
            .padding()

            Button(action: {
                // Add your action here
              
            }) {
                Text("User Name")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .padding()
            .cornerRadius(5.0)
        }
        .padding()
        .background(Color(.white))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
