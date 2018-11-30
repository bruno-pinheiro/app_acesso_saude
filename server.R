function(input, output, session) {
  
  ## Interactive Map ###########################################
  
  # Create pallete
  colorpal <- reactive({
    colorFactor("viridis", as.data.frame(ubs_malhas)[ubs_malhas$modelo == input$modelo, input$indicador])
  })
  
  indic.select <- isolate(switch(input$indicador,
                                 vars_setor))
  
  # Criar rótulos para os objetos
  labels_setor <- reactive({
    sprintf(
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
    ) %>% lapply(htmltools::HTML)
  })
  
  output$mapa <- renderLeaflet({
    
    pal <- colorpal()
    
    leaflet() %>% 
      addProviderTiles(providers$OpenStreetMap.BlackAndWhite) %>% 
      setView(lng = -46.64803, lat = -23.64992, zoom = 11)
  })
  
    # observe para adicionar cor conforme seleção do indicador
    observe({
      pal <- colorpal()
      var <- input$indicador
      
      leafletProxy("mapa", data =  st_transform(ubs_malhas, 4326)[ubs_malhas$modelo == input$modelo, ]) %>% 
        clearShapes() %>%
        addPolygons(
          fillColor = pal(var),
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
          label = labels_setor(),
          labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "15px",
            direction = "auto")
          )
      })
    
    observe({
      pal <- colorpal()
      
      leafletProxy("mapa", data =  st_transform(ubs_malhas, 4326)[ubs_malhas$modelo == input$modelo, ]) %>% 
        addLegend(
          data = st_transform(ubs_malhas, 4326)[ubs_malhas$modelo == input$modelo, ],
          title = names(vars_setor[vars_setor == input$indicador]),
          pal = pal,
          values = ~input$indicador,
          opacity = 0.7,
          position = "topleft"
        )
    })
  }


