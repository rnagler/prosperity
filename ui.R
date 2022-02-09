# ~rnaR/prosperityShiny
# Version 4 2022-02-09
## ui.R ##
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(glue)
#setwd("~/rnaR/wohlstandShinyDashboard")
message(glue("start ui"))

ui <- dashboardPage(
  dashboardHeader(title = "Prosperity", controlbarIcon = shiny::icon("cog")),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Welcome", tabName = "willkommenTab"),
      menuItem("Instructions", tabName = "anleitungTab"),
      menuItem("Simulation", tabName = "simulationTab"),
      menuItem("Inequality", tabName = "ungleichTab"),
      menuItem("Current Year", tabName = "verlaufTab"),
      menuItem("Functionality", tabName = "funktTab"),
      menuItem("Ergodicity", tabName = "ergoTab"),
      menuItem("Parameter", tabName = "parameterTab"),
      menuItem("Imprint", tabName = "impressumTab"),
      br(),br(),"Click orange button",
      br(),"to simulate an other year:",
      actionButton("naechstesJahr", "Next Year",
                   style = "color: #000000; background-color: #ff9900"),
      br(),br(),"Click grey button",
      br(),"to start a new Simulation:",
      actionButton("neuStart", "Restart",
                   style = "color: #000000; background-color: #999999")
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "willkommenTab",
        # Boxes need to be put in a row (or column)
        fluidRow(
          box(
            title = strong("Welcome"),
            width=8,
            h2("Prosperity for everybody? Would be nice, but not without wealth tax!"),
            "But most people don't want a wealth tax. ",
            "Vaccination is is also rejected by some today. ", strong(" The cause? Incorrect information and lack of education!"), 
            br(),"Unlike in the Corona chaos, here you find easily understandable practical facts:",
            tags$ul(
              tags$li("You can see from a practical example that inequality arises automatically,"), 
              tags$li("You're trying out what we could do about it,"), 
              tags$li("You understand the underlying causes and why this is difficult to accept.")
            ),
            "In this simulation you will observe how 1000 people experience a year. They all start with equal wealth. Every week their wealth changes as a result of randomly successful money transactions: they receive interest on their savings, invest in shares or pay back loans. No one uses any dishonest tricks. In contrast to reality, everyone has the same opportunities here. Some are just luckier, some less. But something surprising happens.",
            br(),"You can find out more in three steps, but with increasing effort:", 
            tags$ol(
              tags$li(tags$b("Simple:"),em(" You need only 2 minutes.")," Intuitively, you assume that wealth is distributed fairly. Check your assumptions: On the right you can see a histogram about wealth distribution. It documents how many of the 1000 people are in which asset class after one year. The bar on the far left and the red number above shows how many people are in the poorest class, the bar on the far right shows the number of people who belong to the richest class. Compare the numbers of the poorest with the richest. What do you notice? Did you expect this distribution of wealth? Maybe that was a coincidence?",
                      "Press the gray button ", em("Restart"), " at the bottom of the menu to the left and simulate another year. Has the distribution changed significantly? Would you have expected fairer distributions? You can try as many times as you like."), 
              tags$li(tags$b("Advanced:"),em(" You will use approx. 15 minutes.")," Once you realize that wealth automatically moves unevenly, you might want to try ways to mitigate this trend. One possibility would be redistribution through taxation of high wealth. For more information read the menu page ", em("Instructions,"), " try it yourself in the menu ", em("Simulation,"), " and assess the resulting wealth differences in the menu ", em("Inequality.")), 
              tags$li(tags$b("Professional:"),em(" You will spend about 30 minutes.")," It is difficult for us to understand why inequality arises automatically. Because what we have experienced here speaks against our intuition, against our education to asses our chances by computing ensemble averages, and against traditional economic theories. If this confuses you and you want to learn a little more, check out the menu page", em("Ergodicity"), " closer and experiment with exponential and additive growth with different parameters in the menu ", em("Parameter."))
            ),
            strong("How does it all work?"),
            "If you click at ",strong("the icon with the three white bars at the top left,"), " you close or open the menu to the left.",
            br(), "You can use this menu to quickly switch between the individual pages:",
            tags$ul(
              tags$li(em("Instructions"), " tells you what's really going on here."),
              tags$li(em("Simulation"), " shows you how wealth in a society can change within a year.",
                "   Here you will control the process and try out different strategies."),
              tags$li(em("Inequality"), " shows you statistical measures of the current inequality."),
              tags$li(em("Current Year"), " illustrates how the total assets and the extreme values of the individual wealth develop over the course of the year."),
              tags$li(em("Functionality"), " explains how our simulation works in detail."),
              tags$li(em("Ergodicity"), " describes the implications of the underlying mathematical property."),
              tags$li(em("Parameter"), " here you can change some parameters of this simulation yourself."),
              tags$li(em("Imprint"), " shows you required legal stuff, a nice fitting song and an introductory fairy tale.")
            ),
            "Below the menu you will find 2 buttons:",
            tags$ul(
              tags$li(em("Next Year"), ": If you click on this orange button, the simulation continues for another year with the set parameters."),
              tags$li(em("Restart"), ": With this gray button you start a new simulation run with the set parameters.")
            )
          ),
          box(
            title = "Tip:",
            width = 4,
            "Decide how much time you want to invest, then complete one or more of the three steps 'Simple' - 'Advanced' - 'Professional' on the left. You can't ruin anything - experiment without obligation and make up your own mind!"
          ),
          box(
            title = "Histogram Wealth Distribution",
            width = 4,
            plotOutput("outHistEnd2")
          ),
          box(
            title = "Contact:",
            width = 4,
            "Please contact me immediately with all questions, suggestions, points of criticism and objections.",
            br(),"I'm happy about all reactions - discussion is the only way we can come up with viable solutions.",
            br(),"Rupert Nagler, E-Mail: ",  a(href = "nagler@idi.co.at", "nagler@idi.co.at")
          )
        )),
      tabItem(tabName = "anleitungTab",
              # Boxes need to be put in a row (or column)
              fluidRow(
                box(
                  title = strong("Instructions for Simulation"),
                  width=6,
                  #                  h2("Wohlstand für alle?" ),
                  strong("Prosperity for everybody? We can we achieve this if we tax very large wealth sensibly."),br(),
                  "Wealth automatically accumulates with a few.", 
                  br(),
                  " This is reliably ensured by a largely unnoticed mathematical property",
                  " (see Menu ", em("Ergodicity"), ").",
                  "Without anyone using unfair tricks like bribery, usury or fraud, it just happens naturally. Of course, wealth also leads to more power, which is sometimes abused to amass even more wealth.",
                  " But even putting that aside, we still experience a skewed distribution of wealth.",
                  br(), br(), strong("Please try for yourself whether you can counteract this automatic trend:"), 
                  br(), "Click in the left menu ", em("Simulation."), " You will immediately see the simulation of a year with three histograms. ",
                  br(), "Histograms provide an overview of frequencies and show graphically how many people are in different wealth classes. The bar on the far left shows how many people are in the poorest class, the bar on the far right shows the number of people in the richest class.",
                  br(), "In the histogram on the left you can see from the thick blue bar that at the beginning of the year all assets are identical in one class. The middle histogram shows the wealth distribution at the end of the year without taxes. In the histogram on the right you can see how possible taxation at the end of the year could change the distribution of wealth.",
                  br(), br(), "At the bottom left in the 'Tax Policy' box, you can use two sliders to determine the taxation of wealth yourself.",
                  "Both sliders are preset to 50%. Please experiment with other values:",
                  br(), "If you move the ", strong("turquoise slider"), " to the ", em("right"), " you increase the ", strong("limit above which wealth tax is payable"), ". On the far right at 100%, nobody pays wealth tax.",
                  "If you move this slider to the ", em("left,"), "you lower the limit until finally everyone, even the poorest, pays wealth tax.",
                  br(), "If you move the ", strong("red slider"), " to the ", em("right"), " you increase the ", strong("percentage"), " of the current wealth that is to be paid as wealth tax at the end of the year.",
                  "If you move this slider to the ", em("left,"), "you lower the percentage until finally no wealth tax has to be paid at all.",
                  br(), "If everyone pays 100% wealth tax, everyone starts the next year with equal wealth (full redistribution)."
                ),
                box(
                  title = strong("Instructions for Redistribution"),
                  width=6,
                  "Suppose now that you oppose any redistribution ", em("(according to the slogan: 'Performance must be worthwhile again')"), ". So you want to ", strong("prevent egalitarianism"), ". With enthusiasm you quickly push the turquoise slider all the way up to the",
                  em("right"), ", so that certainly no redistribution through wealth or inheritance tax can take place.",
                  br(), "Beeing satisfied you click on the ", em("orange button 'Next Year'"), " in the left menu and observe how wealth is distributed even more unequally next year. All you have to do is push the turquoise slider all the way to the right.",
                  " and then simulate further years by pressing the orange button again. ",                  
                  br(), br(), "In Menu ", em("Inequality"), " you oberve statistical ", strong("measures of inequality"), " in the distribution of wealth, Gini coefficient und Lorenz curve at the beginning and end of the year, and after any redistribution you have choosen.",
                  br(), br(), "In Menu  ", em("Current Year"), " you observe the weekly ", strong("development of total assets"), " and the course of the minimum and maximum individual wealth as well as the average and median of all wealth. (Median is the wealth that falls right in the middle when sorting wealth by size.)",
                  br(), br(), strong("Do you like this automatic tendency towards inequality?"), " Perhaps you would now like to try out how we could achieve more prosperity for everyone through redistribution?",
                  br(), strong("Then risk it,"), "and set a different tax policy with both sliders and see how the wealth distribution becomes more equitable. In this way you slow down the inequality that automatically arises and distribute the wealth tax levied fairly to everyone through state social benefits.",
                  br(), br(), strong("But: wasn't the resulting inequality just a coincidence?"), " Try it, click the ",
                  em("grey button 'Restart'"), "in the left menu for some new attempts and experiment as long as you please. "
                )
              )),
      tabItem(tabName = "simulationTab",
              fluidRow(title = "Simulation",
                box(
                  title = "Simulation",
                  width = 4,
                  plotOutput("outHistAnf")
                ),
                box(
                  title = "",
                  width = 4,
                  plotOutput("outHistEnd")
                ),
                box(
                  title = "",
                  width = 4,
                  plotOutput("outHistUmv")
                )
              ),
              fluidRow(
                box(
                  title = "Tax Policy",
                  width = 8,
#                  helpText(" in % des größten Vermögens"),
                  # set color of left slider bar
                  setSliderColor(c("#00cccc", "#ff0000"), c(1,2)), #türkis erster, rot zweiter
                  sliderInput(
                    "sliderObergrenze",
                    "Tax limit: From what percentage of the largest actual individual wealth should people pay wealth tax?",
                    0,
                    100,
                    50
                  ),
                  p("Slider on the far left at 0 -> everyone pays tax, slider on the far right at 100 -> no one pays tax."),
#                  helpText("Steuerprozentsatz"),
                  hr(),
                  sliderInput(
                    "sliderSteuerprozent",
                    "Tax percentage: What percentage of their wealth should people whose wealth is above the tax limit have to pay as tax?",
                    0,
                    100,
                    50
                  ),
                  p("Slider on the far left at 0 -> no wealth tax, slider on the far right at 100 -> all wealth is to be deducted")
                ),
                box(
                  title = "Metrics",
                  width = 4,
                  tableOutput("outTabUmvReg")
                )
              )),
      tabItem(tabName = "verlaufTab", 
              fluidRow(
                box(
                  title = "Trajectory Sum of all assets during the current year",
                  width = 6,
                  helpText("The line shows how the sum of wealth of all people develops."),
                  plotOutput("outPlotVerlaufGes")
                ),
                box(
                  title = "Trajectories of Minimum, Average, Median, Maximum during the current year",
                  width = 6,
                  helpText("The lines show how the respective maximum, average, median and minimum of individual wealth develop."),
                  plotOutput("outPlotVerlauf")
                ),
                box(
                  title = "Overall Stats",
                  width = 6,
                  helpText("Values for the current year"),
                  tableOutput("outTabStat")
                ),
                box(
                  title = "End of year Stats",
                  width = 6,
                  helpText("about individual wealth at the end of the current year"),
                  tableOutput("outTabEndStat")
                )
              )),
      tabItem(tabName = "ungleichTab",
              fluidRow(
                box(
                  title = "Inequality at the beginning of the current year",
                  width = 4,
                  helpText("Measures of inequality and Gini coefficient"),
                  tableOutput("outTabUngAnf"),
                  hr(),
                  plotOutput("outPlotLorenzAnf")
                ),
                box(
                  title = "Inequality at the end of the current year",
                  width = 4,
                  helpText("Measures of inequality and Gini coefficient"),
                  tableOutput("outTabUngEnd"),
                  hr(),
                  plotOutput("outPlotLorenzEnd"),
                  helpText("About Gini coefficient und Lorenz Curve see Menu 'Functionality'")
                ),
                box(
                  title = "Inequality after redistribution",
                  width = 4,
                  helpText("Measures of inequality and Gini coefficient"),
                  tableOutput("outTabUngUmv"),
                  hr(),
                  plotOutput("outPlotLorenzUmv")
                )
              )),
