import numpy as np
import cv2

def fast_corner_detector(image, threshold=1, nonmax_suppression=True):
  """ {{{{ Fix later}}}}
  Implements the FAST corner detector algorithm.

  Args:
    image: A grayscale image represented as a NumPy array.
    threshold: The intensity threshold for corner detection.
    nonmax_suppression: Whether to perform non-maximum suppression.

  Returns:
    A list of detected corner coordinates as tuples (x, y).
  """

  corners = []
  for i in range(1, image.shape[0] - 1):
    for j in range(1, image.shape[1] - 1):
      center_intensity = image[i, j]
      # Check for at least 12 contiguous pixels within a 16-pixel circle
      # satisfying the intensity threshold
      consecutive_pixels = 0
      for k in range(16):
        offset_i = int(np.cos(2 * np.pi * k / 16))
        offset_j = int(np.sin(2 * np.pi * k / 16))
        neighbor_intensity = image[i + offset_i, j + offset_j]
        if (neighbor_intensity - center_intensity) > threshold:
          consecutive_pixels += 1
        elif (neighbor_intensity - center_intensity) < -threshold:
          consecutive_pixels = 0
          break
        if consecutive_pixels >= 12:
          corners.append((i, j))
          break

  # Perform non-maximum suppression (optional)
  if nonmax_suppression:
    suppressed_corners = []
    for corner in corners:
      is_suppressed = False
      for other_corner in corners:
        if np.linalg.norm(np.array(corner) - np.array(other_corner)) < 3 and other_corner != corner:
          is_suppressed = True
          break
      if not is_suppressed:
        suppressed_corners.append(corner)
    corners = suppressed_corners

  return corners

# Example usage
image = cv2.imread("./Samples/chessboard.jpg", cv2.IMREAD_GRAYSCALE)
corners = fast_corner_detector(image)

# Draw detected corners
for corner in corners:
  cv2.circle(image, corner, 2, (0, 255, 0), -1)

cv2.imshow("Corners", image)
cv2.waitKey(0)