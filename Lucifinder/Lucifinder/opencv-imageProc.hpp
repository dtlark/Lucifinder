//
// opencv-imageProc.h
//
// Created by Sean Howard 12/4/2020
//
// Description: Uses openCV to read through a .jpg pixel by pixel to see if it is within the spectrum of Luciferin.
//
/********************************* CITATIONS *********************************/
//https://stackoverflow.com/questions/27183946/what-does-cv-8uc3-and-the-other-types-stand-for-in-opencv
//https://docs.opencv.org/4.1.2/
//https://stackoverflow.com/questions/22115302/opencv-documentation-says-that-uchar-is-unsigned-integer-datatype-how
//https://stackoverflow.com/questions/22115302/opencv-documentation-says-that-uchar-is-unsigned-integer-datatype-how
//https://stackoverflow.com/questions/26059507/how-can-i-know-if-a-image-is-rgb-in-opencv
//https://www.youtube.com/watch?v=pwoob3tVNJs
//https://stackoverflow.com/questions/41614319/accessing-rgb-values-of-all-pixels-in-a-certain-image-in-opencv
//https://stackoverflow.com/questions/29865623/opencv-display-pixels-value
//

#ifndef opencv_imageProc_hpp
#define opencv_imageProc_hpp

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/core/mat.hpp>
#include <opencv2/core/hal/interface.h>
#include <stdio.h>
#include <iostream>
#include <vector>

int imageProc(std::string filePath);
int imageProc2(cv::Mat cvMat);

#endif /* opencv_imageProc_hpp */
