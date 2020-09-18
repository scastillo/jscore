# jscore
similarity score for json objects

## Notes
There are many ways to think about similarities on an open json schema
The best approach would be taylored to the problem at hand.

In general terms the approach followd by _jscore_ is to identify the max number of opportunities 
to be similar and then count how many of those are a match between the objects.


An opportunity to be similar would be for example wheter or not both objects have the same number of keys and values or if for a given key the corresponding child is the same. 

You may think of this problem as an edition distance problem like the levenshtein distance where the score or distance is the number of editions you need to perform to go from one string to the other.

Speaking of approx solutions its interesting to explore the power that a word2vec model approximating the final score using a NN.



## run example
```bash
ruby bin/jscore.rb data/BreweriesMaster.json data/BreweriesMaster.json
```

## TODO
* The `cap` or max number of similarities oportunities needs to be revisited to improve accuaricy
* Unit test 
* Make gem bundler friendly
* Improve code readability by apliting responsabilities to smaller functions

See open issues for more
