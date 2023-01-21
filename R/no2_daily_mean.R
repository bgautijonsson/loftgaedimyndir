colour_2023 <- "black"
colour_other <- "grey70"

plot_dat <- d |> 
  filter(
    station_name == "Grensásvegur"
  ) |> 
  mutate(
    month = month(dagsetning),
    year = year(dagsetning),
    yday = yday(dagsetning)
  ) |> 
  filter(yday <= day_stop) |> 
  pivot_longer(c(pm10:loftthr)) |> 
  group_by(year, yday, station_name, name) |> 
  summarise(
    max = max(value, na.rm = T),
    mean = mean(value, na.rm = T),
    .groups = "drop"
  ) |> 
  filter(
    name %in% c("no2")
  ) |> 
  drop_na() |> 
  mutate(
    colour = ifelse(year == 2023, colour_2023, colour_other),
    linewidth = ifelse(year == 2023, 1, 0)
  )

p2 <- plot_dat |> 
  ggplot(aes(yday, mean)) +
  geom_texthline(
    yintercept = 75,
    lty = 2, 
    alpha = 0.3, 
    size = 4, 
    linewidth = 0.3, 
    label = "Dagsmörk", 
    hjust = 0.4
  ) +
  geom_line(
    data = plot_dat |> filter(year != 2023),
    aes(group = year, col = colour, linewidth = linewidth),
    alpha = 0.6
  ) +
  geom_point(
    data = plot_dat |> filter(year != 2023),
    aes(group = year, col = colour, size = linewidth),
    alpha = 0.6
  ) +
  geom_line(
    data = plot_dat |> filter(year == 2023),
    aes(group = year, col = colour, linewidth = linewidth)
  ) +
  geom_point(
    data = plot_dat |> filter(year == 2023),
    aes(group = year, col = colour, size = linewidth)
  ) +
  scale_x_continuous(
    breaks = seq_len(day_stop),
    labels = label_number(suffix = ".")
  ) +
  scale_y_continuous(
    limits = c(0, 200),
    expand = expansion()
  ) +
  scale_colour_identity() +
  scale_linewidth_continuous(
    range = c(1, 1.3)
  ) +
  scale_size_continuous(
    range = c(2, 3.5)
  ) +
  theme(
    legend.position = "none",
    plot.subtitle = element_markdown()
  ) +
  labs(
    x = NULL,
    y = NULL,
    title = "Daglegt meðaltal köfnunarefnisdíoxíðsmælinga (NO2)",
    subtitle = str_c(
      "Sýnt fyrir fyrstu daga janúar árið ",
      glue("<b style='color:{colour_2023}'>"),
      "2023 ",
      "</b>",
      "borið saman við  ",
      glue("<b style='color:{colour_other}'>"),
      "2019 - 2022",
      "</b>"
    ),
    caption = str_c(
      "Byggt á gögnum frá loftgaedi.is",
      "\n",
      "Gögn og kóði: https://github.com/bgautijonsson/loftgaedi"
    )
  )

ggsave(
  plot = p2,
  filename = "Figures/no2_mean.png",
  width = 8, height = 0.621 * 8, scale = 1.3
)