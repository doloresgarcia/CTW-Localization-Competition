# CTW Localization-Competition
 DL+Fingerprinting model for localizing a robot with Channel responses from antenna.



Hybrid model:

1. FingerPrint_Model: contains FP model with data 
   Outputs: csv file with the estimation from the FP model
2. DL Model: Contrains the trained DL models and the Hybrid (a regression model to merge the FP with the DL models)

Two methods were chosen to merge the models:
- Simple divergence trained with a single parameter
- XGB

XGB giving better results.
The data for the later training was ensured with new tets data and 10 fold cross-validation.


This images shows the two trainings, 
after, we apply the regression model to the result of the training of both models:

![Image of Training](https://github.com/doloresgarcia/CTW-Localization-Competition/blob/master/ReadMEexplanatoryFig.jpg)




