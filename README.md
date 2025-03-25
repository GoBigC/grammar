Run this command:

```
bash draw.sh BigC.g4
``` 


Then read the produced log file. An unambiguous grammar is one that does not have any "LL(1)? false". If there is any, we gotta fix all of those to be "LL(1)? true". 

If you want to draw a bunch of Augmented Transition Networks (the state machine of the grammar), uncomment the code in `draw.sh` and run the above command again. It's cool visualization but I don't know how to read those graphs. 

`sample.uia` is a sample code file I asked Claude to write, im not entirely sure if it is a good representation of our language, i havent the time to check. 

