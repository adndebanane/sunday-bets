Sunday Bets
===========

This R programme provides a simple (or stupid) implementation of the Weighted Majority Algorithm as presented in Arora, Sanjeev, Elad Hazan, and Satyen Kale. “The Multiplicative Weights Update Method: A Meta-Algorithm and Applications.” Theory OF Computing 8 (2012): 121–64.

Sport bets made with the help of machine learning frameworks often rely on large datasets of statistics recorded during sport events. The Sunday Bets programme addresses this question from a different point of view and rely exclusively on the advices of some experts. Find expert or friend tips, predict results (only 1/N/2 bets supported) over sport seasons and make better collective choices thanks to this programme (hopefully).

The more experts/friends you will find, the more accurate your bets will be. An interesting project would be to implement this programme in Python and to build a community website providing accurate (or not) predictions.

Structure of the programme
--------------------------
*Datasets*
* experts.rda
* oldprono.txt
* pronostics.txt
* resultats.txt

*R files*
* algo_prono.R 

This file, given experts.rda / pronostics.txt / resultats.txt makes the predictions for all unplayed match and export them in oldprono.txt. Two different methods (deterministic and random) are used.
* perf_oldprono.R

This file, given oldprono.txt / resultats.txt estimates the performance of each of the methods making the predictions in algo_prono.R.
* weights.R

This file, given pronostics.txt / resultats.txt computes weights of all the experts playing the game. These weights are saved in experts.rda and used in algo_prono.R for predictions. A picture of the weights (experts.pdf) is also produced.

Use of the programme
--------------------
1. **Train the algorithm**
You first need to find a source of regular expert predictions (or to play the game with friends) and to save these predictions in pronostics.txt (see the file for the format). Provide then the actual results of the played matches in resultats.txt (see the file for the format). Once the dataset is created, run the weights.R file (you can for instance use R CMD BATCH weights.R in a terminal).

2. **Make predictions**
Add new predictions in pronostics.txt and run algo_prono.R. Predictions will be prompted and saved in oldprono.txt.

3. **Evaluate the accuracy of the predictions**
Fill the new results in resultats.txt and run weights.R as well as perf_oldprono.R. A pdf picture will allow you to highlight the best experts and the perf_oldprono.R will display which of the deterministic / random method is the most efficient so you can evaluate your own confidence in the predictions of Sunday Bets.

