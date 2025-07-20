
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

## Example 1

This is how you can plot and export some common covariance matrices
structures.

``` r
library(DoubleHelix)

#Compound Simetry matrix
plot_cs(n = 5, rho = 0.5, save_path = NULL, width = 5, height = 5, dpi = 300)
```

<img src="man/figures/README-example1-1.png" width="100%" />

    #>      [,1] [,2] [,3] [,4] [,5]
    #> [1,]  1.0  0.5  0.5  0.5  0.5
    #> [2,]  0.5  1.0  0.5  0.5  0.5
    #> [3,]  0.5  0.5  1.0  0.5  0.5
    #> [4,]  0.5  0.5  0.5  1.0  0.5
    #> [5,]  0.5  0.5  0.5  0.5  1.0

    #Unstructured matrix
    plot_us(n = 5, save_path = NULL, width = 5, height = 5, dpi = 300)

<img src="man/figures/README-example1-2.png" width="100%" />

    #>           [,1]      [,2]      [,3]      [,4]      [,5]
    #> [1,] 0.6598788 0.6975810 0.3421267 0.8383801 0.7050982
    #> [2,] 0.6975810 0.8865067 0.7135022 0.5178705 0.5302811
    #> [3,] 0.3421267 0.7135022 0.5677682 0.8614114 0.8361875
    #> [4,] 0.8383801 0.5178705 0.8614114 0.5545617 0.7657574
    #> [5,] 0.7050982 0.5302811 0.8361875 0.7657574 0.2690979

    #First order factor analytic matrix
    plot_fa(n = 5, k = 1, save_path = NULL, width = 5, height = 5, dpi = 300)

<img src="man/figures/README-example1-3.png" width="100%" />

    #>           [,1]      [,2]      [,3]      [,4]      [,5]
    #> [1,] 1.0000000 0.5388534 0.3976723 0.5589675 0.2930423
    #> [2,] 0.5388534 0.5388790 0.3346690 0.4704102 0.2466156
    #> [3,] 0.3976723 0.3346690 0.4955034 0.3471614 0.1820016
    #> [4,] 0.5589675 0.4704102 0.3471614 0.5885863 0.2558211
    #> [5,] 0.2930423 0.2466156 0.1820016 0.2558211 0.4337500

## Example 2

This is how you can do some matrices operation with covariance matrices
using `plot_cov_operations`.

``` r
library(DoubleHelix)

cov1 = plot_diagonal(n=3)
```

<img src="man/figures/README-example2-1.png" width="100%" />

``` r
cov2 = plot_ar1(n=5, rho=0.7)
```

<img src="man/figures/README-example2-2.png" width="100%" />

``` r
library(DoubleHelix)
plot_cov_operations(cov1 = cov1, cov2 = cov2, op="kronecker")
```

<img src="man/figures/README-example3-1.png" width="100%" />

## Development Status

This package is in active development and currently in an experimental
stage.

Contributions are welcome! Feel free to fork the repository, submit pull
requests, or open issues via
[GitHub](https://github.com/filipe-manoel/DoubleHelix).

## License

This package is released under the [MIT
License](https://opensource.org/licenses/MIT).
