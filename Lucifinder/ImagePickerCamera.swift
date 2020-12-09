//
//  ImagePicker.swift
//  Lucifinder
//
//  Created by Jeremy Palavecino on 10/24/20.
//

import SwiftUI

struct ImagePickerCamera: UIViewControllerRepresentable {
    class PickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let parent: ImagePickerCamera
        
        init(_ parent: ImagePickerCamera) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                
                let today = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss_E_d_MM_y"
                let tempstring = formatter.string(from: today)
                let fileType = ".jpg"
                
                let docsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileName = tempstring + fileType
                let fileURL = docsDirectory.appendingPathComponent(fileName)
                if let data = uiImage.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try data.write(to: fileURL)
                        //print("file written")
                        parent.url = fileURL
                    } catch {
                        print("error writing file:", error)
                    }
                }
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var url: URL?
    
    func makeCoordinator() -> PickerCoordinator {
        PickerCoordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerCamera>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerCamera>) {
        
    }
}
