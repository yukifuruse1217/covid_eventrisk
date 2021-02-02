# covid_eventrisk_jp
#
# The tool is available online at:
# https://yukifuruse.shinyapps.io/covid_eventrisk_jp/


# import packages ---------------------------------------------------------
library(shiny)

# ui ----------------------------------------------------------------------
ui <- fluidPage(
  
  # title
  titlePanel("新型コロナの流行状況にもとづくイベント開催リスク"),
  
  # Main input and result
  mainPanel(
    # input
    h4("使用上の注意"),
    helpText("簡易的なツールであり、多くの不確定な要素が含まれていますので、参考程度に用いてください"),
    helpText("中止や延期のできない集会やイベントもきっとあると思います"),
    helpText("どんなときも、そこに感染者がいるかもしれないと意識して、できる範囲で"),
    helpText("・３密を避けましょう！"),
    helpText("・マスクを着用しましょう！"),
    helpText("・手を洗いましょう！"),
    
    numericInput("case", 
                 label = h4("１日あたりの新規感染（報告）者数"), 
                 value = 100,
                 min=0),
    
    numericInput("pop", 
                 label = h4("地域の人口"), 
                 value = 100000,
                 min=0),
    
    helpText("新規感染者数よりも大きい値を入力してください"),
    
    numericInput("attend", 
                 label = h4("イベントの参加人数"), 
                 value = 30,
                 min=0),
    
    radioButtons("screen", 
                 label = h5("症状スクリーニングが行われますか？（有症状者は参加できないようになっていますか？）"), 
                 choices = list("Yes" = 1, 
                                "No" = 2),
                 selected = 1),
    
    
    # Results
    br(),
    h3("計算結果："),
    h4("少なくとも１人の「感染性のある人」が、イベントに参加する確率は："),
    h1(textOutput("outresult1")),
    br(),
    h4("イベントに参加する「感染性のある人」の予想人数は："),
    h1(textOutput("outresult2")),
    br(),
    h4("「感染性のある人」が、"),
    numericInput("target", 
                 label = h6(""), 
                 value = 2,
                 min=0),
    helpText("(イベントの参加人数よりも小さい値を入力してください)"),
    h4("人以上イベントに参加する確率は："),
    h1(textOutput("outresult3")),
    br(),
    br(),
    h5("English version:"),
    h5("https://yukifuruse.shinyapps.io/covid_eventrisk_en/"),
    br(),
    helpText("作成 2020/11/10, 更新 2021/2/2"),
    helpText("furusey.kyoto@gmail.com | @ykfrs1217 (Twitter) | https://furuse-lab.mystrikingly.com/"),
    br(),
    helpText("このページは古瀬祐気が作りました"),
    helpText("作成者は、厚生労働省のクラスター対策班に所属していますが、本ページの内容は同班の公式リリースではありません"),
    helpText("詳細な計算方法は下記の論文に記載されています"),
    helpText("https://www.journalofinfection.com/article/S0163-4453(20)30759-3/fulltext"),
    helpText("ソースコード： https://github.com/yukifuruse1217/covid_eventrisk/blob/main/shiny_mass_prob_jp.R"),
    br(),
    br()
    
  ),
  
  
  # Sidebar with a slider input for options
  sidebarPanel(
    h3("パラメーター設定"),
    helpText("下記は初期設定のまま変更しなくても結構です"),
    
    sliderInput("catch", label = h4("実際の感染者のうち、検査によって捉えられ報告されている割合（％）"),
                min = 1, max = 100, value = 20),
    helpText("初期設定 = 20"),
    helpText("この値は、地域の検査状況によって大きく異なる可能性があります"),
    sliderInput("inf", label = h4("感染力のある日数"),
                min = 1, max = 28, value = 10),
    helpText("初期設定 = 10"),
    sliderInput("detect", label = h4("感染から検査までかかる日数"),
                min = 0, max = 28, value = 7),
    helpText("初期設定 = 7"),
    helpText("「発症から」ではありません。参考までに、「感染から発症まで」は一般的に４～５日です"),    
    helpText("この値は、地域の検査状況によって大きく異なる可能性があります"),    
    sliderInput("asym", label = h4("感染しても無症状でおわる割合（％）"),
                min = 0, max = 100, value = 36),
    helpText("初期設定 = 36"),    
    sliderInput("asym_power", label = h4("無症状である感染者が、感染性のある確率（％）"),
                min = 0, max = 100, value = 35),
    helpText("初期設定 = 35"),    
    helpText("上記、「無症状」とは「最後まで無症状であり続ける者」のことで、「現在は症状がないが、後に発症する者」ではありません"),
    sliderInput("presym", label = h4("最終的に症状を呈する感染者が感染を伝播するとして、それが症状の出現前に起こる確率（％）"),
                min = 0, max = 100, value = 50),
    helpText("初期設定 = 50"),    
    br(),        
    h5("パラメーターの設定に用いた参考文献"),
    h5("SARS-CoV-2 seroprevalence and transmission risk factors among high-risk close contacts: a retrospective cohort study (doi: 10.1016/S1473-3099(20)30833-1)"),
    h5("Temporal dynamics in viral shedding and transmissibility of COVID-19 (doi: 10.1038/s41591-020-0869-5)"),
    h5("The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application (doi: 10.7326/M20-0504)"),
    h5("Occurrence and transmission potential of asymptomatic and presymptomatic SARS-CoV-2 infections: A living systematic review and meta-analysis (doi: 10.1371/journal.pmed.1003346)"),
    h5("Inferred duration of infectious period of SARS-CoV-2: rapid scoping review and analysis of available evidence for asymptomatic and symptomatic COVID-19 cases (doi: 10.1136/bmjopen-2020-039856)"),
    h5("Seroprevalence of anti-SARS-CoV-2 IgG antibodies in Geneva, Switzerland (SEROCoV-POP): a population-based study (doi: 10.1016/S0140-6736(20)31304-0)"),
    h5("Estimated SARS-CoV-2 Seroprevalence in the US as of September 2020 (doi: 10.1001/jamainternmed.2020.7976)"),
    h5("The Proportion of SARS-CoV-2 Infections That Are Asymptomatic : A Systematic Review (doi: 10.7326/M20-6976)")
    
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
      
      result2 <- round(nowattend * (1 -eachescape))
      
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