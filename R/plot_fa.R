#' Plot and save a kth order factor analytic matrix scaled to max = 1
#'
#' @param n   size of the matrix
#' @param k   order of FA
#' @param save_path Path to save the chart (.png). If NULL, do not save.
#' @param width Width of the saved chart, in inches.
#' @param height Height of the saved chart, in inches.
#' @param dpi Resolution of the saved chart (dots per inch)
#' @returns a figure
#' @export
#'
#' @examples plot_fa(n=5, k = 1, save_path = "plot.png", width = 8, height = 8, dpi = 300)
plot_fa = function(n = 5, k = 1, save_path = NULL, width = 5, height = 5, dpi = 300) {

  # Step 1: gerar matriz FA
  L = matrix(runif(n * k, 0.5, 1.5), nrow = n, ncol = k)
  D = diag(runif(n, 0.2, 1))
  cov_matrix = L %*% t(L) + D

  # Step 2: normalizar para valores entre 0 e 1
  cov_matrix = cov_matrix / max(cov_matrix)

  df = reshape2::melt(cov_matrix)
  total_params = n + n * k  # n específicos + n*k cargas fatoriais
  title = paste0("FA(", k, ") scaled (", total_params, " params)")

  # Step 3: escala de preenchimento contínua até 1
  cov_fill_scale <- function(limits = c(0, 1)) {
    ggplot2::scale_fill_distiller(
      palette   = "Spectral",
      direction = 1,
      limits    = limits,
      oob       = scales::squish,
      na.value  = "grey90"
    )
  }

  # Step 4: base do gráfico cartoon
  base_cartoon_plot <- function(df, title) {
    df$fill_val <- ifelse(df$value == 0, NA, df$value)

    ggplot2::ggplot(df, aes(Var1, Var2, fill = fill_val)) +
      ggfx::with_shadow(
        ggplot2::geom_tile(color = "black", size = 1),
        sigma = 5, x_offset = 2, y_offset = 2, colour = "grey50"
      ) +
      cov_fill_scale(limits = c(0, 1)) +
      ggplot2::guides(fill = "none") +
      ggplot2::theme_void() +
      ggplot2::ggtitle(title) +
      ggplot2::theme(
        plot.title      = ggplot2::element_text(family = "sans", face = "bold", hjust = 0.5),
        plot.background = ggplot2::element_rect(fill = "transparent", color = NA)
      ) +
      ggplot2::coord_fixed() +
      ggplot2::scale_y_reverse()
  }

  # Step 5: plotar figura
  p = base_cartoon_plot(df, title)

  if (!is.null(save_path)) {
    ggplot2::ggsave(save_path, plot = p, bg = "transparent", width = width, height = height, dpi = dpi)
    message("Plot saved at: ", save_path)
  }

  print(p)
  print(as.matrix(cov_matrix))
}