tabItem(tabName = "funktTab",
        fluidRow(
          box(
            title = strong("Functionality"),
            width=9,
            #                  h2("Wie funktioniert dieses Modell?" ),
            "At Start or Restart all 1000 persons get the same starting wealth at the beginning of the year. They change it every week through financial transactions.",
            br(), "How is each individual transaction simulated? Our economic life is strongly determined by exponential growth. The following applies to capital-oriented transactions: ",
            br(), code("new wealth = old wealth * multiplicative factor"), ". In reality, the multiplicative factor is an interest gain, rental income or investment gain that the old wealth is multiplied by. In any case, the amount of the new wealth depends heavily on the amount of the old wealth. In this model, we use normally distributed random numbers with a preset mean = 1.03 and standard deviation = 0.2 as the multiplicative factor.",
            br(), "In addition, there is also an additive growth that arises from employment wages, pensions or rent payments by the little people. This growth does not depend on their current amount of wealth. So the following applies here: ",code("new wealth = old wealth + additive factor"), 
            ". In our model, we use normally distributed random numbers with a preset mean = 0.03 and standard deviation = 0.2 as the additive factor.",
            br(), "With these values we set a slightly positive but varying growth. You can adjust these parameters as well as the starting wealth with the corresponding sliders on the menu page ", em("Parameter."), " There you can also decide whether you want to simulate exponential or additive growth or both types of growth in the same time.",
            br(), "With the random numbers parameterized as described, we simulate the change in wealth for each of the 1000 persons for each week of the current year. Logically, each individual wealth at the end of the year will be disparate. That's not surprising, some people just have better luck with their financial decisions. Therefore, we expect people to be in different asset classes by the end of the year.",
            "But we would expect balanced histograms on the menu page ", em("Simulation"), " with approximately equal numbers of people in each wealth classes. Surprisingly, however, we observe a skewed unequal distribution when - as in reality - exponential growth is involved: ",
            strong("Few people have gotten rich and most are in the lowest wealth class."),
            br(), br(), "The menu page ", em("Inequality "), "also makes this clear.",
            "Here you can find analogous to the menu page ", em("Simulation"), " statistical values for inequality at the beginning of the year, at the end of the year and after any redistribution.",
            br(), "The tables show different shares of wealth are owned by different classes of people.",
            br(), "The ", strong("Gini coefficient")," below is a measure of current inequality. At the start or restart of the simulation it is 0, which means: everyone has the same wealth. The Gini coefficient would be 1 at maximum inequality, i.e. when one person owns all of the wealth and everyone else owns nothing. More about the Gini coefficient: ",
            a(href = "https://en.wikipedia.org/wiki/Gini_coefficient", "https://en.wikipedia.org/wiki/Gini_coefficient", target="_blank"),
            br(), "The ", strong("Lorenz Curves"), " show graphically which proportion of people has which proportion of the total assets. You can find out more about the Lorenz curve at:",
            a(href = "https://en.wikipedia.org/wiki/Lorenz_curve", "https://en.wikipedia.org/wiki/Lorenz_curve", target="_blank"),
            ". The more the red Lorenz curve sags to the bottom right, the greater the inequality here.",
            br(),br(), "You can mitigate inequality through higher wealth taxes if you slide the ", em("'turquoise' slider"), " in the menu page ", em("Simulation"), " more to the left and thus lower the asset limit above which tax becomes due.",
            " Or you slide the ", em("'red' slider"), " more to the right to increase the tax percentage.",
            br(), "By default, the wealth from which tax is due is set to 50% of the largest individual wealth and the tax rate to 50%.",
            br(), "The wealth tax charged at the end of the year is distributed (in the form of state social benefits) fairly among all people, including the rich.",
            br(), "If you click the orange button ", em("Next Year"), " all assets are transferred from the end of the year after any redistribution to the beginning of another year and this additional year is simulated and displayed as above with new random numbers.",
            br(), "So you can simulate the course of several years - whether with high, low or no wealth taxes - and assess the amount and distribution of wealth. ",
            br(), "On the menu page ", em("Current Year"), " you can see the development of the total wealth of all people in this year and what effects redistribution can have."
          ),
          box(
            title = "Questions",
            width = 3,
            br(), strong("Why do end-of-year figures indicate greater inequality?"),
            br(), br(), strong("How do you like the difference with / without redistribution?"), " Redistribution has scary names: wealth tax, inheritance tax. But don't worry, if you use it correctly, nobody loses in the medium term, not even the rich. Cooperative redistribution creates wealth for all.",
            br(), br(), strong("Have you tried out what happens to the total wealth as redistribution increases?"), 
            br(), " It is likely that the poor will benefit.",
            br(), strong("But how are the rich faring?"), "Have their chances diminished greatly?"
          )
        )),
