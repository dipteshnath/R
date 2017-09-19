require(plotly)
shinyUI(fluidPage(
  titlePanel("Death Analysis Viz"),
  #sidebar
  sidebarLayout(
    sidebarPanel(sliderInput("Year", "Year to be displayed:", 
                             min=1998, max=2013, value=2013,  step=1,
                             format="###0",animate=TRUE),
                 fileInput('file1', 'Choose file to upload',
                           accept = c(
                             'text/csv',
                             'text/comma-separated-values',
                             'text/tab-separated-values',
                             'text/plain',
                             '.csv',
                             '.tsv'
                           )
                 ),
                 tags$hr(),
                 checkboxInput('header', 'Header', TRUE),
                 radioButtons('sep', 'Separator',
                              c(Comma=',',
                                Semicolon=';',
                                Tab='\t'),
                              ','),
                 tags$hr(),
                 p('If you want a sample .csv or .tsv file to upload,',
                   'you can first download the sample',
                   a(href = 'https://drive.google.com/open?id=0B3PmLrEHen8wY2FsSU5ab1pUbGM', 'Accidents-unitentional.csv'), 'or',
                   a(href = 'https://drive.google.com/open?id=0B3PmLrEHen8wTWdJMEs2d0hkX3M', 'Alzheimers-disease.csv'),'or',
                   a(href = 'https://drive.google.com/open?id=0B3PmLrEHen8wY2FsSU5ab1pUbGM', 'Accidents-unitentional.csv'), 'or',
                   a(href = 'https://drive.google.com/open?id=0B3PmLrEHen8wTWdJMEs2d0hkX3M', 'All-Causes.csv'),'or',
                   a(href = 'https://drive.google.com/open?id=0B3PmLrEHen8wazV2TlFRSEQwdmM', 'NCHS.csv'),
                   'files, and then try uploading them.'
                 )
                 
    ),
    #main panel display
    mainPanel(
      
      tabsetPanel(tabPanel("Table" ,tableOutput('contents')),
                  tabPanel("Map Viz", htmlOutput("gvis")),
                  tabPanel("Variation" ,plotOutput('plot1')),
                  tabPanel("Scatter Plot", plotlyOutput("myChart")),
                 # tabPanel("Viz3", plotlyOutput("myChart1")),
                  tabPanel("Dot Plot", plotlyOutput("myChart1")))
    )
  )
))