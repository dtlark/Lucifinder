//
//  ImagePicker.swift
//  Lucifinder
//
//  Created by Jeremy Palavecino on 10/24/20.
//

import CoreImage
import CoreImage.CIImage
import CoreImage.CIImageProcessor
import CoreImage.CIFilterBuiltins
import CoreGraphics
import UIKit
import Foundation
import Photos
import FirebaseStorage
import Firebase

import SwiftUI

struct ImageTakerView: View {
    @State private var image: Image?
    @State private var image2: Image?
    
    @State private var url: URL?
    
    @State private var selection: String? = nil
    
    @State private var showingImagePicker = false
    @State private var showingLuciHome = false
    @State private var inputImage: UIImage?
    @State private var outputImage: UIImage?
    
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State private var luciFound = false
    @State private var firebase = false
    @State private var uploaded: Bool?
    
    var labelContainerView: UIView!
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            //LuciBrand()
            VStack {
                ZStack {
                    //if image is selected show image in box
                    if image2 != nil {
                        VStack {
                            HStack {
                                Button(action: {
                                    self.showingImagePicker = true
                                    //image = nil
                                    //image2 = nil
                                }) {
                                    HStack {
                                        Image(systemName: "camera")
                                            .font(.title)
                                        Text("Take New Photo")
                                    }
                                }
                                Spacer()
                                Button(action: {
                                    uploadToCloud()
                                    self.showAlert2 = true
                                    self.showingImagePicker = false
                                }) {
                                    HStack {
                                        Image(systemName: "archivebox")
                                            .font(.title)
                                        Text("Save To Firebase")
                                    }
                                }
                            }
                            GeometryReader { geo in
                            image2?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width, height: 400, alignment: .top)
                                //.scaledToFit()
                            }
                        }
                    }
                    //otherwise prompt user to select an image
                    else {
                        Text("Tap to take picture")
                            .foregroundColor(.blue)
                            .font(.headline)
                    }
                }
                //prompt the image selection process
                .onTapGesture {
                    self.showingImagePicker = true
                }
            }
            .padding([.horizontal, .bottom])
            //Pull up view that shows the user the photo library
            //Once an image is selected, prompt the image processing function - processImage
            .sheet(isPresented: $showingImagePicker, onDismiss: testOpenCV) {
                ImagePickerCamera(image: self.$inputImage, url: self.$url)
            }
            //Upon selection of an image, the application will begin processing the image.
            //While the processing is taking place, a temporary view (SwiftSpinner) will
            //appear notifying the user that the processing is taking place.
            .alert(isPresented: $showAlert) {
                SwiftSpinner.hide()
                if (luciFound)
                {
                    //notify the user that luciferin has been detected in the photo
                    
                    if ((wavelengths.lowerVal >= 551   && wavelengths.lowerVal <= 570) || (wavelengths.upperVal >= 551 && wavelengths.upperVal <= 570)) {
                       
                        return Alert(title: Text("Luciferin Detected!"), message: Text("Luciferin has been detected in the photo!"), dismissButton: .default(Text("Great!")))
                    }
                    else {
                    
                    return Alert(title: Text("Detected!"), message: Text("A value from your specified wavelength range has been detected in the photo!"), dismissButton: .default(Text("Great!")))
                    }
                }
                else
                {
                    if ((wavelengths.lowerVal >= 551   && wavelengths.lowerVal <= 570) || (wavelengths.upperVal >= 551 && wavelengths.upperVal <= 570)) {
                        
                        //notify the user that no luciferin has been detected in the photo
                    return Alert(title: Text("No Luciferin Detected..."), message: Text("Luciferin has not been detected in this photo"), dismissButton: .default(Text("Okay")))
                    } else {
                        
                        return Alert(title: Text("Not Detected..."), message: Text("A value from your specified wavelength range was NOT detected in the photo."), dismissButton: .default(Text("Okay")))
                        
                    }
                }
            }
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
    
    func uploadToCloud() {
        //print("In upload")
        self.uploaded = true
        
        let storage = Storage.storage()
        
        let data = Data()
        
        let storageRef = storage.reference()
        
        guard let localFile = url
        else { return }
        
        print(localFile.path)
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "y_MM_d_HH:mm:ss"
        let tempstring = formatter.string(from: today)
        let fileName = tempstring
        
        let photoRef = storageRef.child(fileName)
        
        photoRef.putFile(from: localFile, metadata: nil) { (metadata, err) in
            guard metadata != nil else {
                print(err?.localizedDescription as Any)
                print("Photo not uploaded")
                return
            }
            print("Photo uploaded")
        }
    }
    
    func testOpenCV() {
        guard let thisImage = inputImage
        else { return }
        
        image2 = Image(uiImage: thisImage)
        
        DispatchQueue.global(qos: .background).async {
            let testCV = OpenCVWrapper()
            //let picTest = testCV.imageProc(url?.path)
            let picTest = testCV.imageProc2(inputImage, lower: wavelengths.lowerVal, upper: wavelengths.upperVal)
            print(picTest)
            if (picTest == -1 || picTest == 0 || picTest == 1)
            {
                if (picTest == 0 || picTest == -1)
                {
                    self.luciFound = false
                }
                if (picTest == 1)
                {
                    self.luciFound = true
                }
                self.showAlert = true
            }
        }
        SwiftSpinner.show("Processing image...")
    }
}