tabItem(tabName = "ergoTab",
        fluidRow(
          box(
            title = strong("Ergodicity"),
            width=6,
#            h3("" ),
            "Traditional economics does not distinguish between ", strong("additive"), " and ", strong("exponential"), " growth. So equal opportunity for all is suggested by falsely postulating ", strong("Ergodicity:"),
            "the average of an individual's wealth over time should be equal to the average of all persons' wealth at a given point in time. That's what they call the ",
            a(href = "https://en.wikipedia.org/wiki/Ergodic_hypothesis", "ergodic hypothesis.", target="_blank"),
            br(), "This hypothesis states, simplified in thermodynamics, that a system can actually reach all energetically possible states.",
            "The phase transitions observed in reality provide counterexamples there: when a liquid solidifies, the ergodic hypothesis does ", strong("not"), " apply. This hypothesis can therefore no longer be accepted there without restrictions.",
            br(), "The present simulation model provides a practical ", strong("counter example"), " to the ergodic hypothesis in economics and thus proves it wrong. You will find that the ergodic hypothesis does NOT apply to ", strong("exponential"), " growth processes.",
            br(), br(), "Exponential growth processes always arise when the extent of the financial success or failure of a transaction depends on the capital employed (", em("interest income, dividends, rental income, investment profits,"), " etc.).",
            br(), "In contrast, with ", strong("additive"), " growth processes (changes in assets through ", em("pure employment wages, pension income, but also expenses for daily needs, rent payments of the little people,"), " or similar.) ergodicity can certainly be accepted. Purely additive growth processes lead to just normally distributed wealth, as we would intuitively assume.",
            "Exponential growth processes, however, lead to skewed wealth distribution - contrary to our emotional assessment.",
            br(), br(), "You can easily illustrate this in menu page ", em("Parameter"), " by selecting at ", em("Growth Type: 'Purely additive'"), " and then clicking at ", em("'Restart'"), " and look at the histogram in menu page 'Simulation' at the end of the current year. ",
            "Then you select the growth type ", em("'purely exponential'"), ", click ", em("'Restart'"), " and assess the differences in the histogram.",
            br(), br(), strong("In the case of exponential growth processes, the assumption of ergodicity inevitably leads to wrong conclusions."),
            br(), "The average value of the wealth of all people at a certain point in time provides ", strong("no meaningful predictions"), " about the possible wealth of a single person. Extreme wealth of few people drives the average wealth into heights which are not suitable for individual predictions.",
            br(), "Therefore, ergodicity must not be postulated in general in economics either. ",
            br(), "However, traditional liberal economics equates - intentionally or unintentionally - the ", strong("additive"), " changes in the wealth of the little people with the ", strong("exponential"), " changes in the wealth of a capitalist.",
            br(), "Mainstream economics has misled us again and again, and caused constant ", strong("wrong decisions of many politicians"), ".",
            br(), "An increasing gross national product of a state does not mean increasing wealth for all its citizens.",
            br(), "The sentence 'If the economy is doing well, everyone is doing well' is a ", strong("grossly misleading conclusion.")
          ),
          box(
            title = "Sources:",
            width = 6,
            #     br(), strong("Sources:"),
            "Wealth Inequality and the Ergodic Hypothesis, Yonatan Berman, Ole Peters, Alexander Adamou, 2020",
            br(), a(href = "https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2794830", "https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2794830", target="_blank"),
            br(), br(), "Capital and Ideology, Thomas Piketty, 2020",
            br(), a(href = "http://piketty.pse.ens.fr/fr/Piketty2020HUPExtracts.pdf", "http://piketty.pse.ens.fr/fr/Piketty2020HUPExtracts.pdf", target="_blank"),
            br(), br(), "Ergodicity Economics, Ole Peters, Alex Adamou, 2018",
            br(), a(href = "https://ergodicityeconomics.files.wordpress.com/2018/06/ergodicity_economics.pdf", "https://ergodicityeconomics.files.wordpress.com/2018/06/ergodicity_economics.pdf", target="_blank"),
            br(), br(), "Democratic domestic product, Ole Peters, 2020",
            br(), a(href = "https://ergodicityeconomics.com/2020/02/26/democratic-domestic-product/", "https://ergodicityeconomics.com/2020/02/26/democratic-domestic-product/", target="_blank"),
            br(), br(), "What is ergodicity?, Lars P. Syll, 2016",
            br(), a(href = "https://larspsyll.wordpress.com/2016/11/23/what-is-ergodicity-2/", "https://larspsyll.wordpress.com/2016/11/23/what-is-ergodicity-2/", target="_blank"),
            br(), br(), "Ergodicity, Wikipedia, 2022",
            br(), a(href = "https://en.wikipedia.org/wiki/Ergodicity", "https://en.wikipedia.org/wiki/Ergodicity", target="_blank"),
            br(), br(), "The Triumph of Injustice, Tax policy simulator, Gabriel Zucman, 2019",
            br(), a(href = "https://taxjusticenow.org/", "https://taxjusticenow.org/", target="_blank"),
            br(), br(), "Vermögenssteuer: Warum es nicht gelingt, höhere Steuern für Reiche durchzusetzen, Momentum, Dez.2021 (in German)",
            br(), a(href = "https://www.moment.at/story/vermoegenssteuer-reiche-scheitern", "https://www.moment.at/story/vermoegenssteuer-reiche-scheitern", target="_blank"),
            br(), br(), "Vorteile von Vermögensteuern spielerisch erklärt, Rupert Nagler, 2020 (in German)",
            br(), a(href = "https://drive.google.com/file/d/1f1J-EhkkB49vkey1L_F3ICk0EwYErmzn/view?usp=sharing", "https://drive.google.com/file/d/1f1J-EhkkB49vkey1L_F3ICk0EwYErmzn/view?usp=sharing", target="_blank")
          )
        )),
