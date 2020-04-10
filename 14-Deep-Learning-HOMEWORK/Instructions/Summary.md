# LSTM Stock Predictor Summary

### Which model has a lower loss?

the "lstm_stock_predictor_closing" seemed to have a lower loss.

loss for predictor: 0.01571823628619313

loss for FNG: 
	windows size 1:0.08335491896041332
	window size 10: 0.11269505620002747



### Which model tracks the actual values better over time?
	The model in the "lstm_stock_predictor_closing" exercise tracks it better even with some of the window sizes and epochs modified for the FNG model.

### Which window size works best for the model?
	Window sizes that tend to be to large seem to drop off in accuracy regardless of the epoch size. for both models window sizes around 8-12 seemed to get good results. 