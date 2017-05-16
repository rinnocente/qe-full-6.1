# quantum espresso  6.1
Quantum Espresso 6.1 

Quantum Espresso is a well known package for electronic structure computations,
more info at [quantum espresso site](http://quantum-espresso.org).

all sources, all binaries

at every push on github a new image is automatically build on hub.docker.com

### Two ways to use it :

1. locally :    
  ```
  docker run -it rinnocente/qe-full-6.1 /bin/bash
  ```
  and you will be user qe inside the container
 
  
2. locally or remotely thru ssh :
  ```
  CONT=$(docker run -P -itd rinnocente/qe-full-6.1)
  PORT=$(docker port "$CONT" |sed -e 's/.*://')
  ssh -p "$PORT" qe@127.0.0.1
 ```
 
 initial password is *mammamia* , change it 
 immediately with the command **passwd**
 

