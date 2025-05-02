library(leaflet)
library(dplyr)

# Define the coordinates
sites <- data.frame(
  name = c("CTC", "NCORE", "HOUSE"),
  lat = c(64.841, 64.84569, 64.850),
  lon = c(-147.727, -147.727413, -147.676),
  color = c("red", "#006400", "skyblue"),
  direction = c("bottom", "top", "top")
)

# Create the map with different style options - uncomment the style you prefer

fairbanks_map <- leaflet() %>%
  # Option 1: Carto Positron (clean, light style)
  #addProviderTiles(providers$CartoDB.Positron) %>%
  
  # Option 2: Dark Matter (dark style)
  # addProviderTiles(providers$CartoDB.DarkMatter) %>%
  
  # Option 3: Satellite with labels
   addProviderTiles(providers$Esri.WorldImagery) %>%
  # addProviderTiles(providers$CartoDB.PositronOnlyLabels) %>%  # Adds labels over satellite
  
  # Option 4: Colorful terrain
   #addProviderTiles(providers$Stamen.Terrain) %>%
  
# Option 5: Watercolor style (artistic)
 #addProviderTiles(providers$Stamen.Watercolor) %>%
 #addProviderTiles(providers$CartoDB.PositronOnlyLabels) %>%  # Adds labels over watercolor

setView(lng = -147.7, lat = 64.845, zoom = 12) %>%
  addCircleMarkers(
    data = sites,
    lng = ~lon,
    lat = ~lat,
    color = "black",     
    weight = 2,          
    fillColor = ~color,  
    fillOpacity = 0.8,   
    radius = 8,          
    stroke = TRUE        
  )

# Add labels with custom style for each site
for(i in 1:nrow(sites)) {
  fairbanks_map <- fairbanks_map %>%
    addLabelOnlyMarkers(
      lng = sites$lon[i],
      lat = sites$lat[i],
      label = sites$name[i],
      labelOptions = labelOptions(
        noHide = TRUE,
        direction = sites$direction[i],
        offset = if(sites$direction[i] == "bottom") c(0, 10) else c(0, -10),
        textOnly = TRUE,
        style = list(
          "color" = "white",
          "font-weight" = "bold",
          "font-size" = "14px",
          "background-color" = sites$color[i],
          "border" = "2px solid white",
          "padding" = "5px",
          "border-radius" = "4px",
          "box-shadow" = "3px 3px 10px rgba(0,0,0,0.5)"
        )
      )
    )
}

# Display the map
fairbanks_map
