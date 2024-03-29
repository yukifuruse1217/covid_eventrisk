# covid_eventrisk_en
#
# The tool is available online at:
# https://yukifuruse.shinyapps.io/covid_eventrisk_en/


# import packages ---------------------------------------------------------
library(shiny)

# ui ----------------------------------------------------------------------
ui <- fluidPage(
  
  # title
  titlePanel("Risk at (mass-gathering) events under COVID-19"),
  
  # Main input and result
  mainPanel(
    # input
    h4("Notes"),
    helpText("The calculations were made with a lot of uncertain assumptions. Please use the tool only as a guide"),
    helpText("It is understandable that some events cannot be cancelled for various reasons"),
    helpText("Even in such cases, please:"),
    helpText("Follow the 3Ws"),
    helpText("- Wear a face mask,"),
    helpText("- Wash your hands, and"),
    helpText("- Watch your distance"),
    helpText("Avoid the 3Cs"),
    helpText("- Closed spaces with poor ventilation,"),
    helpText("- Crowded places with many people nearby, and"),
    helpText("- Close-contact settings such as close-range conversations"),
    br(),

    numericInput("case", 
                 label = h5("Daily number of newly reported cases"),
                 value = 100,
                 min=0),
    
    numericInput("pop", 
                 label = h4("Population in the area"), 
                 value = 100000,
                 min=0),
    
    helpText("The value should be larger than newly reported cases"),
    
    numericInput("attend", 
                 label = h4("Expected attendees at the event"), 
                 value = 30,
                 min=0),
    
    radioButtons("screen", 
                 label = h5("Will a screening for the presence of symptoms be conducted? (Are people with symptoms NOT allowed to attend?)"), 
                 choices = list("Yes" = 1, 
                                "No" = 2),
                 selected = 2),
    
    
    # Results
    br(),
    h3("RESULTS:"),
    h4("Probability that there will be at least one infectious person at the event:"),
    h1(textOutput("outresult1")),
    br(),
    h4("Expected number of infectious people at the event:"),
    h1(textOutput("outresult2")),
    br(),
    h4("Probability that there will be "),
    numericInput("target", 
                 label = h6(""), 
                 value = 2,
                 min=0),
    helpText("(The value should be smaller than expected attendees)"),
    h4("or more infectious people attending the event:"),
    h1(textOutput("outresult3")),
    br(),
    br(),
    h5("日本語版はこちら"),
    h5("https://yukifuruse.shinyapps.io/covid_eventrisk_jp/"),    
    br(),
    helpText("Created 15/Nov/2020, Updated 25/Jan/2022"),
    helpText("furusey.kyoto@gmail.com | @ykfrs1217 (Twitter) | https://furuse-lab.mystrikingly.com/"),
    br(),
    helpText("The website is made by Yuki FURUSE"),
    helpText("Detailed methodlogy: https://www.journalofinfection.com/article/S0163-4453(20)30759-3/fulltext"),
    helpText("Source code: https://github.com/yukifuruse1217/covid_eventrisk/blob/main/shiny_mass_prob_en.R"),
    br(),
    br()
    
  ),
  
  
  # Sidebar with a slider input for options
  sidebarPanel(
    h3("Parameters setting"),
    helpText("You can leave them as default"),
    
    sliderInput("catch", label = h4("Proportion (%) of reported cases among the actual number of infected individuals"),
                min = 1, max = 100, value = 25),
    helpText("Default = 25"),
    helpText("The parameter depends on testing capacity and strategy"),
    sliderInput("inf", label = h4("Infectious period (days)"),
                min = 1, max = 28, value = 10),
    helpText("Default = 10"),
    sliderInput("detect", label = h4("Days from infection to test"),
                min = 0, max = 28, value = 4),
    helpText("Default = 4"),
    helpText('Not from "illness onset" but from "infection." FYI, interval from "infection" to "illness onset" is 2–3 days on average for Omicron'),    
    helpText("The parameter depends on testing capacity and strategy"),    
    sliderInput("asym", label = h4("Proportion (%) of asymptomatic infections among all infections"),
                min = 0, max = 100, value = 33),
    helpText("Default = 33"),    
    sliderInput("asym_power", label = h4("Relative risk (%) of the transmission from asymptomatic individuals compared with that of symptomatic people"),
                min = 0, max = 100, value = 35),
    helpText("Default = 35"),    
    helpText('"Asymptomatic individual" means a person who does not develop symptoms in the entire course of infection. That does not include individuals who have no symptoms at some time point but later develop symptoms'),
    sliderInput("presym", label = h4("Contribution (%) of presymptomatic transmission from eventually-symptomatic individual"),
                min = 0, max = 100, value = 50),
    helpText("Default = 50"),    
    br(),        
    h5("References for the default parameters"),
    h5("SARS-CoV-2 seroprevalence and transmission risk factors among high-risk close contacts: a retrospective cohort study (doi: 10.1016/S1473-3099(20)30833-1)"),
    h5("Temporal dynamics in viral shedding and transmissibility of COVID-19 (doi: 10.1038/s41591-020-0869-5)"),
    h5("The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application (doi: 10.7326/M20-0504)"),
    h5("Occurrence and transmission potential of asymptomatic and presymptomatic SARS-CoV-2 infections: A living systematic review and meta-analysis (doi: 10.1371/journal.pmed.1003346)"),
    h5("Inferred duration of infectious period of SARS-CoV-2: rapid scoping review and analysis of available evidence for asymptomatic and symptomatic COVID-19 cases (doi: 10.1136/bmjopen-2020-039856)"),
    h5("Seroprevalence of anti-SARS-CoV-2 IgG antibodies in Geneva, Switzerland (SEROCoV-POP): a population-based study (doi: 10.1016/S0140-6736(20)31304-0)"),
    h5("Estimated SARS-CoV-2 Seroprevalence in the US as of September 2020 (doi: 10.1001/jamainternmed.2020.7976)"),
    h5("The Proportion of SARS-CoV-2 Infections That Are Asymptomatic : A Systematic Review (doi: 10.7326/M20-6976)"),
    h5("Outbreak caused by the SARS-CoV-2 Omicron variant in Norway, November to December 2021 (doi: 10.2807/1560-7917.ES.2021.26.50.2101147)"),
    h5("Estimation of the test to test distribution as a proxy for generation interval distribution for the Omicron variant in England (doi: 10.1101/2022.01.08.22268920)"),
    h5("Active epidemiological investigation on SARS-CoV-2 infection caused by Omicron variant (Pango lineage B.1.1.529) in Japan: preliminary report on infectious period (https://www.niid.go.jp/niid/en/2019-ncov-e/10884-covid19-66-en.html)")
    
  )
)

