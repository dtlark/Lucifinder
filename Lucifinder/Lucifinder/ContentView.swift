//
//  ContentView.swift
//  Lucifinder
//
//  Created by Alexandra Spector on 10/15/20.
//

import SwiftUI

struct AppContentView: View {
    @State var signInSuccess = false
    var body: some View {
        return Group {
            if signInSuccess {
                //ImagePicker()
                LuciHome()
            }
            else {
                ContentView(signInSuccess: $signInSuccess)
            }
        }
    }
}

struct ContentView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @Binding var signInSuccess: Bool
    
    var body: some View {
        VStack {
            LuciBrand()
            Spacer()
            VStack{
                HStack {
                    Text("Username")
                        .padding([.leading], 20.0)
                    TextField("Username", text: $userName)
                        .padding([.top, .leading, .bottom], 20.0)
                }
                HStack {
                    Text("Password ")
                        .padding([.leading], 20.0)
                    SecureField("Password", text: $password)
                        .padding([.top, .leading, .bottom], 20.0)
                }
                Button(action: {
                    if(userName == "User") {
                        if (password == "P@ssw0rd") {
                            self.signInSuccess = true
                        }
                    }
                    else {
                        self.showError = true
                    }
                }) {
                Text("Sign In")
                }
        
                if showError {
                Text("Incorrect username/password").foregroundColor(Color.red)
                }
            }
            Spacer()
        }
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(Image("Brand").resizable())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
