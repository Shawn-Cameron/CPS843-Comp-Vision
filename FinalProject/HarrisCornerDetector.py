import numpy as np
import cv2
from scipy import ndimage

def harris_corner_detection(image, k=0.05, window_size=3, threshold=0.01):
    # Step 1: Convert to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray = np.float32(gray)

    # Step 2: Gradient calculations
    Ix = ndimage.sobel(gray, axis=0, mode='constant')
    Iy = ndimage.sobel(gray, axis=1, mode='constant')

    # Step 3: Calculate gradient products
    Ixx = ndimage.gaussian_filter(Ix**2, sigma=1)
    Iyy = ndimage.gaussian_filter(Iy**2, sigma=1)
    Ixy = ndimage.gaussian_filter(Ix*Iy, sigma=1)

    # Step 4 & 5: Compute Corner Response
    detM = Ixx * Iyy - Ixy ** 2
    traceM = Ixx + Iyy
    R = detM - k * traceM ** 2

    # Step 6: Thresholding
    R[R < threshold * R.max()] = 0

    # Step 7: Non-Maximum Suppression
    corners = np.argwhere(R > 0)
    local_max = ndimage.maximum_filter(R, size=window_size)
    detected_corners = np.array([pt for pt in corners if R[pt[0], pt[1]] == local_max[pt[0], pt[1]]])

    return detected_corners

# Usage
image = cv2.imread('./Samples/chessboard.jpg')
corners = harris_corner_detection(image)
for corner in corners:
    x, y = corner
    cv2.circle(image, (y, x), 5, (0,255,0), 1)

cv2.imshow('Harris Corners', image)
cv2.waitKey(0)
cv2.destroyAllWindows()