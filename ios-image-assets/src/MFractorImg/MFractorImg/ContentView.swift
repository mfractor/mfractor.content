import SwiftUI

struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome! Please Sign-in...")
                .padding()
            
            Image("devices")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            HStack {
                Image(systemName: "envelope")
                TextField("E-mail", text: $email)
            }.padding()
            
            HStack {
                Image(systemName: "lock")
                SecureField("Password", text: $password)
            }.padding()
                    
            Button("Sign-In") { // TODO: Implement
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
