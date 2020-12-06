//
// opencv-imageProc.cpp
//
// Created by Sean Howard 12/4/2020
//
// Description: Uses openCV to read through an image pixel by
// pixel to see if it is within the spectrum of Luciferin.

#include "opencv-imageProc.hpp"

using namespace std;
using namespace cv;

int imageProc2(cv::Mat cvMat)
{
    
    Mat4b image = cvMat;
    Vec4b pixel;
    vector<int> spectrum{ 166,169,173,176,179,182,185,189,192,195,198,201,204,207,210,213,216,219,222,225 };
    
    if (image.empty())
    {
        return -1;
    }
    else
    {
        for (int i = 0; i < image.rows; i++)
        {
            for (int j = 0; j < image.cols; j++)
            {
                pixel = image(i, j); //rgba
                uchar red = pixel[0];
                uchar green = pixel[1];
                uchar blue = pixel[2];
                uchar alpha = pixel[3];
                
                //std::cout << uint(red) << " " << uint(green) << " " << uint(blue) << uint(alpha) endl;
                
                if ((uint)green == 255 || (uint)green == 254)
                {
                    //std::cout << "processing green" << endl;
                    if ((uint)blue == 0 || (uint)blue == 1)
                    {
                        //std::cout << "processing blue" << endl;
                        for (uint k = 0; k < spectrum.size(); k++)
                        {
                            //std::cout << "stepping through spectrum" << endl;
                            if ((uint)red == spectrum[k] || (uint)red == spectrum[k] - 1 || (uint)red == spectrum[k] + 1)
                            {
                                return 1;
                            }
                        }
                    }
                }
            }
        }
    }
    
    return 0;
}

int imageProc(std::string filePath)
{
    //Return -1: No Image Found
    //Return 0: No Luciferin
    //Return 1: Luciferin
    std::cout << "testing: " << filePath.c_str() << endl;
    
    
    
    Mat3b image = imread(filePath);
    Vec3b pixel;
    vector<int> spectrum{ 166,169,173,176,179,182,185,189,192,195,198,201,204,207,210,213,216,219,222,225 };
    
    // Check for appropriate file path
    if (image.empty())
    {
        return -1;
    }
    else
    {
        for (int i = 0; i < image.rows; i++)
        {
            for (int j = 0; j < image.cols; j++)
            {
                pixel = image(i, j); //bgr
                uchar blue = pixel[0];
                uchar green = pixel[1];
                uchar red = pixel[2];
                
                std::cout << uint(red) << " " << uint(green) << " " << uint(blue) << endl;
                
                if ((uint)green == 255 || (uint)green == 254)
                {
                    //std::cout << "processing green" << endl;
                    if ((uint)blue == 0)
                    {
                        //std::cout << "processing blue" << endl;
                        for (uint k = 0; k < spectrum.size(); k++)
                        {
                            //std::cout << "stepping through spectrum" << endl;
                            if ((uint)red == spectrum[k])
                            {
                                return 1;
                            }
                        }
                    }
                }
            }
        }
    }
    
    //If we reach here there is no lucifein
    return 0;
}
