//
// opencv-imageProc.cpp
//
// Created by Sean Howard 12/4/2020
//
// Description: Uses openCV to read through an image pixel by
// pixel to see if it is within the spectrum of Luciferin.

#include "opencv-imageProc.hpp"
#include <math.h>

using namespace std;
using namespace cv;

vector<int> redSpectrum = {};
vector<int> greenSpectrum = {};
vector<int> blueSpectrum = {};

int highestRed = 0;
int lowestRed = 0;

int lowestGreen = 0;
int highestGreen = 0;

int lowestBlue = 0;
int highestBlue = 0;


//by Deanna Lark
void toRGB(float w, float u)
{
    float red_w = 0;
    float green_w = 0;
    float blue_w = 0;
    
    cout << w << endl;
    cout << u << endl;
    
    if (w >= 380 && w < 440)
    {
        red_w   = -(w - 440) / (440 - 380);
        green_w = 0.0;
        blue_w  = 1.0;
    }
    else if (w >= 440 && w < 490)
    {
        red_w   = 0.0;
        green_w = (w - 440) / (490 - 440);
        blue_w  = 1.0;
    }
    else if (w >= 490 && w < 510)
    {
        red_w   = 0.0;
        green_w = 1.0;
        blue_w  = -(w - 510) / (510 - 490);
    }
    else if (w >= 510 && w < 580)
    {
        red_w   = (w - 510) / (580 - 510);
        green_w = 1.0;
        blue_w  = 0.0;
    }
    else if (w >= 580 && w < 645)
    {
        red_w   = 1.0;
        green_w = -(w - 645) / (645 - 580);
        blue_w  = 0.0;
    }
    else if (w >= 645 && w < 781)
    {
        red_w   = 1.0;
        green_w = 0.0;
        blue_w  = 0.0;
    }
    else
    {
        red_w   = 0.0;
        green_w = 0.0;
        blue_w  = 0.0;
    }
    

    float factor_w = 0;
    float gamma_w = 0.80;
    
    // Let the intensity fall off near the vision limits

    if (w >= 380 && w < 420)
        factor_w = 0.3 + 0.7*(w - 380) / (420 - 380);
    else if (w >= 420 && w < 701)
        factor_w = 1.0;
    else if (w >= 701 && w < 781)
        factor_w = 0.3 + 0.7*(780 - w) / (780 - 700);
    else
        factor_w = 0.0;

    float R_w = (red_w   > 0 ? 255 * pow(red_w   * factor_w, gamma_w) : 0);
    float G_w = (green_w > 0 ? 255 * pow(green_w * factor_w, gamma_w) : 0);
    float B_w = (blue_w  > 0 ? 255 * pow(blue_w  * factor_w, gamma_w) : 0);

    
    
    
    
    float red_u = 0;
    float green_u = 0;
    float blue_u = 0;
    
    
    if (u >= 380 && u < 440)
    {
        red_u   = -(u - 440) / (440 - 380);
        green_u = 0.0;
        blue_u  = 1.0;
    }
    else if (u >= 440 && u < 490)
    {
        red_u  = 0.0;
        green_u = (u - 440) / (490 - 440);
        blue_u  = 1.0;
    }
    else if (u >= 490 && u < 510)
    {
        red_u   = 0.0;
        green_u = 1.0;
        blue_u  = -(u - 510) / (510 - 490);
    }
    else if (u >= 510 && u < 580)
    {
        red_u   = (u - 510) / (580 - 510);
        green_u = 1.0;
        blue_u  = 0.0;
    }
    else if (u >= 580 && u < 645)
    {
        red_u   = 1.0;
        green_u = -(u - 645) / (645 - 580);
        blue_u  = 0.0;
    }
    else if (u >= 645 && u < 781)
    {
        red_u   = 1.0;
        green_u = 0.0;
        blue_u  = 0.0;
    }
    else
    {
        red_u   = 0.0;
        green_u = 0.0;
        blue_u  = 0.0;
    }
    

    float factor_u = 0;
    float gamma_u = 0.80;
    
    // Let the intensity fall off near the vision limits

    if (u >= 380 && u < 420)
        factor_u = 0.3 + 0.7*(u - 380) / (420 - 380);
    else if (u >= 420 && u < 701)
        factor_u = 1.0;
    else if (u >= 701 && u < 781)
        factor_u = 0.3 + 0.7*(780 - u) / (780 - 700);
    else
        factor_u = 0.0;

    int R_u = (red_u   > 0 ? 255 * pow(red_u   * factor_u, gamma_u) : 0);
    int G_u = (green_u > 0 ? 255 * pow(green_u * factor_u, gamma_u) : 0);
    int B_u = (blue_u  > 0 ? 255 * pow(blue_u  * factor_u, gamma_u) : 0);

    
    if (R_u > R_w) {
        highestRed = R_u;
        lowestRed = R_w;
    }
    else {
        lowestRed = R_u;
        highestRed = R_w;
    }
    if (G_u > G_w) {
        highestGreen = G_u;
        lowestGreen = G_w;
    }
    else {
        lowestGreen = G_u;
        highestGreen = G_w;
    }
    if (B_u > B_w) {
        highestBlue = B_u;
        lowestBlue = B_w;
    }
    else {
        lowestBlue = B_u;
        highestBlue = B_w;
    }
    

    
    for (int i = lowestRed; i <= highestRed; i++){
        redSpectrum.push_back(i);
        cout << "Red " << i << endl;
    }
    
    for (int i = lowestGreen; i <= highestGreen; i++){
        greenSpectrum.push_back(i);
        cout << "Green " << i << endl;
    }
    
    for (int i = lowestBlue; i <= highestBlue; i++){
        blueSpectrum.push_back(i);
        cout << "Blue: " << i << endl;
        
    }

}








