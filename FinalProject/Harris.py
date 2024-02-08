import numpy as np
import cv2

def harris_corner_detector(image, block_size=2, ksize=3, k=0.04):
    # Convert to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray = np.float32(gray)

    # Compute gradients
    Ix = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=ksize)
    Iy = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=ksize)

    # Compute products of derivatives
    Ixx = Ix * Ix
    Iyy = Iy * Iy
    Ixy = Ix * Iy

    # Apply Gaussian filter
    Ixx = cv2.GaussianBlur(Ixx, (block_size, block_size), 0)
    Iyy = cv2.GaussianBlur(Iyy, (block_size, block_size), 0)
    Ixy = cv2.GaussianBlur(Ixy, (block_size, block_size), 0)

    # Compute corner response
    det = (Ixx * Iyy) - (Ixy ** 2)
    trace = Ixx + Iyy
    R = det - k * (trace ** 2)

    return R

# Example usage
image = cv2.imread('./house.jpg')
corners = harris_corner_detector(image)