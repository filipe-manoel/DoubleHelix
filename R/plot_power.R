#' Plot and save a power matrix with dimension equals to n
#'
#' @param n   size of the matrix
#' @param rho correlation
#' @param save_path Caminho para salvar o gráfico (.png). Se NULL, não salva.
#' @param width Largura do gráfico salvo, em polegadas.
#' @param height Altura do gráfico salvo, em polegadas.
#' @param dpi Resolução do gráfico salvo (dots per inch)
#' @returns a figure
#' @export
#'
#' @examples plot_power(n=5, rho = 0.7, save_path = "plot.png", width = 8, height = 8, dpi = 300)

#'
plot_power = function(n = 5, rho = 0.7, save_path = NULL, width = 5, height = 5, dpi = 300) {

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

  mat = outer(1:n, 1:n, function(i, j) rho^abs(i-j))
  df = reshape2::melt(mat)
  p = base_cartoon_plot(df, paste0("Power (2 params)"))

  # Salvar se o caminho for fornecido
  if (!is.null(save_path)) {
    ggplot2::ggsave(filename = save_path, plot = p, bg = "transparent", width = width, height = height, dpi = dpi)
    message("Plot saved at: ", save_path)
  }

  print(p)

}
