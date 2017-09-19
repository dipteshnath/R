# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
require(googleVis)
require(shiny)
require(plotly)
## Prepare data to be displayed
library(RCurl)
options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
  output$contents <- renderTable({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath)
  })
  myYear <- reactive({
    input$Year
  })
  
  
  output$year <- renderText({
    paste("Deaths in USA",myYear())
  })
 # e<-read.csv(inFile$datapath)
  output$plot1<-renderPlot({
    inFile <- input$file1
    
    
    if (is.null(inFile))
      return(NULL)
    
    e<-read.csv(inFile$datapath)
    plot(e$state,e$deaths,las=1)
  })
  output$myChart<-renderPlotly({
    death<-read.csv("nchs3.csv")
    
    plot_ly(data = death, x = STATES, y = DEATHS, mode = "markers",
            color = TOTAL)%>%
      layout(autosize = F, width = 800, height = 600)
  })
 
  output$myChart1<-renderPlotly({
    
    nchs<-read.csv("nchs2.csv")
    
    p <- ggplot(nchs, aes(YEAR, DEATHS))
    p + geom_point() + stat_smooth()
    layout(autosize = F, width = 370, height = 270)
    
    
    ggplotly()
  })
  
  output$gvis <- renderGvis({
    inFile <- input$file1
    
    
    if (is.null(inFile))
      return(NULL)
    
    dat<-read.csv(inFile$datapath)
    #dat<-read.csv("e.csv")
    datminmax = data.frame(state=rep(c("Min", "Max"),16), 
                           deaths=rep(c(0, 100),16),
                           year=sort(rep(seq(1998,2013,1),1)))
    dat <- rbind(dat[,1:3], datminmax)
    myYear <- reactive({
      input$Year
    })
    #Show the visualization
    myData <- subset(dat, 
                     (year > (myYear()-1)) & (year < (myYear()+1)))
    gvisGeoChart(myData,
                 locationvar="state", colorvar="deaths",
                 options=list(region="US", displayMode="regions", 
                              resolution="provinces",
                              width=500, height=400,
                              colorAxis="{colors:['#FFFFFF', '#008000']}"
                 ))     
  })
})