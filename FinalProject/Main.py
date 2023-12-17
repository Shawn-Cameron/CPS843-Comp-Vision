import numpy as np
from memory_profiler import profile, memory_usage
import cv2
from scipy import ndimage
import time

# @profile used for the memory profiler. Uncommenting will allow memory analysis at the cost of speed
#@profile
def harris_corner_detection(image, k=0.01, threshold=0.1):
    # Convert to grayscale
    imgGray =  np.float32(cv2.cvtColor(image, cv2.COLOR_BGR2GRAY))

    # Gradient calculations
    dx = ndimage.sobel(imgGray, axis=0, mode='constant')
    dy = ndimage.sobel(imgGray, axis=1, mode='constant')

    # Calculate gradient products
    xxProd = ndimage.gaussian_filter(dx**2, sigma=1)
    yyProd = ndimage.gaussian_filter(dy**2, sigma=1)
    xyProd = ndimage.gaussian_filter(dx*dy, sigma=1)

    # Compute Corner Response
    detM = xxProd * yyProd - xyProd ** 2
    traceM = xxProd + yyProd
    R = detM - k * traceM ** 2

    # Thresholding
    R[R < threshold * R.max()] = 0

    # Non-Maximum Suppression
    corners = np.argwhere(R > 0)
    localMax = ndimage.maximum_filter(R, size=3)
    detectedCorners = np.array([p for p in corners if R[p[0], p[1]] == localMax[p[0], p[1]]])

    return detectedCorners

#@profile  
def fast_corner_detector(img, n = 8, threshold = 100):
    #converting to greyscale
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    #defining the circle of pixel 
    surroundingPixels = [
        (3,0), (3,1), (2,2), (1,3), 
        (0,3), (-1,3), (-2,2), (-3,1),
        (-3,0), (-3,-1), (-2,-2), (-1,-3),
        (0,-3), (1,-3), (2,-2), (3,-1)
    ]

    # precomputing the dark and light intensities with the threshold
    lightInt = np.array([[min(255, x + threshold) for x in row] for row in img.tolist()])
    darkInt = np.array([[max(0, x - threshold) for x in row] for row in img.tolist()])

    corners = []

    # Finding all the possible corners
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            
            darkCounter = 0
            lightCounter = 0
            V = 0

            # calculating the intensities of the surrounding points
            for pixel in surroundingPixels:
                dx = i + pixel[0]
                dy = j + pixel[1]
                
                if not (0 <= dx < img.shape[0]) or not (0 <= dy < img.shape[1]):
                    continue;
                
                pixelIntensity = img[dx, dy]
                
                if (darkInt[i,j] > pixelIntensity):    
                    darkCounter += 1
                if (lightInt[i,j] < pixelIntensity):
                    lightCounter +=1
                
                # for non-maximum suppression
                V += abs(int(img[i,j]) - pixelIntensity)

            # checks the number of points that are darker or lighter to add to list
            if(darkCounter >= n or lightCounter >= n):
                corners.append(((i,j),V))
    

    #computes non-maximum suppression 
    corners.sort(key=lambda c: c[1], reverse=True)

    suppressed_corners = []

    while corners:
        # Take the corner with the highest V value and adds it to the list
        current_corner = corners.pop(0)
        suppressed_corners.append(current_corner)
        
        # removes points that are directly besides the selected corner
        corners = [corner for corner in corners if not (
            (abs(corner[0][0] - current_corner[0][0]) <= 1) and 
            (abs(corner[0][1] - current_corner[0][1]) <= 1)
            )]

    # returns the point coordinates
    return [corner[0] for corner in suppressed_corners]


def main():
    #imports the image
    image = cv2.imread('./Samples/checkerboard.png')

    #runs the algorithms and determines the total time
    currentTime = time.time()
    harrisCorners = harris_corner_detection(image)
    harrisTime = time.time() - currentTime

    currentTime = time.time()
    fastCorners = fast_corner_detector(image)
    fastTime = time.time() - currentTime

    # prints the states of each algorithm
    print("---Harris Stats---")
    print("Time (ms):",round(harrisTime * 1000), "\nNumber of detections:", len(harrisCorners))

    print("---Fast Stats---")
    print("Time (ms):",round(fastTime * 1000), "\nNumber of detections:", len(fastCorners))

    # creates copy for visualization
    harrisImg = image.copy()
    fastImg = image.copy()
    
    # draws the detected points on the image and diplays it
    for corner in harrisCorners:
        x,y = corner
        cv2.circle(harrisImg, (y,x), 8, (0, 255, 0), -1)
    cv2.imshow("Harris", harrisImg)

    for corner in fastCorners:
        x,y = corner
        cv2.circle(fastImg, (y,x), 8, (255, 0, 0), -1)
    cv2.imshow("Fast", fastImg)

    cv2.waitKey(0)

if __name__ == "__main__":
    main()