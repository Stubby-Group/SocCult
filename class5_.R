pacman::p_load(tidyverse,
               here,
               network,
               igraph,
               ggraph,
               tidygraph,
               patchwork)

EdgesDataset <- read_csv(
  "Filename.csv") %>% 
  subset(
    !is.na(to) & !is.na(from) & !is.na(weight) # removing odd NAs
  )

EdgesDataset <- EdgesDataset %>% subset(
  !(to %in% c("fake0", "fake", "100", "1")) & !(from %in% c("fake0", "fake", "100", "1") & !is.na(to) & !is.na(from))
)

Graph <-
  graph_from_data_frame(d = EdgesDataset,
                        vertices = CogSci_2019_nodes,
                        directed = TRUE)

E(Graph)$arrow.mode <- 0
V(Graph)$label <- ""
E(Graph)$width <- edge_attr(Graph)$weight

plot(Graph,
     layout = layout_on_sphere, # Explore layouts!
     edge.arrow.size = 0.2)

wc1 <- cluster_walktrap(Graph)
plot(wc1, Graph)

