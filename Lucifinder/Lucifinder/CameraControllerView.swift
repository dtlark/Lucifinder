//
//  CameraControllerView.swift
//  Lucifinder
//
//  Created by Alexandra Spector on 10/18/20.
//

import UIKit
import SwiftUI

final class CameraControllerView: UIViewController {
    let cameraController = CameraController()
    var previewView: UIView!
}

override func viewDidLoad() {
                
    previewView = UIView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    previewView.contentMode = UIView.ContentMode.scaleAspectFit
    view.addSubview(previewView)
    
    cameraController.prepare {(error) in
        if let error = error {
            print(error)
        }
        
        try? self.cameraController.displayPreview(on: self.previewView)
    }
    
}

extension CameraControllerView : UIViewControllerRepresentable{
    public typealias UIViewControllerType = CameraControllerView
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraControllerView>) -> CameraControllerView {
        return CameraControllerView()
    }
    
    public func updateUIViewController(_ uiViewController: CameraControllerView, context: UIViewControllerRepresentableContext<CameraControllerView>) {
    }
}

struct ContentView: View {
    var body: some View {
        CameraControllerView()
            .edgesIgnoringSafeArea(.top)
    }
}

struct CameraControllerView_Previews: PreviewProvider {
    static var previews: some View {
        CameraControllerView()
    }
}
