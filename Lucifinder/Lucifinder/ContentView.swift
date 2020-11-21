//
//  ContentView.swift
//  Lucifinder
//
//  Created by Jeremy Palavecino on 11/16/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: String? = nil
    
    var body: some View {
        LuciBrand()
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: CaptureImageView(), tag: "takePicture", selection: $selection) { EmptyView() }
                
                NavigationLink(destination: ImagePickerView(), tag: "chooseImage", selection: $selection) { EmptyView() }
                
                Button(action: {
                    self.selection = "takePicture"
                }) {
                    HStack {
                        Image(systemName: "camera")
                            .font(.title)
                        Text("Take Photo")
                    }
                }
                .frame(maxWidth: 145)
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(40)
                
                Button(action: {
                    self.selection = "chooseImage"
                }) {
                    HStack {
                        Image(systemName: "archivebox")
                            .font(.title)
                        Text("Choose Photo")
                    }
                }
                .frame(maxWidth: 145)
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(40)
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
