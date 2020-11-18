library(tidyverse)

mob <- read_csv("/Users/apple/Downloads/applemobilitytrends-2020-11-17.csv")

head(mob)

regions <- mob$region %>% unique()

grep("washington", names(regions), value = T, ignore.case = T)

mob %>%
  filter(geo_type == "sub-region") %>% View()


mob_wa <- mob %>%
  filter(region == "Washington") %>%
  select(-c(geo_type, region, alternative_name, `sub-region`, country)) %>%
  gather("date", "value", -transportation_type) %>%
  mutate("date_ymd" = lubridate::ymd(date))

ggplot(mob_wa, aes(x = date_ymd, y = value, group = transportation_type)) +
  geom_line(aes(color = transportation_type)) +
  geom_vline(xintercept = lubridate::ymd("2020-03-23"),
             linetype = "dashed",
             size = .3) +
  annotate("text",
           y = 200,
           x = lubridate::ymd("2020-03-25"),
           label = "Stay at Home Order") +
  theme_minimal() +
  labs(title = "Mobility Trends - Washington State: January-November, 2020",
       subtitle = "Data from covid19.apple.com/mobility",
       y = "Mobility",
       x = "Date",
       color = "Transportation Type")


