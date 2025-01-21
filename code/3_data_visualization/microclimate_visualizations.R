library(ggh4x)
library(viridis)

microclimate = read.csv("clean_data/PFTC7_microclimate_south_africa_2023.csv") |>
  mutate(elevation_m_asl = factor(elevation_m_asl, levels = c("3000", "2800", "2600", "2400", "2200", "2000")))

ggplot(microclimate |> drop_na(value), aes(x=value, fill=aspect)) +
  geom_density(alpha=0.6, linewidth = 0.6) +
  scale_fill_manual(values = c("#f9ca00", "#0000f8")) +
  scale_y_continuous(position = "left") +
  facet_nested(elevation_m_asl ~ device + climate_variable, scales = "free", independent = "y",
               nest_line = element_line(linetype = 2),
               labeller = labeller(variable = c(
                 temperature_air = "Air T°C",
                 temperature_leaf = "Leaf T°C",
                 temperature_near_surface = "Near surface T°C",
                 temperature_ground = "Ground T°C",
                 temperature_soil = "Soil T°C",
                 moisture_soil = "Soil moisture %"))) +
  labs(
    y="Density",
    x= "Microclimate value"
  ) +
  theme_bw() +
  theme(
    strip.background = element_blank(),
    ggh4x.facet.nestline = element_line(colour = "black"),
    axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5),
    text=element_text(size=15)
  )

ggsave("outputs/2025.01.16_dataPaper_microclimate.png",
       width = 14, height = 10, units = "in")
