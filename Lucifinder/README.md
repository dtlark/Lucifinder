# Lucifinder
***
Lucifinder is an application used to detect the presence of luciferin in photos. These photos can be photos saved on the users device or photos captured real time. 

### Table of Contents
1. [Getting Started](#getting-started)
2. [Analyzing Photos](#analyzing-photos)
3. [Cloud Storage](#cloud-storage)
4. [Future Development](#future-development)
5. [Accompanying Technologies](#accompanying-technologies)

## Getting Started
***
Getting started is as simple as downloading the application to your device!
![Home Screen](/Users/AllieSpector/Desktop/Lucifinder/App Home Screen.png)

## Analyzing Photos
***
We've all seen or at least heard of fireflies. But, have you ever stopped to wonder how these critters emit their flickering glow? Well, this light is emitted through the combination of a chemical called 'Luciferin' and an enzyme called 'Luciferase'. All organisms that emit bioluminescent light contain this combination. However, no two organism's combinations are alike. Our focus lies in that combination found in fireflies, otherwise known as D-Luciferin. 

We believe there is much more waiting to be discovered in these chemicals, and this application is just the beginning to tapping into this potential.

The wavelength targeted by this application is within the range of 550nm-570nm. This range has been translated into RGB values through the use of a wavelength to RGB converter provided by academo.org. It is through this value range in which our application determins the presence of luciferin.

#### Photo Selection
Users can choose whether to use photos saved on their device or analyze their current environment by capturing images real-time. Upon open the application you will be met with the choice of either choosing a photo or taking a new one.

Either choice will present a screen with a text placeholder for your image that you will either choose or take. Simply tap the text as instructed to proceed. Once your photo is chosen or taken, it will automatically be passed through the image processing which will analyze your image pixel by pixel to determine whether or not luciferin is present.
## Cloud Storage
***
Currently, this application does not write data to the user's device. However, we understand the importance of documenting important moments, such as discovering the presence of luciferin. For this reason, we have set up cloud storage for the application through Google's Firebase service. After your chosen, or taken, photo has been anaylzed, you will be presented with the option of saving the photo to Firebase. Just click the button and your photo will automatically be sent to the cloud!
## Future Development
***
The future development plans of this application are to utilize Apple's LiDAR scanning abilities to provide users with real-time, on-screen feedback.
