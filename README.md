##How to use

* function **checkVideoAvailable** return boolean variable, success or not
* function **showVideoWall** return result of playing video process, the result is a hash likes this: {"totalPoint":3000,"currentPoint":1000,"completed":true,"error":"","consumedPoint":0}
  * completed: boolean type, success or not
  * error: string type, error message  if error exists
  * total, consumed, current: int type, points of domob

####Example
```
domob.checkVideoAvailable(function(result) {
     console.log(result);
});
```

```
domob.showVideoWall(function(data){
	console.log(data);
});
```