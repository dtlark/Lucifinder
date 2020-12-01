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
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
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
