#' Plot and save a unstructured matrix with dimension equals to n
#'
#' @param n dimension of the matrix
#' @param save_path Path to save the chart (.png). If NULL, do not save.
#' @param width Width of the saved chart, in inches.
#' @param height Height of the saved chart, in inches.
#' @param dpi Resolution of the saved chart (dots per inch)
#' @returns a figure
#' @export
#'
#' @examples plot_us(n=5, k = 1, save_path = "plot.png", width = 8, height = 8, dpi = 300)

#'
plot_us = function(n = 5, save_path = NULL, width = 5, height = 5, dpi = 300) {
  # Definition of the structure

  mat = matrix(stats::runif(n*n, 0.2, 1), n, n)
  mat[lower.tri(mat)] = t(mat)[lower.tri(mat)]
  df = reshape2::melt(mat)


  # Estética padrão

  # Definir as cores
  cov_fill_scale <- function(limits = c(0, 1)) {
    # paleta contínua RColorBrewer, zeros → cinza claro
    ggplot2::scale_fill_distiller(
      palette   = "Spectral",
      direction = 1,
      limits    = limits,
      oob       = scales::squish,
      na.value  = "grey90"
    )
  }

  # Definir a base do gráfico
  base_cartoon_plot <- function(df, title) {
    df$fill_val <- ifelse(df$value == 0, NA, df$value)

    ggplot2::ggplot(df, ggplot2::aes(Var1, Var2, fill = fill_val)) +
      ggfx::with_shadow(
        ggplot2::geom_tile(color = "black", size = 1),
        sigma = 5, x_offset = 2, y_offset = 2, colour = "grey50"
      ) +
      cov_fill_scale(limits = c(0, 1)) +
      ggplot2::guides(fill = "none") +
      ggplot2::theme_void() +
      ggplot2::ggtitle(title) +
      ggplot2::theme(
        plot.title      = ggplot2::element_text(family="sans", face="bold", hjust=0.5),
        plot.background = ggplot2::element_rect(fill="transparent", color=NA)
      ) +
      ggplot2::coord_fixed() +
      ggplot2::scale_y_reverse()

  }

  # Estética padrão

  # Definir as cores
  cov_fill_scale <- function(limits = c(0, 1)) {
    # paleta contínua RColorBrewer, zeros → cinza claro
    ggplot2::scale_fill_distiller(
      palette   = "RdBu",
      direction = 1,
      limits    = limits,
      oob       = scales::squish,
      na.value  = "grey90"
    )
  }

  # Definir a base do gráfico
  base_cartoon_plot <- function(df, title) {
    df$fill_val <- ifelse(df$value == 0, NA, df$value)

    ggplot2::ggplot(df, ggplot2::aes(Var1, Var2, fill = fill_val)) +
      ggfx::with_shadow(
        ggplot2::geom_tile(color = "black", size = 1),
        sigma = 5, x_offset = 2, y_offset = 2, colour = "grey50"
      ) +
      cov_fill_scale(limits = c(0, 1)) +
      ggplot2::guides(fill = "none") +
      ggplot2::theme_void() +
      ggplot2::ggtitle(title) +
      ggplot2::theme(
        plot.title      = ggplot2::element_text(family="sans", face="bold", hjust=0.5),
        plot.background = ggplot2::element_rect(fill="transparent", color=NA)
      ) +
      ggplot2::coord_fixed() +
      ggplot2::scale_y_reverse()

  }

  # Plotar a figura
  p = base_cartoon_plot(df, paste0("Unstructured (", n*(n + 1)/2, " params)"))

  # Salvar se o caminho for fornecido
  if (!is.null(save_path)) {
    ggplot2::ggsave(filename = save_path, plot = p, bg = "transparent", width = width, height = height, dpi = dpi)
    message("Plot saved at: ", save_path)
  }

  print(p)
  print(as.matrix(mat))

}
