import numpy as np
import cv2
import image_processing as ip
import data_generation as dg
import data_loader as dl
import network as net
import time

def startInspection():
	bias, weight = dg.loadEvaluationData()
	cap = cv2.VideoCapture(0)
	while(True):
		# Capture frame-by-frame
		ret, frame = cap.read()
		cv2.imshow("strip", frame)
		# cv2.waitKey(0)
		if ret:
			# cv2.imshow("inspection", frame)
			# Our operations on the frame goes here
			gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
			strip = ip.extractStrip(gray)
			if not strip: # proper strip image found
				print "Evaluating strip ..."
				
				res = ip.examineStripFromImage(strip, bias, weight, False)
				if not res==True: # bad strip found
					print "Bad strip found ..."
					try:
						arduino = serial.Serial(PORT, 9600, timeout=1) # connecting to arduino to move servo
						arduino.write(chr(len(res))) # upon recieving this arduino will perform specific action
						time.sleep(1)
						arduino.close()
					except:
						print "No connection with arduino"
	cap.release()

# When everything done, release the capture
# startInspection()

"""
this code is for sample image
"""
bias, weight = dg.loadEvaluationData()
ret = ip.examineStripFromImage(cv2.imread("sample2.png", 0), bias, weight, True)
if not ret == True:
	print "bad pill"
	try:
		arduino = serial.Serial(PORT, 9600, timeout=1)
		arduino.write(chr(len(ret)))
		time.sleep(5)
		arduino.close()
	except:
		print "Arduino not connected"

"""
"""

# cv2.destroyAllWindows()

# def turnOnCamera(cam = 0):
# 	cap  = cv2.VideoCapture(cam)
# 	while True:
# 		ret, frame = cap.read()
# 		cv2.imshow("video stream", frame)

# 		if cv2.waitKey(1) & 0xFF == ord('q'):
# 			break
# 	cap.release()


# turnOnCamera()
# cv2.destroyAllWindows()