
#' @title Cubic Radial Basis
#'
#' @description
#' Construct a natural cubic radial basis function for a given
#' distance set vector and apply as a linear transformation of a
#' covariate matrix.
#'
#' @param x
#'   a vector of values to construct the basis from. Missing values
#'   are not allowed.
#'
#' @param Z
#'   a covariate matrix (or object that can be coerced to a \code{matrix})
#'   to take the basis transformation of.
#'   \code{length(x)} should be the same as \code{ncol(Z)}.
#'   Missing values are not allowed.
#'
#' @param ...
#'   arguments to be passed to \code{\link{lag.basis}}
#'
#' @details
#'   At the time of writing, \code{cr} is little more than a convenient
#'   wrapper to \code{\link{lag.basis}} intended to simplify the task of
#'   specifying lag terms in a model \code{formula}. The longer term goal
#'   is for \code{cr} (and potentially other basis functions) to replace
#'   \code{lag.basis} entirely.
#'
#' @return
#' An S4 object of class \code{\link{SmoothBasis}}.
#'

cr <- function(x, Z, ...) {
  if (any(is.na(x)) || any(is.na(Z)))
    stop ("missing values not allowed")
  if (length(x) != ncol(Z <- as.matrix(Z)))
    stop ("arguments do not have compatible dimensions")
  basis <- lag.basis(x, ...)
  .SmoothLag(Z %*% basis@C0, random = Z %*% basis@K1, basis = basis,
             signature = deparse(sys.call())
             )
}




