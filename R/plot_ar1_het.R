#' Plot and save a heterogeneous first order autoregressive matrix with dimension equals to n
#'
#' @param n   size of the matrix
#' @param rho correlation
#' @param save_path Path to save the chart (.png). If NULL, do not save.
#' @param width Width of the saved chart, in inches.
#' @param height Height of the saved chart, in inches.
#' @param dpi Resolution of the saved chart (dots per inch)
#' @returns a figure
#' @export
#'
#' @examples plot_ar1_het(n=5, rho = 0.7, save_path = 'plot.png', width = 8, height = 8, dpi = 300)

#'
plot_ar1_het = function(n = 5, rho = 0.7, save_path = NULL, width = 5,
  height = 5, dpi = 300) {

  # Definition of the structure

  mat = toeplitz(rho^(0:(n - 1)))
  diag(mat) = rnorm(n, mean = 0.5, sd= 0.49)
  df = reshape2::melt(mat)

  # Estética padrão

  # Definir as cores
  cov_fill_scale <- function(limits = c(0, 1)) {
    # paleta contínua RColorBrewer, zeros → cinza claro
    scale_fill_distiller(palette = "Spectral", direction = 1,
      limits = limits, oob = scales::squish, na.value = "grey90")
  }

  # Definir a base do gráfico
  base_cartoon_plot <- function(df, title) {
    df$fill_val <- ifelse(df$value == 0, NA, df$value)

    ggplot2::ggplot(df, aes(Var1, Var2, fill = fill_val)) +
      ggfx::with_shadow(ggplot2::geom_tile(color = "black",
        size = 1), sigma = 5, x_offset = 2, y_offset = 2,
        colour = "grey50") + cov_fill_scale(limits = c(0,
      1)) + ggplot2::guides(fill = "none") + ggplot2::theme_void() +
      ggplot2::ggtitle(title) + ggplot2::theme(plot.title = ggplot2::element_text(family = "sans",
      face = "bold", hjust = 0.5), plot.background = ggplot2::element_rect(fill = "transparent",
      color = NA)) + ggplot2::coord_fixed() + ggplot2::scale_y_reverse()

  }

  # Plotar a figura

  p = base_cartoon_plot(df, paste0("AR1 Het (", n + 1, " params)"))

  # Salvar se o caminho for fornecido
  if (!is.null(save_path)) {
    ggplot2::ggsave(filename = save_path, plot = p, bg = "transparent",
      width = width, height = height, dpi = dpi)
    message("Plot saved at: ", save_path)
  }

  print(p)
  print(as.matrix(mat))

}
