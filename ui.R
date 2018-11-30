# Choices for drop-downs
navbarPage("Acessibilidade à saúde básica", id="nav",
           
           tabPanel("Mapa interativo",
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css"),
                          includeScript("gomap.js")
                        ),
                        
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("mapa", width="100%", height="100%"),
                        
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      
                                      h2("Interaja"),
                                      
                                      selectInput("modelo", "Modelo", vars_modelo, selected = "vigente"),
                                      selectInput("indicador", "Indicador", vars_setor, selected = "minutos_classes_setor"),
                                      selectInput("cores", "Esquema de cores",
                                                  rownames(subset(brewer.pal.info, category %in% "seq"))),
                                      plotOutput("densIndicador", height = 200),
                                      valueBoxOutput("media_indicador", width = 250)
                        ),
                        
                        tags$div(id="cite",
                                 'Dados compilados na pesquisa ', tags$em('Mobilidade e desigualdades na cidade de São Paulo'), ' por Bruno Pinheiro e Alexandre Leichsenring (2018).'
                                 )
                        )
                    )
           )

