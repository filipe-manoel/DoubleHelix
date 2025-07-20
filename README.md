
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DoubleHelix

<!-- badges: start -->
<!-- badges: end -->

The goal of `DoubleHelix` is to provide a quick and easy way to create
engaging visual resources, including figures, GIFs, and formulas, based
on the theory of quantitative genetics.

This package aims to make these resources more accessible to instructors
and students, supporting teaching and learning in genetics and
quantitative genetics through intuitive and customizable visualizations.

## Installation

You can install the development version of `DoubleHelix` from
[GitHub](https://github.com/filipe-manoel/DoubleHelix) with:

``` r
# install.packages("pak")
pak::pak("filipe-manoel/DoubleHelix")
```

## Examples

This is how you can plot and export some common covariance matrices
structures.

``` r
library(DoubleHelix)

#Compound Simetry matrix
plot_cs(n = 5, rho = 0.5, save_path = NULL, width = 5, height = 5, dpi = 300)
```

<img src="man/figures/README-example1-1.png" width="100%" />

``` r

#Unstructured matrix
plot_us(n = 5, save_path = NULL, width = 5, height = 5, dpi = 300)
```

<img src="man/figures/README-example1-2.png" width="100%" />

``` r

#First order factor analytic matrix
plot_fa(n = 5, k = 1, save_path = NULL, width = 5, height = 5, dpi = 300)
```

<img src="man/figures/README-example1-3.png" width="100%" />

This is how you can do some matrices operation with covariance matrices
using `plot_cov_operations`.

## Development Status

This package is in active development and currently in an experimental
stage.

Contributions are welcome! Feel free to fork the repository, submit pull
requests, or open issues via
[GitHub](https://github.com/filipe-manoel/DoubleHelix).

## License

This package is released under the [MIT
License](https://opensource.org/licenses/MIT).