tabItem(tabName = "parameterTab",
              fluidRow(
                box(
                  h4("Exponential growth random number generator"),
                  title = "Parameter",
                  width = 6,
                  helpText("Multiplicative transactions lead to an exponential increase or decrease in individual wealth. This is simulated by normally distributed random numbers."),
                  helpText("These sliders control the generation of the multiplicative random numbers."),
                  hr(),
                  helpText("Mean > 1 produces a positive trend."),
                  sliderInput("sliderMittelwert", "Mean of multiplicative random numbers:", 0.9, 1.2, 1.02),
                  hr(),
                  helpText("A larger standard deviation causes more scatter, 0 prevents any scatter."),
                  sliderInput("sliderStandardabweichung", "Standard deviation of multiplicative random numbers:", 0, 0.6, 0.2)
                ),
                box(
                  h4("Additive growth random number generator"),
                  title = "Parameter",
                  width = 6,
                  helpText("Additive transactions lead to an additive increase or decrease in the individual wealth. This is simulated by normally distributed random numbers."),
                  helpText("These sliders control the generation of additive random numbers."),
                  hr(),
                  helpText("Mean > 0 produces a positive trend."),
                  sliderInput("sliderAddMittelwert", "Mean of the additive random numbers:", -0.9, 0.9, 0.03),
                  hr(),
                  helpText("A larger standard deviation causes more scatter, 0 prevents any scatter."),
                  sliderInput("sliderAddStandardabweichung", "Standard deviation of additive random numbers:", 0, 0.6, 0.2)
                ),
                box(
                  title = "Type of Growth",
                  width = 6,
                  helpText("Please select the desired growth type by clicking on it."),
                  radioButtons("rBwachstum", "Growth Type:",
                   c("purely exponential growth" = "mult",
                     "purely additive growth" = "add",
                     "both growth types" = "addMult"),
                   selected = "mult")
                ),
                box(
                  title = "Leverage",
                  width = 6,
                  helpText(
                    "This slider controls what percentage of his wealth a person uses in all transactions. Default set to 100%. Above 100% means additional borrowing. Below 0% means Short, playing the role of the bank."
                  ),
                  sliderInput("sliderLeverage", "Leverage:", -100, 200, 100)
               ),
              box(
                title = "Start Wealth",
                width = 6,
                helpText(
                  "This slider controls the same initial wealth allocated to each person at restart. Default set to 1$."
                ),
                sliderInput("sliderStartVermoeg", "Startvermögen:", 0.1, 100, 1)
              )
              )),
