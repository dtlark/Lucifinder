//
//  LuciHome.swift
//  Lucifinder
//
//  Created by Alexandra Spector on 10/17/20.
//

import SwiftUI

struct LuciHome: View {
    @State var image: Image? = nil
    @State var showCaptureImageView:Bool = false
    @State var showSelectImageView:Bool = false
    var body: some View {
        VStack {
            LuciBrand()
            Spacer()
            ZStack {
                VStack {
                    Spacer()
                    
                    Button(action: {
                        //self.showCaptureImageView.toggle()
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
                    image?.resizable()
                        .scaledToFit()
                    
                    Button(action: {
                        self.showSelectImageView.toggle()
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
                if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, image: $image)
                }
                if (showSelectImageView) {
                    ImagePickerView()
                }
                
            }
            Spacer()
        }
    }
}

struct CaptureImageView {
    ///Mark: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .camera
            return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct LuciHome_Previews: PreviewProvider {
    static var previews: some View {
        LuciHome()
    }
}
