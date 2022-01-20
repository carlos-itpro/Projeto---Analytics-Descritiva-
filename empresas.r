install.packages("tidyverse")

library(tidyverse)

database <- read_csv("database.csv")

database_v2 <- select(database, - data_encerramento)

database %>% filter(nome_bairro == "VARZEA")

db_varzea <- database %>% filter(nome_bairro == "VARZEA")

dbteste <- database_limpa %>%
  group_by(nome_bairro) %>%
  summarise()

names(dbteste)  

database_v3 <- left_join(database_limpa,habitantes,by=c("nome_bairro" = "Bairros"))  
write_csv(database_v3,"database_full.csv")
