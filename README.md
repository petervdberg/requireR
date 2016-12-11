The requireR package can be used to modularize your code. Using requireR, your system components can be separated and combined easier. The requireR packages is inspired by the JavaScript library *requireJS*. 

Files will become **selfcontained**. Modules can contain private variables and functions, and only communicate via their interface variables.

The global environment can stay **clean**. (almost) no variables end up in the global environment, so no more name collisions or related problems.

Depedencies are always **explicified**. Each file contains all its dependencies, so you directly see where the file is dependent on.

A typical use case is the following:

*hello.R<br>
requireR(function() {<br>
&nbsp;&nbsp;"hello"<br>
}<br>

*world.R<br>
requireR(function() {<br>
&nbsp;"world"<br>
})<br>

requireR(<br>
&nbsp;"hello.R",<br>
&nbsp;"world.R",<br>
&nbsp;function(hello, world) {<br>
&nbsp;&nbsp;paste(hello, world)<br>
})<br>

As you can see, all code is wrapped within the requireR function. The variables 'hello' and 'world' can only be used within the wrapped function, and do not end up in the global scope.

You can also use requireR within your module-less code (although this is not recommended)
hello <- requireR("hello.R")
world <- requireR("world.R")
paste(hello, world)
