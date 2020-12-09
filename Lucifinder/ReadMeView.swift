//
//  ReadMeView.swift
//  Lucifinder
//
//  Created by Jeremy Palavecino on 12/5/20.
//

import SwiftUI
import CloudKit
//import WebKit

struct ReadMeView: View {
    var body: some View {
        /*:
         ###Testing
         1. [Test 1](Test_1)
         2. [Test 2](Test_2)
         */
        Text("Lucifinder")
            .fontWeight(.bold)
            .font(.system(size:50))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.trailing, 10)
        ScrollView {
            VStack {
                Text("Lucifinder is an application used to detect the presence of luciferin in photos. These photos can be photos saved on the users device or photos captured real time.\n")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("Getting Started")
                    .fontWeight(.bold)
                    .font(.system(size:35))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("Getting started is as simple as opening up the app and then point, click, and upload!\n")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("Analyzing Photos")
                    .fontWeight(.bold)
                    .font(.system(size:35))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("We've all seen or at least heard of fireflies. But, have you ever stopped to wonder how these critters emit their flickering glow? Well, this light is emitted through the combination of a chemical called 'Luciferin' and an enzyme called 'Luciferase'. All organisms that emit bioluminescent light contain this combination. However, no two organism's combinations are alike. Our focus lies in the combination that is found in fireflies, otherwise known as D-Luciferin.\n\nWe believe there is much more waiting to be discovered in these chemicals, and this application is just the beginning to tapping into this potential.\n\nThe wavelength targeted by this application is within the range of 550nm-570nm. This range has been translated into RGB values through the use of a wavelength to RGB converter provided by academo.org. It is through this value range in which our application determines the presence of luciferin.\n\nPhoto Selection:\nUsers can choose whether to use photos saved on their device or analyze their current environment by capturing images real-time. Upon opening the application you will be met with the choice of either choosing a photo or taking a new one.\n\nEither choice will present a screen with a text placeholder for your image that you will either choose or take. Simply tap the text as instructed to proceed. Once your photo is chosen or taken, it will automatically be passed through the image processing which will analyze your image pixel by pixel to determine whether or not luciferin is present.\n")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("Cloud Storage")
                    .fontWeight(.bold)
                    .font(.system(size:35))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("Currently, this application does not write data to the user's device. However, we understand the importance of documenting important moments, such as discovering the presence of luciferin. For this reason, we have set up cloud storage for the application through Google's Firebase service. After you have chosen, or taken, your photo and it has been anaylzed, you will be presented with the option of saving the photo to Firebase. Just click the button and your photo will automatically be sent to the cloud!\n")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("Future Development")
                    .fontWeight(.bold)
                    .font(.system(size:35))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Text("The future development plans of this application are to utilize Apple's LiDAR scanning abilities to provide users with real-time, on-screen feedback along with giving the user the ability to adjust the wavelength measurement they would like to test for.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct ReadMeView_Previews: PreviewProvider {
    static var previews: some View {
        ReadMeView()
    }
}
