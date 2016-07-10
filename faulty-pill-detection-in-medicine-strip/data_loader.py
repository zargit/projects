"""
mnist_loader
~~~~~~~~~~~~

A library to load the MNIST image data.  For details of the data
structures that are returned, see the doc strings for ``load_data``
and ``load_data_wrapper``.  In practice, ``load_data_wrapper`` is the
function usually called by our neural network code.
"""

#### Libraries
import cPickle
import gzip

import numpy as np

def load_data():
    training_data = np.load('trainingData2.npy')
    test_data = np.load('testData2.npy')
    return (training_data, test_data)

def load_data_wrapper():
    tr_d, te_d = load_data()
    training_inputs = [np.reshape(x, (1024, 1)) for x in tr_d[0]]
    training_results = [vectorized_result(y) for y in tr_d[1]]
    training_data = zip(training_inputs, training_results)
    test_inputs = [np.reshape(x, (1024, 1)) for x in te_d[0]]
    test_data = zip(test_inputs, te_d[1])
    return (training_data, test_data)

def vectorized_result(j):
    e = np.zeros((2, 1))
    e[j] = 1.0
    return e


