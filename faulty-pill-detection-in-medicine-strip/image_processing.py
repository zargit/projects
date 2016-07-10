import numpy as np
import cv2
import image_processing as ip
import data_generation as dg
import network as net

WHITE = [255,255,255]

# this is the function for evaluating a certain image from the camera
def examineStripFromImage(image, bias, weight, extract):
	strip = image
	if extract:
		strip = extractStrip(image)
	bads = []
	pills = splitStripToPills(strip)
	for i in range(len(pills)):
		data = dg.getTestDataForEvalutaion(pills[i])
		if not evaluatePill(data, bias, weight):
			print i+1
			bads.append(i+1)
	if len(bads)==0:
		return True
	else: return bads

# this function isoletes the medicine strip from the rest of the image
# and returns a resized image with (770x308) dimension
def extractStrip(img):
	ret, mask = cv2.threshold(img, 200, 255, cv2.THRESH_BINARY)
	bitImg = cv2.bitwise_and(img,img,mask = mask)
	contours, hierarchy = cv2.findContours(bitImg,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
	areas = [cv2.contourArea(c) for c in contours]
	if len(areas)>0:
		maxContour = contours[np.argmax(areas)]
		x1,y1,w,h = cv2.boundingRect(maxContour)
		print (x1,y1,w,h)
		img_2 = cv2.rectangle(img, (x1,y1),(x1+w,y1+h),(0,255,0),3) # debug line, can remove

		if w*h < (770*308):
			return False
		strip = img[y1:y1+h, x1:x1+w]
		cv2.imshow('img_2',strip)
		cv2.waitKey(0)
		cv2.destroyAllWindows()
		if w>h:
			box = np.uint8(np.zeros((w,w)))
			a, b = w/2, h/2
			box[a-b:a-b+h, 0:w] = strip
			M = cv2.getRotationMatrix2D((w/2,w/2),90,1)
			strip = cv2.warpAffine(box, M, (w, w))[0:w, a-b:a-b+h]
		strip = cv2.resize(strip,(308,770))
		cv2.imshow('img_2',strip)
		cv2.waitKey(0)
		cv2.destroyAllWindows()
		return strip

# here the strip is being split in to ten parts consisiting of
# single pills and then return them in an array
def splitStripToPills(strip, ph=154, pw=154, rsh=32, rsw=32):
	# strip = cropStrip(strip, ph, pw)
	pills = []
	tV = strip.shape[0]/ph
	tW = strip.shape[1]/pw
	for i in range(0,(ph*tV)-1,ph):
		for j in range(0,(pw*tW)-1,pw):
			p = cv2.resize(strip[i:i+ph, j:j+pw], (rsh, rsw))
			pills.append(p)
			j += 1
		i += 1
	return pills

# to crop extra pixel before splitting
def cropStrip(strip, ph, pw):
	if strip.shape[0]<770:
		bd = (770-strip.shape[0]+1)/2
		strip = cv2.copyMakeBorder(strip,bd,bd,0,0,cv2.BORDER_CONSTANT,value=WHITE)

	if strip.shape[1]<308:
		bd = (308-strip.shape[1]+1)/2
		strip = cv2.copyMakeBorder(strip,0,0,bd,bd,cv2.BORDER_CONSTANT,value=WHITE)
	
	extraV, extraH  = strip.shape[0]%ph, strip.shape[1]%pw
	aV, aH = extraV/2, extraH/2
	bV, bH = extraV-aV, extraH-aH
	return strip[(0+aV):(strip.shape[0]-bV), (0+aH):(strip.shape[0]-bH)]

#### Miscellaneous functions
def sigmoid(z):
    """The sigmoid function."""
    return 1.0/(1.0+np.exp(-z))

sigmoid_vec = np.vectorize(sigmoid)

def evaluatePill(pill, bias, weight):
    for b, w in zip(bias, weight):
        pill = sigmoid_vec(np.dot(w, pill)+b)
    return np.argmax(pill)==1