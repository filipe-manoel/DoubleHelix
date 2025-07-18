#' Plot and save a kth order factor analityc matrix with dimension equals to n
#'
#' @param n   size of the matrix
#' @param k   order of FA
#' @param save_path Path to save the chart (.png). If NULL, do not save.
#' @param width Width of the saved chart, in inches.
#' @param height Height of the saved chart, in inches.
#' @param dpi Resolution of the saved chart (dots per inch)
#' @returns a figure
#' @export

#' @examples plot_fa(n=5, k = 1, save_path = "plot.png", width = 8, height = 8, dpi = 300)

#'
plot_fa = function(n = 5, k = 1, save_path = NULL, width = 5, height = 5, dpi = 300) {

  # Estética padrão
  base_cartoon_plot = function(df, title, gray_zero = FALSE) {
    palette_colors = c("#f4a582", "#92c5de", "#d5d5d5", "#a6d854", "#ffd92f", "#e78ac3")

    if (gray_zero) {
      df$value_plot = ifelse(df$value == 0, NA, df$value)
      p = ggplot2::ggplot(df, ggplot2::aes(Var1, Var2, fill = value_plot)) +
        ggfx::with_shadow(ggplot2::geom_tile(color = "black", size = 1), sigma = 5, x_offset = 2, y_offset = 2, colour = "grey50") +
        ggplot2::scale_fill_gradientn(colors = palette_colors, na.value = "grey90") +
        ggplot2::guides(fill = "none")
    } else {
      p = ggplot2::ggplot(df, ggplot2::aes(Var1, Var2, fill = value)) +
        ggfx::with_shadow(ggplot2::geom_tile(color = "black", size = 1), sigma = 5, x_offset = 2, y_offset = 2, colour = "grey50") +
        ggplot2::scale_fill_gradientn(colors = palette_colors) +
        ggplot2::guides(fill = "none")
    }

    p +
      ggplot2::theme_void() +
      ggplot2::ggtitle(title) +
      ggplot2::theme(
        plot.title = ggplot2::element_text(family = "sans", size = 13, hjust = 0.5, face = "bold"),
        plot.background = ggplot2::element_rect(fill = "transparent", color = NA)
      ) +
      ggplot2::coord_fixed() +
      ggplot2::scale_y_reverse()
  }

  # Definition of the structure

  L = matrix(runif(n * k, 0.5, 1.5), nrow = n, ncol = k)
  D = diag(runif(n, 0.2, 1))
  cov_matrix = L %*% t(L) + D
  df = reshape2::melt(cov_matrix)
  total_params = n + n * k  # n específicos + n*k cargas fatoriais
  title = paste0("FA(", k, ") with ", total_params, " params")
  p = base_cartoon_plot(df, title)

  # Salvar se o caminho for fornecido
  if (!is.null(save_path)) {
    ggplot2::ggsave(filename = save_path, plot = p, bg = "transparent", width = width, height = height, dpi = dpi)
    message("Plot saved at: ", save_path)
  }

  print(p)

}
