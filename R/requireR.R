#' Loads given files and modularizes the given function
#'
#' @param ... A set of filenames, and/or ending with the modularizable function.
#' @examples
#' \dontrun{
#' #hello.R
#' requireR(function() {
#'   "hello"
#' })
#'
#' #world.R
#' requireR(function() {
#'   "world"
#' })
#'
#' requireR(
#'   "hello.R",
#'    "world.R",
#'    function(hello, world) {
#'      paste(hello, world)
#'    })
#' }
#' @export
requireR <- function(...) {
  load_dependency <- function(dependency) {
    if(!exists(dependency, attr(requireR, "environment"))) {
      if(!file.exists(dependency)) stop(sprintf("The file '%s' does not exist.", dependency))
      attr(requireR, "environment")[[dependency]] <<- source(dependency)$value
    }
    attr(requireR, "environment")[[dependency]]
  }

  arguments <- list(...)
  argument_count <- length(arguments)
  if(argument_count == 0) stop("No dependencies or functions passed.")
  no_creator_passed <- argument_count == 1 && class(arguments[[1]]) == "character"
  if(no_creator_passed) {
    load_dependency(arguments[[1]])
  } else {
    creator <- arguments[[argument_count]]
    dependency_files <- arguments[-argument_count]
    dependency_objects <- list()
    for(dependency_file in dependency_files) {
      dependency_objects[[length(dependency_objects) + 1]] <- load_dependency(dependency_file)
    }
    do.call(creator, dependency_objects)
  }
}

attr(requireR, "environment") <- new.env(parent = emptyenv())
