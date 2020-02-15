# SandSim

Particle physics simulation using circles

### Game structure

- **root**
    + world
        * objects
            - ball1
            - ball2
            - ball3
            - ...
        * x
        * y
        * g
        * gobalDrag
        * updateSpeed
    + system
        * startTime
        * window
            - x
            - y
        * fps
        * ups
        * input
            - mouseState
            - mode
            - eTime
            - qTime
            - pullSpeed
            - currentBall

### Main to-do

- [ ] **Basic collisions / physics**

    [tutorial](https://github.com/OneLoneCoder/videos/blob/master/OneLoneCoder_Balls1.cpp)

    - [x] **Static**
      
        ```lua

        local distance = math.sqrt(getDistance2(A, B))

        local overlap = (distance - A.r - B.r) / 2

        A.x = A.x - overlap * (A.x - B.x) / distance
        A.y = A.y - overlap * (A.y - B.y) / distance

        B.x = B.x + overlap * (A.x - B.x) / distance
        B.y = B.y + overlap * (A.y - B.y) / distance

    	```
    	
    - [x] **Dynamic**
      [wikipedia](https://en.wikipedia.org/wiki/Elastic_collision)
		
    	```lua

        distance = math.sqrt(getDistance2(A, B))
        local e = math.min(A.e, B.e)
      
        local nx = (B.x - A.x) / distance;
        local ny = (B.y - A.y) / distance;
      
        local tx = -ny;
        local ty = nx;
      
        local dpTan1 = A.vx * tx + A.vy * ty;
        local dpTan2 = B.vx * tx + B.vy * ty;
      
        local dpNorm1 = A.vx * nx + A.vy * ny;
        local dpNorm2 = B.vx * nx + B.vy * ny;
      
        local m1 = 
        (dpNorm1 * (A.m - B.m) + 2 * B.m * dpNorm2) / (A.m + B.m);
        local m2 = 
        (dpNorm2 * (B.m - A.m) + 2 * A.m * dpNorm1) / (A.m + B.m);
      
        A.vx = tx * dpTan1 + nx * m1 * e;
        A.vy = ty * dpTan1 + ny * m1 * e;
        B.vx = tx * dpTan2 + nx * m2 * e;
        B.vy = ty * dpTan2 + ny * m2 * e;

    	```

- [ ] **Optimization**
        - [ ] **Faster static collision**
        - [ ] **Faster dynamic collision**
        - [ ] **Faster loops**
    
- [ ] **Player interaction**
- [ ] **Sand**