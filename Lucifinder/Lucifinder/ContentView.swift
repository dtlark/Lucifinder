//
//  ContentView.swift
//  Lucifinder
//
//  Created by Jeremy Palavecino on 11/16/20.
//

import SwiftUI
import Photos

struct ContentView: View {
    @State private var selection: String? = nil
    @State private var showingReadMe = false
    
    var body: some View {
        LuciBrand()
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                NavigationLink(destination: ImageTakerView(), tag: "takePicture", selection: $selection) { EmptyView() }
                
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
                Button(action: {
                    self.showingReadMe = true
                    
                }) {
                    HStack {
                        Image(systemName: "text.justify")
                            .font(.title)
                        Text("ReadMe")
                    }
                }
                .frame(maxWidth: 145)
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(40)
            }
            .sheet(isPresented: $showingReadMe) {
                ReadMeView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

func checkPermissions() {
    print("here")
    if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
        PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()})
    }
    if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        
    }
    else {
        PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
    }
}

func requestAuthorizationHandler(status: PHAuthorizationStatus)
{
    if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        print("We have access to photos")
    }
    else {
        print("We don't have access")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
