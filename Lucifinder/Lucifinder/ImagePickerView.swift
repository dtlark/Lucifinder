//
//  ImagePicker.swift
//  Lucifinder
//
//  Created by Alexandra Spector on 10/24/20.
//

import CoreImage
import CoreImage.CIImage
import CoreImage.CIImageProcessor
import CoreImage.CIFilterBuiltins
import CoreGraphics
import UIKit
import Foundation

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save Finished")
    }
}

struct ImagePickerView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter = CIFilter.sepiaTone()
    
    @State private var showAlert = false
    
    var labelContainerView: UIView!
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            //LuciBrand()
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
            }
            .padding([.horizontal, .bottom])
            .sheet(isPresented: $showingImagePicker, onDismiss: processImage) {
                ImagePicker(image: self.$inputImage)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Luciferin Detected!"), message: Text("Luciferin has been detected in the photo!"), dismissButton: .default(Text("Great!")))
            }
        }
    }
    func processImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        DispatchQueue.main.async {
            logPixelsOfImage()
        }
        SwiftSpinner.show("Processing image...", animated: true)
        //logPixelsOfImage()
        DispatchQueue.main.async {
            SwiftSpinner.hide()
        }
        //let imageSaver = ImageSaver()
        //imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
    func logPixelsOfImage() {
        guard let thisImage = inputImage,
              let cgImage = thisImage.cgImage
        else { return }
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        let width = Int(thisImage.size.width)
        let height = Int(thisImage.size.height)
        var bytesPerRow = width * 4
        let imageData = UnsafeMutablePointer<Pixel>.allocate(capacity: width * height)
        
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
        for y in 0..<height {
            for x in 0..<width {
                let index  = y * width + x
                let pixel = pixels[index]
                var spectrum:Bool = false
                if (pixel.green == 255 || pixel.green == 254) {
                    if (pixel.blue == 0) {
                        if (pixel.red == 163 || pixel.red == 162 || pixel.red == 164) {
                            spectrum = true
                        }
                        else if (pixel.red == 166 || pixel.red == 165 || pixel.red == 167) {
                            spectrum = true
                        }
                        else if (pixel.red == 169 || pixel.red == 168 || pixel.red == 170) {
                            spectrum = true
                        }
                        else if (pixel.red == 173 || pixel.red == 172 || pixel.red == 174) {
                            spectrum = true
                        }
                        else if (pixel.red == 176 || pixel.red == 175 || pixel.red == 177) {
                            spectrum = true
                        }
                        else if (pixel.red == 179 || pixel.red == 180 || pixel.red == 178) {
                            spectrum = true
                        }
                        else if (pixel.red == 182 || pixel.red == 183 || pixel.red == 181) {
                            spectrum = true
                        }
                        else if (pixel.red == 185 || pixel.red == 186 || pixel.red == 184) {
                            spectrum = true
                        }
                        else if (pixel.red == 189 || pixel.red == 188 || pixel.red == 190) {
                            spectrum = true
                        }
                        else if (pixel.red == 192 || pixel.red == 191 || pixel.red == 193) {
                            spectrum = true
                        }
                        else if (pixel.red == 195 || pixel.red == 194 || pixel.red == 196) {
                            spectrum = true
                        }
                        else if (pixel.red == 198 || pixel.red == 197 || pixel.red == 199) {
                            spectrum = true
                        }
                        else if (pixel.red == 201 || pixel.red == 200 || pixel.red == 202) {
                            spectrum = true
                        }
                        else if (pixel.red == 204 || pixel.red == 203 || pixel.red == 205) {
                            spectrum = true
                        }
                        else if (pixel.red == 207 || pixel.red == 206 || pixel.red == 208) {
                            spectrum = true
                        }
                        else if (pixel.red == 210 || pixel.red == 209 || pixel.red == 211) {
                            spectrum = true
                        }
                        else if (pixel.red == 213 || pixel.red == 212 || pixel.red == 214) {
                            spectrum = true
                        }
                        else if (pixel.red == 216 || pixel.red == 215 || pixel.red == 217) {
                            spectrum = true
                        }
                        else if (pixel.red == 219 || pixel.red == 218 || pixel.red == 220) {
                            spectrum = true
                        }
                        else if (pixel.red == 222 || pixel.red == 221 || pixel.red == 223) {
                            spectrum = true
                        }
                        else if (pixel.red == 225 || pixel.red == 224 || pixel.red == 226) {
                            spectrum = true
                        }
                    }
                }
                if (spectrum)
                {
                    self.showAlert = true
                }
            }
        }
        
        
        print(Int(width))
        print(Int(height))
        
        colorSpace = CGColorSpaceCreateDeviceRGB()
        bitmapInfo = CGBitmapInfo.byteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        
        bytesPerRow = width * 4
        
        guard let context = CGContext(
            data: pixels.baseAddress,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo,
            releaseCallback: nil,
            releaseInfo: nil
        ) else { return }
        
        if let cgimg = context.makeImage() {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
}

//define Pixel
public struct Pixel {
    public var value: UInt32
    public var found:Bool = false
    
    public var red: UInt8 {
        get {
            return UInt8(value & 0xFF)
        } set {
            value = UInt32(newValue) | (value & 0xFFFFFF00)
        }
    }
    
    public var green: UInt8 {
        get {
            return UInt8((value >> 8) & 0xFF)
        } set {
            value = (UInt32(newValue) << 8) | (value & 0xFFFF00FF)
        }
    }
    
    public var blue: UInt8 {
        get {
            return UInt8((value >> 16) & 0xFF)
        } set {
            value = (UInt32(newValue) << 16) | (value & 0xFF00FFFF)
        }
    }
    
    public var alpha: UInt8 {
        get {
            return UInt8((value >> 24) & 0xFF)
        } set {
            value = (UInt32(newValue) << 24) | (value & 0x00FFFFFF)
        }
    }
}

