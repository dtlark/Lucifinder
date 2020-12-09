//
//  ContentView.swift
//  Lucifinder
//
//  Created by Jeremy Palavecino on 11/16/20.
//

import SwiftUI
import Photos

struct wavelengths {
    static var lowerVal:Float = 551
    static var upperVal:Float = 570
}


struct ContentView: View {
    @State private var selection: String? = nil
    @State private var showingReadMe = false
    
  

    
    
    func alertView() {
        let alert = UIAlertController(title: "Set Wavelength", message: "Please enter a wavelength range to scan for in nanometers.", preferredStyle: .alert)
        alert.addTextField {lowerVal in lowerVal.placeholder = "Lower Vale (e.g. 551)"}
        
        alert.addTextField {upperVal in upperVal.placeholder = "Upper Vale (e.g. 570)"}

        
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel) { (_) in
            
            print("Cancel")
        }
        
        
        
        let setAction = UIAlertAction (title: "Set", style: .default) { (_) in
            print ("Set")
            let a:Float? = Float(alert.textFields![0].text!)
            let b:Float? = Float(alert.textFields![1].text!)
            wavelengths.lowerVal = a!
            wavelengths.upperVal = b!
            
            print(String(wavelengths.lowerVal))
            print(String(wavelengths.upperVal))
        }
        alert.addAction(cancelAction)
        alert.addAction(setAction)
       
        alert.preferredAction = setAction
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
    }
    
    var body: some View {
        LuciBrand()
        NavigationView {
            VStack {
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
                
                
                Button(action: {
                    alertView()
                    
                }) {
                    HStack {
                        Image(systemName: "gearshape")
                            .font(.title)
                        Text("Settings")
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
