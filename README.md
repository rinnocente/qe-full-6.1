# quantum espresso  6.1
Quantum Espresso 6.1 

all sources, all binaries

automatically build on hub.docker.com

### Two ways to use it :

1. locally :    
  ```
  docker run -it rinnocente/qe-6.1 /bin/bash
  ```
  and you will be user qe inside the container
 
  
2. locally or remotely thru ssh :
  ```
  CONT=$(docker run -P -itd rinnocente/qe-6.1)
  PORT=$(docker port "$CONT" |sed -e 's/.*://')
  ssh -p "$PORT" qe@127.0.0.1
 ```
 
 initial password is *mammamia* , change it 
 immediately with the command **passwd**
 

