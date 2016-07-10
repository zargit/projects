from Tkinter import *
import numpy as np
import tkFileDialog, tkMessageBox
import cv2
import os
import network
import image_processing as ip
from PIL import Image, ImageTk

bias, weight = np.load("latest_update.npy")

class PathEntry(Frame):
	def __init__(self, parent):
		Frame.__init__(self, parent)
		self.parent = parent
		self.entry = Entry(self)
		self.button = Button(self, text="Select Path",command=self.getDir)
		self.evaluate = Button(self, text="Inspect", command=self.evaluate)
		self.initUI()

	def initUI(self):
		dL = Label(self, text="Directory")
		dL.pack(side=LEFT, padx=5, pady=5)
		self.entry.pack(fill=X, side=LEFT, padx=5, pady=5, expand = 1)
		self.button.pack(side=LEFT,padx=5, pady=5)
		self.evaluate.pack(side=LEFT,padx=5, pady=5)
		self.pack(fill=X)

	def getDir(self):
		self.entry.delete(0,END)
		self.entry.insert(0,tkFileDialog.askopenfilename())
		image = Image.open(self.entry.get())
		self.parent.imageFrame.destroy()
		self.parent.imageFrame.image = ImageTk.PhotoImage(image)
		self.parent.imageFrame.label.destroy()
		self.parent.imageFrame.label = Label(image=self.parent.imageFrame.image)
		self.parent.imageFrame.label.pack(fill=BOTH,expand=1)
		self.parent.imageFrame.update_idletasks()

	def evaluate(self):
		if self.entry.get()!="":
			ret = ip.examineStripFromImage(cv2.imread(self.entry.get(), 0), bias, weight, True)
			reply = ""
			if ret==True:
				reply +=  "Okay."
			else:
				reply += "Bad Pills in Position: "
				for i in ret:
					reply += ""+str(i)+" "
			tkMessageBox.showinfo("Result", reply)
			

class ImageFrame(Frame):
	def __init__(self,parent):
		Frame.__init__(self, parent, bd = 1)
		self.parent = parent
		self.image = None
		self.label = Label(self)
		self.initUI()

	def initUI(self):
		# self.label.pack()
		self.pack(fill=BOTH, expand=1)

class MainFrame(Frame):
	def __init__(self, parent):
		Frame.__init__(self, parent, background="white")
		self.parent = parent
		self.initUI()

	def initUI(self):
		self.parent.title("Search File")
		self.pathBox = PathEntry(self)
		self.imageFrame = ImageFrame(self)
		self.pack(fill=BOTH, expand=1)


def main():
	root = Tk()
	root.geometry("600x600+0+0")
	# root.resizable(width=FALSE, height=FALSE)
	mf = MainFrame(root)
	root.mainloop()

def getTestData(filename):
	img = cv2.imread(filename,0)
	test_data = np.ndarray(shape=(1024,1), dtype=float, order='F')
	test_data = np.reshape(img, (1024,1))
	test_data = test_data*(-1)
	test_data = test_data + 255
	test_data = test_data/255.0
	return test_data

def sigmoid(z):
    """The sigmoid function."""
    return 1.0/(1.0+np.exp(-z))

sigmoid_vec = np.vectorize(sigmoid)

def evaluatePill(pill, bias, weight):
    for b, w in zip(bias, weight):
        pill = sigmoid_vec(np.dot(w, pill)+b)
    return np.argmax(pill)==1

if __name__=='__main__':
	main()