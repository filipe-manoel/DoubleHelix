#' Plot operation between two covariance structures in cartoon style
#'
#' @param cov1 A covariance matrix (numeric matrix).
#' @param cov2 A covariance matrix (numeric matrix).
#' @param op Character; one of "kronecker", "direct_sum", "hadamard", "sum", "matprod".
#' @param name1 Label for the first matrix (default "cov1").
#' @param name2 Label for the second matrix (default "cov2").
#' @param save_path File path to save the combined plot as PNG. If NULL, the plot is not saved.
#' @param width Width of saved chart in inches.
#' @param height Height of saved chart in inches.
#' @param dpi Resolution (dots per inch) for saving.
#' @return A combined ggplot object showing cov1, operation symbol, cov2, equals, and result.
#' @export
#' @param limits Numeric vector of length 2; c(min, max) dos valores não‑zero.
#' @return A ggproto scale for fill.
#' @export


plot_cov_operations = function(cov1, cov2,
                               op = c("kronecker", "direct_sum", "hadamard", "sum", "matprod"),
                               name1 = "cov1", name2 = "cov2",
                               save_path = NULL, width = 10, height = 4, dpi = 300) {
  op = match.arg(op)

  # Símbolos Unicode
  symbols = list(
    kronecker  = "\u2297",  # ⊗
    direct_sum = "\u2295",  # ⊕
    hadamard   = "\u2218",  # ∘
    sum        = "+",
    matprod    = "%*%"
  )
  sym = symbols[[op]]

  # Computa resultado
  result = switch(op,
                   kronecker  = kronecker(cov1, cov2),
                   direct_sum = {
                     rbind(
                       cbind(cov1, matrix(0, nrow(cov1), ncol(cov2))),
                       cbind(matrix(0, nrow(cov2), ncol(cov1)), cov2)
                     )
                   },
                   hadamard   = cov1 * cov2,
                   sum        = cov1 + cov2,
                   matprod    = cov1 %*% cov2
  )


  # Derrete matrizes
  df1 = reshape2::melt(cov1)
  df2 = reshape2::melt(cov2)
  dfR = reshape2::melt(result)

  # Define limites do gradiente a partir de todos os valores não‑zero
  all_vals = c(df1$value, df2$value, dfR$value)
  lims    = range(all_vals[all_vals != 0], na.rm = TRUE)


  # Estética padrão

  # Definir as cores

  cov_fill_scale = function(limits = c(0, 1)) {
    # paleta contínua RColorBrewer, zeros → cinza claro
    scale_fill_distiller(
      palette   = "YlOrRd",
      direction = 1,
      limits    = limits,
      oob       = scales::squish,
      na.value  = "grey90"
    )
  }


  base_cartoon_plot = function(df, title) {
    df$fill_val = ifelse(df$value == 0, NA, df$value)

    ggplot2::ggplot(df, ggplot2::aes(Var1, Var2, fill = fill_val)) +
      ggfx::with_shadow(
        ggplot2::geom_tile(color = "black", size = 1),
        sigma    = 5, x_offset = 2, y_offset = 2, colour = "grey50"
      ) +
      cov_fill_scale(limits = lims) +   # usa escala contínua comum
      ggplot2::guides(fill = "none") +
      ggplot2::theme_void() +
      ggplot2::ggtitle(title) +
      ggplot2::theme(
        plot.title      = ggplot2::element_text(family = "sans",
                                                size   = 13,
                                                hjust  = 0.5,
                                                face   = "bold"),
        plot.background = ggplot2::element_rect(fill = "transparent",
                                                color = NA)
      ) +
      ggplot2::coord_fixed() +
      ggplot2::scale_y_reverse()
  }

  # Gera os três blocos
  p1 = base_cartoon_plot(df1, name1)
  p2 = base_cartoon_plot(df2, name2)
  pR = base_cartoon_plot(dfR, paste0("Result"))

  # Plot de símbolos

  txt_plot = function(label) {
    df_txt = data.frame(x = 1, y = 1, label = label)
    ggplot2::ggplot(df_txt, ggplot2::aes(x, y, label = label)) +
      ggfx::with_shadow(
        ggplot2::geom_text(size = 20, family = "sans"),
        sigma = 1, x_offset = 1, y_offset = 1
      ) +
      ggplot2::xlim(0,2) + ggplot2::ylim(0,2) +
      ggplot2::theme_void()
  }


  p_sym = txt_plot(sym)
  p_eq  = txt_plot("=")

  # Combina em linha
  combined = p1 + p_sym + p2 + p_eq + pR +
    patchwork::plot_layout(nrow = 1, widths = c(1, .2, 1, .2, 1))

  # Salva se solicitado
  if (!is.null(save_path)) {
    ggplot2::ggsave(save_path, combined,
                    bg     = "transparent",
                    width  = width,
                    height = height,
                    dpi    = dpi)
    message("Plot saved at: ", save_path)
  }

  print(combined)

}

cov1 = plot_ar1()
cov2 = plot_ar1(3, 0.3)

plot_cov_operation(cov1, cov2)

