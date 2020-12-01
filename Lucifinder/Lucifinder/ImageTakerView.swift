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

import SwiftUI

struct ImageTakerView: View {
    @State private var image: Image?
    @State private var image2: Image?
    
    @State private var selection: String? = nil
    
    @State private var showingImagePicker = false
    @State private var showingLuciHome = false
    @State private var inputImage: UIImage?
    @State private var outputImage: UIImage?
    
    @State private var showAlert = false
    @State private var luciFound = false
    
    var labelContainerView: UIView!
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            //LuciBrand()
            VStack {
                ZStack {
                    //if image is selected show image in box
                    if image2 != nil {
                        GeometryReader { geo in
                            image2?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width, height: 400, alignment: .top)
                                //.scaledToFit()
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
            .sheet(isPresented: $showingImagePicker, onDismiss: processImage) {
                ImagePickerCamera(image: self.$inputImage)
            }
            //Upon selection of an image, the application will begin processing the image.
            //While the processing is taking place, a temporary view (SwiftSpinner) will
            //appear notifying the user that the processing is taking place.
            .alert(isPresented: $showAlert) {
                SwiftSpinner.hide()
                if (luciFound)
                {
                    //notify the user that luciferin has been detected in the photo
                    return Alert(title: Text("Luciferin Detected!"), message: Text("Luciferin has been detected in the photo!"), dismissButton: .default(Text("Great!")))
                }
                else
                {
                    //notify the user that no luciferin has been detected in the photo
                    return Alert(title: Text("No Luciferin Detected..."), message: Text("Luciferin has not been detected in this photo"), dismissButton: .default(Text("Okay")))
                }
            }
        }
    }
    
    func processImage() {
        guard let thisImage = inputImage,
              let cgImage = thisImage.cgImage
        else { return }
        
        image2 = Image(uiImage: thisImage)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        let width = Int(thisImage.size.width)
        let height = Int(thisImage.size.height)
        let bytesPerRow = width * 4
        let imageData = UnsafeMutablePointer<Pixel>.allocate(capacity: width * height)
        var spectrum:Bool = false
        
        guard let imageContext = CGContext(
            data: imageData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        ) else { return }
        
        imageContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let pixels = UnsafeMutableBufferPointer<Pixel>(start: imageData, count: width * height)
        DispatchQueue.global(qos: .background).async {
            for y in 0..<height {
                for x in 0..<width {
                    let index  = y * width + x
                    let pixel = pixels[index]
                    if (pixel.green == 255 || pixel.green == 254) {
                        if (pixel.blue == 0) {
                            if (pixel.red == 163 /*|| pixel.red == 162 || pixel.red == 164*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 166 /*|| pixel.red == 165 || pixel.red == 167*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 169 /*|| pixel.red == 168 || pixel.red == 170*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 173 /*|| pixel.red == 172 || pixel.red == 174*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 176 /*|| pixel.red == 175 || pixel.red == 177*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 179 /*|| pixel.red == 180 || pixel.red == 178*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 182 /*|| pixel.red == 183 || pixel.red == 181*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 185 /*|| pixel.red == 186 || pixel.red == 184*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 189 /*|| pixel.red == 188 || pixel.red == 190*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 192 /*|| pixel.red == 191 || pixel.red == 193*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 195 /*|| pixel.red == 194 || pixel.red == 196*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 198 /*|| pixel.red == 197 || pixel.red == 199*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 201 /*|| pixel.red == 200 || pixel.red == 202*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 204 /*|| pixel.red == 203 || pixel.red == 205*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 207 /*|| pixel.red == 206 || pixel.red == 208*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 210 /*|| pixel.red == 209 || pixel.red == 211*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 213 /*|| pixel.red == 212 || pixel.red == 214*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 216 /*|| pixel.red == 215 || pixel.red == 217*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 219 /*|| pixel.red == 218 || pixel.red == 220*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 222 /*|| pixel.red == 221 || pixel.red == 223*/) {
                                spectrum = true
                            }
                            else if (pixel.red == 225 /*|| pixel.red == 224 || pixel.red == 226*/) {
                                spectrum = true
                            }
                        }
                    }
                    if (spectrum)
                    {
                        self.showAlert = true
                        self.luciFound = true
                        return
                    }
                }
                if (y == (height - 1))
                {
                    if (spectrum == true)
                    {
                        self.luciFound = true
                        self.showAlert = true
                    }
                    else
                    {
                        self.showAlert = true
                    }
                }
            }
        }
        SwiftSpinner.show("Processing image...")
    }
}