# server ------------------------------------------------------------------
server <- function(input, output) {
  df <- function() {  
    
    if (is.na(input$case)) {
      nowcase <- 0
    } else {
      nowcase <- input$case
    }

    if (is.na(input$pop)) {
      nowpop <- 0
    } else {
      nowpop <- input$pop
    }
    
    if (is.na(input$attend)) {
      nowattend <- 0
    } else {
      nowattend <- input$attend
    }
    
    if (is.na(input$target)) {
      nowtarget <- 0
    } else {
      nowtarget <- input$target
    }
    
    # Error process
    if (nowcase >= nowpop) { 
      result <- c("Error", "Error", "Error", nowtarget)
    } else if (nowtarget >= nowattend) { 
      result <- c("Error", "Error", "Error", nowtarget)
    } else if (nowcase <= 0) { 
      result <- c("Error", "Error", "Error", nowtarget)
    } else if (nowpop <= 0) { 
      result <- c("Error", "Error", "Error", nowtarget)
    } else if (nowattend <= 0) { 
      result <- c("Error", "Error", "Error", nowtarget)
    } else if (nowtarget < 0) { 
      result <- c("Error", "Error", "Error", nowtarget)
    } else {
      
      # Calculations
      
      prevalence <- nowcase / (input$catch /100) / nowpop
      prevalence <- prevalence * (1 - (input$catch /100)) * input$inf + prevalence * (input$catch /100) * min(input$inf, input$detect)
      prevalence <- ifelse(prevalence>1, 1, prevalence)
      asymptomatic <- prevalence * (input$asym /100)
      presymptomatic <- (prevalence - asymptomatic) * (input$presym /100)
      
      if (input$screen == 1) {
        eachescape <- 1 - (asymptomatic * (input$asym_power /100) + presymptomatic)
      } else {
        eachescape <- 1 - (prevalence - asymptomatic * (1 - (input$asym_power /100)))
      }
      
      everyescape <- eachescape ^ nowattend
      
      result1 <- round((1 - everyescape) * 100, digits = 1)
      if (result1 == 0) {
        result1 <- "<0.1"
      } else if (result1 == 100) {
        result1 <- ">99.9"
      }
      result1 <- paste0(as.character(result1), "%")
      
      result2 <- round(ceiling(nowattend * (1 -eachescape) *10) / 10, digits = 1)
      
      result3 <- pbinom(q=(nowattend - nowtarget), size=nowattend, prob=eachescape) * 100
      result3 <- round(result3, digits = 1)
      if (result3 == 0) {
        result3 <- "<0.1"
      } else if (result3 == 100) {100
        result3 <- ">99.9"
      }
      result3 <- paste0(as.character(result3), "%")
      
      target1 <- nowtarget
      
      # output
      result <- c(result1, result2, result3, target1)
      
      
      result
    } # Error process    
  }
  
  output$outresult1 <- renderText({
    df()[1]
  })
  
  output$outresult2 <- renderText({
    df()[2]
  })
  
  output$outresult3 <- renderText({
    df()[3]
  })
  
  output$outtarget1 <- renderText({
    df()[4]
  })
  
  
}

# run ---------------------------------------------------------------------
shinyApp(ui = ui, server = server)