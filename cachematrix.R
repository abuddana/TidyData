## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
        m <- matrix()
	        set <- function(y) {
		                x <<- y
				m <<- matrix()
				   }
				get <- function() x
setsolve <- function(solve) m <<- solve

getsolve <- function() m
										        list(set = set, get = get, setsolve = setsolve,getsolve = getsolve)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
       m <- x$getsolve()
               if(!is.matrix(m)) {
	                       message("getting cached data")
			                       return(m)
			         }
data <- x$get()
m <- solve(data, ...)	
x$setsolve(m)							               m
m
}