tabItem(tabName = "impressumTab",
        fluidRow(
          box(
            title = "Imprint:",
            width = 4,
            "This website is provided by:",
            br(), "Information Design Institute, 120 Hoetzendorfstrasse,",
            "A-2231 Strasshof, Austria / Europe,",
            br(), "Tel.: +43 650 2287 001, nagler@idi.co.at,",
            a(href = "https://www.idi.co.at/", "https://www.idi.co.at/", target="_blank"),
            br(), br(), "Managing director and responsible for content: Dipl.-Ing. Dr. Rupert Nagler, Dr. Nagler KG,",
            br(), "Line of Business: Consulting, Register number: 174660 d, UID: ATU45617202",
            br(), br(), "This website may contain links to other sites. We are not responsible for linked content.",
            br(), br(), "Developed in Rstudio V4.0+ with library 'shinydashboard'.",
            br(), "Open Sourcecode public available at:",
            a(href = "https://github.com/rnagler/prosperity/", "https://github.com/rnagler/prosperity/", target="_blank"),
            hr(),
            br(), h4("Nice Song, appropriate to the topic:"),
            "Everybody Knows, Leonard Cohen, 1988 (to play while viewing this website)",
            br(), a(href = "https://www.youtube.com/watch?v=Lin-a2lTelg", "https://www.youtube.com/watch?v=Lin-a2lTelg", target="_blank"),
            br(), br(), "Everybody knows that the dice are loaded",
            br(), "    Everybody rolls with their fingers crossed",
            br(), "    Everybody knows the war is over",
            br(), "    Everybody knows the good guys lost",
            br(), "    Everybody knows the fight was fixed",
            br(), "    The poor stay poor, the rich get rich",
            br(), "    That's how it goes",
            br(), "    Everybody knows..."
          ),
          box(
            title = "Fairy Tale: Island of the Blessed, an easy Introduction into Redistribution",
            width = 8,
            "Once upon a time a stranger sails through unknown dangerous seas. His boat capsizes in a terrible storm. But he is lucky and is washed up on the beach of the Island of the Blessed, completely exhausted.",
            br(), "On this beautiful island 1000 islanders live in perfect peace. Everyone is remarkably happy and content. Extremely helpful, they take the stranded with them. When he regaines his strength, they tell him their story:",
            br(), "They all have the same wealth and put their money to work. They invest it in the beautiful landscape, grow wonderful fruits on fertile soil and breed strong animals that they sell to their fellows. ",
            "Some put their money in savings accounts with great interest rates. On this island of the blessed, no one wants to take advantage of the other or even cheat.",
            br(), "But no matter how fair and honest they are to each other, it happens again and again that very few of them become much richer and most of them have nothing left. However, they have found a simple solution to this inexplicable process:",
            br(), "At the end of a year, they throw a large part of all wealth into one heap and distribute it again fairly to everyone. They call it 'redistribution'. The stranded man wonders about this unusual custom and asks how they came up with this strange idea.",
            br(), "They explain that in ancient times a prophet landed with them and recommended this procedure as enormously important for their inner peace. The stranded man dimly remembers that he had learned something similar at school: in many ancient cultures it was customary to regularly compensate for inequalities that had arisen, names such as 'symposium' or 'jubilee' appear in his memory.",
            br(), "And indeed, our stranded man experiences the peace, calm, and poise of the islanders as evidence of the powerful effectiveness of this strange redistribution. He thinks: 'It's really like being on an Island of the Blessed here, very different from my home country, where greed, hectic and resentment rule.'",
            "If he were ever lucky enough to return to his homeland, he would definitely recommend a similar course of action to his officials.",
            br(), "After a few happy years, which he was allowed to spend on the island of the blessed, one day a silver boat appeared on the horizon, which finally took him on board and, after a long journey, brought him back to his home country.",
            br(), "On the one hand he is happy to be home again, on the other hand he is appalled at how the situation in his country has deteriorated: Many people are completely impoverished, including his brothers, sisters and friends. He also wonders about high walls with many guards in places, with which a few rich want to protect themselves out of fear of the poor, and the many heavily armed police officers who fearfully have to keep the wailing poor from acts of desperation.",
            br(), "So he seeks an audience with his officials. When he is finally admitted, he tells them about his experiences on the Island of the Blessed and proposes this regular redistribution to regain inner peace. But then the representatives of the people burst out laughing in despair. They say that such a thing is completely impossible with them. The people they represent admire the rich and adore them particularly intensely. Many poor people, in their delusion, believe that wealth was sacrosanct.",
            "You can't take anything away from anyone. So much do the poor desire to be like the rich that they reject any redistribution as unthinkable and even sinful.",
            br(), "More and more people are falling into abject poverty. Some of these unfortunates attempt by force to snatch property from others. Unfortunately, most of them are poor like themselves, since the rich are out of reach for them in their secure castles behind the high walls. But the rich are getting greedier. They try to accumulate even more wealth through dishonest machinations. ",
            "They demand higher and higher rents and interest from the poor, pay lower and lower wages, threaten some officials to gain even more advantages. Mighty rich even bribe legislators into passing these laws, allowing them to further exploit the poor.",
            br(), "The rich are increasingly succeeding in presenting wealth as sacred and inequality as natural and willed by God. That is why no representative of the people dares to courageously take suitable measures against the ever increasing inequality.",
            "That's why you shouldn't take anything away from anyone. So much do the poor desire to be like the rich that they reject any redistribution as unthinkable and even sinful.",
            br(), "And so it finally comes to a terrible civil war in which all the rich and many poor lose their lives. And if the few survivors haven't already died, then they're still alive today - but only with regular redistribution, like on the Island of the Blessed."
          )
        ))

    )
  ),
footer = dashboardFooter(left = "Rupert Nagler",
                         right = "(c) Information Design Institute, 2022")
)
# message(glue("end ui")) wenn das activ, dann wird ui nicht gefunden
