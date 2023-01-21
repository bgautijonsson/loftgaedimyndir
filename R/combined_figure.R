library(patchwork)


p_aligned <- align_patches(
  p1, p2, p3, p4
)

p <- (p1 + labs(caption = NULL)) + 
  (p2 + labs(caption = NULL)) +
  (p3 + labs(caption = NULL)) + 
  p4 +
  plot_layout(ncol = 2) &
  theme(
    plot.title = element_text(size = 15),
    plot.subtitle = element_markdown(size = 12)
  ) 


ggsave(
  plot = p,
  filename = "Figures/combined_image.png",
  width = 8, height = 0.621 * 8, scale = 2
)