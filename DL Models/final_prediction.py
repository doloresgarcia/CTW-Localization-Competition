#!/usr/bin/python3

import sys
import numpy as np
import pickle
import xgboost as xgb
import math
#import pandas as pd
from scipy.io import loadmat
import tensorflow as tf



model_dl="model_50"     # model_50.json + model_50.h5
model_xgb="model_xgb_"  # model_xgb_[x|y|z]
divergence_threshold = 0.67  # Validated optimal value

if len(sys.argv) < 4:
    print("Usage: %s <fp.csv> <raw_data.[npy|mat]> <output_basename>" % (sys.argv[0]))
    sys.exit(1)

input_fp = sys.argv[1]
input_raw = sys.argv[2]  # h_Estimated_CTW_Test_Cor data
output_sphere = sys.argv[3]+"_sphere.csv"
output_xgb = sys.argv[3]+"_xgb.csv"

# read input data
print("Reading input data")
prediction_fp = np.loadtxt(input_fp, delimiter=",", skiprows=0)
ext = input_raw[-3:].lower()
if ext=="npy":
    print("Numpy extension")
    data = np.load(input_raw)  # For npy data
if ext=="mat":
    print("Matlab extension")
    mdata = loadmat(input_raw)  # For matlab data
    data_detected = False
    for i in mdata:
        if isinstance(mdata[i], np.ndarray):
            print("Detected data array '{}'".format(i))
            if data_detected:
                print("Error: more than one Matlab table detected")
                sys.exit(1)
            data=mdata[i]
            data_detected = True
    if not data_detected:
        print("No data was detected")
        sys.exit(1)
    del mdata

N = len(data)
shape = data.shape
if not data.shape == (N, 16, 924):
    print("Data shape is not correct. Actual: {}, expected: {}".format(data.shape, (N, 16, 924) ))
    sys.exit(1)

# Step-by-step cleaning to avoid memory exhaustion
print("Reshaping raw data")
data=data.reshape([N,924,16])
#sdata=data.reshape([N, 16, 924])
#del data
#rdata = np.real(sdata)
#idata = np.imag(sdata)
rdata = np.real(data)
idata = np.imag(data)
#del sdata
del data
tdata = np.concatenate ((rdata, idata), axis=2)
del rdata
del idata

print("Final data shape: {}".format(tdata.shape))

# read model
print("Reading DL model")
# load json and create model
json_file = open(model_dl+'.json', 'r')
loaded_model_json = json_file.read()
json_file.close()
model = tf.keras.models.model_from_json(loaded_model_json)
# load weights into new model
model.load_weights(model_dl+".h5")
print("Loaded '%s' model from disk"%(model_dl))

# Make predictions
print("Making DL predictions")
prediction_dl = model.predict(tdata)

# XGB model
print("Concatenating FP and DL predictions for XGB model")
data_xgb = np.concatenate((prediction_dl, prediction_fp), axis=1)

prediction_partial_xgb = {}
for dim in ['x', 'y', 'z']:
    print("Predicting XGB for %s" % (dim))
    with open(model_xgb+dim,"rb") as f:
        model = pickle.load(f)
    prediction_partial_xgb[dim] = model.predict(data_xgb)
prediction_xgb = np.vstack((
    prediction_partial_xgb['x'],
    prediction_partial_xgb['y'],
    prediction_partial_xgb['z'])).transpose()
np.savetxt(output_xgb, prediction_xgb, delimiter=",")
print("Saved result in file {}".format(output_xgb))

# Divergence model
print("Predicting by divergence threshold")
norm_dl_fp = np.linalg.norm(prediction_dl - prediction_fp, axis=1)
prediction_sphere = []
for i in range(len(norm_dl_fp)):
    if norm_dl_fp[i] > divergence_threshold:
        prediction_sphere.append(prediction_dl[i])
    else:
        prediction_sphere.append(prediction_fp[i])
np.savetxt(output_sphere, prediction_sphere, delimiter=",")
print("Saved result in file {}".format(output_sphere))

