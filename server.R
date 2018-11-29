function(input, output, session) {
  
  ## Interactive Map ###########################################
  # Create the map
  
  output$mapa <- renderLeaflet({
    
    pal <- colorFactor("viridis", domain = ubs_malhas$input$indicador[ubs_malhas$modelo == input$modelo])
    
    leaflet() %>% 
      addTiles() %>% 
      setView(lng = -46.64803, lat = -23.64992, zoom = 11) %>% 
      addLegend(
        data = st_transform(ubs_malhas, 4326)[ubs_malhas$modelo == input$modelo, ],
        title = names(vars_setor[vars_setor == input$indicador]),
        pal = pal,
        values = ~input$indicador,
        opacity = 0.7,
        position = "topleft"
      )
    })
    # observe para adicionar cor conforme seleção do indicador
    observe({
      pal <- colorFactor("viridis", domain = ubs_malhas$input$indicador[ubs_malhas$modelo == input$modelo])
      
      # Criar rótulos para os objetos
      labels_setor <- sprintf(
        "<strong>%s</strong><br/>
        CNES: %s<br/>
        Tempo médio até UBS: %g<br/>
        Distância média até UBS: %g<br/>
        Percetual AV: %s<br/>
        AC: %g",
        ubs_malhas$nomeubs[ubs_malhas$modelo == input$modelo],
        ubs_malhas$cnes[ubs_malhas$modelo == input$modelo],
        round(ubs_malhas$media_minutos_ubs[ubs_malhas$modelo == input$modelo], 1),
        round(ubs_malhas$media_minutos_ubs[ubs_malhas$modelo == input$modelo], 1),
        scales::percent(round(ubs_malhas$av_prop_ubs[ubs_malhas$modelo == input$modelo], 3)),
        round(ubs_malhas$ac_ubs[ubs_malhas$modelo == input$modelo], 2)
      ) %>% 
        lapply(htmltools::HTML)
      
      leafletProxy("mapa", data = st_transform(ubs_malhas, 4326)[ubs_malhas$modelo == input$modelo, ]) %>%
        clearShapes() %>%
        addPolygons(
          fillColor = pal(input$indicador),
          weight = 1, 
          opacity = 0.8,
          color = "black",
          fillOpacity = 0.6,
          # adicionar interação
          highlight = highlightOptions(
            weight = 3,
            color = "#666",
            fillOpacity = 0.6,
            bringToFront = FALSE),
          # adicionar pop-up
          label = labels_setor,
          labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "15px",
            direction = "auto")
      )
  })
}