int imageProc2(cv::Mat cvMat, float lower, float upper)
{
    
    toRGB(lower, upper);
    
    Mat4b image = cvMat;
    Vec4b pixel;
 
    if (image.empty())
    {
        
        redSpectrum = {};
        greenSpectrum =  {};
        blueSpectrum = {};
        
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
                
                
                
               // std::cout << uint(red) << " " << uint(green) << " " << uint(blue) << endl;
                
                
                
                for (uint l = 0; l < greenSpectrum.size(); l++) {
                
                if ((uint)green == greenSpectrum[l])
                {
                    for (uint m = 0; m < blueSpectrum.size(); m++) {
                        
                        //std::cout << "processing green" << endl;
                        if ((uint)blue == blueSpectrum[m])
                        {
                            //std::cout << "processing blue" << endl;
                            for (uint k = 0; k < redSpectrum.size(); k++)
                            {
                                //std::cout << "stepping through spectrum" << endl;
                                if ((uint)red == redSpectrum[k])
                                {
                                    redSpectrum = {};
                                    greenSpectrum = {};
                                    blueSpectrum = {};
                                    return 1;
                                }
                            }
                        }
                    }
                }
            }
            
            
        }
        }
    }
    
    
    redSpectrum = {};
    greenSpectrum =  {};
    blueSpectrum = {};
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
                
                for (uint l = 0; l < greenSpectrum.size(); l++) {
                
                if ((uint)green == greenSpectrum[l])
                {
                    for (uint m = 0; m < blueSpectrum.size(); m++) {
                        
                    //std::cout << "processing green" << endl;
                    if ((uint)blue == blueSpectrum[m])
                    {
                        //std::cout << "processing blue" << endl;
                        for (uint k = 0; k < redSpectrum.size(); k++)
                        {
                            //std::cout << "stepping through spectrum" << endl;
                            if ((uint)red == redSpectrum[k])
                            {
                                return 1;
                            }
                        }
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
