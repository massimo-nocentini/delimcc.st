I have models for Hansei, which `HanseiTest` explores, except the one with a cloud:

- the wet grass, with rain and sprinkler (`grassModelPriorRain:rain:priorSprinkler:sprinkler:otherwise:`), and with a cloud too (`grassModelWithCloud:rain:sprinkler:otherwise:`): the probability of rain, given that the grass is wet;
- the coin of a drunk, which may get lost (`drunkProb:lostProb:`), and whether `n` tosses of it are all true (`drunkCoin:drunkProb:lostProb:`);
- random strings of parentheses (`catalanParens:pickProb:`).