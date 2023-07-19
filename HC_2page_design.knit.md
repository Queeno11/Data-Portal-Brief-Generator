

---
title: "Australia"
output:
  pdf_document: 
    keep_tex: true
  latex_engine: pdflatex
  fig_caption: yes
  urlcolor: blue
fontsize: 9pt
geometry: "left=1.3cm,right=1.3cm,top=1.5cm,bottom=0.5cm"
header-includes:  \usepackage{fancyhdr} 
  \usepackage{graphicx}
  \usepackage{eurosym}
  \usepackage{datetime}
  \usepackage{booktabs,xcolor} \pagestyle{fancy}  
  \fancypagestyle{plain}{\pagestyle{fancy}}
  \pagenumbering{gobble}
  \renewcommand\thefootnote{\textcolor{black}{\arabic{footnote}}}
  \usepackage{pagecolor}
  \pagecolor{white}
  \usepackage{fourier}
  \usepackage[fontsize=8.7pt]{scrextend}
  \usepackage{float}
  \restylefloat{table}
  \usepackage{xcolor}
  \usepackage{multicol}
  \newcommand{\hideFromPandoc}[1]{#1}
  \hideFromPandoc{
    \let\Begin\begin
    \let\End\end
  }
  \usepackage{caption}
  \captionsetup{skip=0pt}
  \usepackage{hyperref}
  \usepackage{array}
  \usepackage{varwidth}
  \hypersetup{
      colorlinks=true,
      linkcolor=blue,
      filecolor=magenta,      
      urlcolor=cyan,
  }
  \urlstyle{same}
  \usepackage{enumitem}
  \setlist{leftmargin=*}
  \pagenumbering{gobble}
  \usepackage{numprint}
  \usepackage{fbox}
  
params:
  countrynamet: "Afghanistan"   

---
\definecolor{bondiblue}{rgb}{0.0, 0.58, 0.71}
\definecolor{steelblue}{rgb}{0.27, 0.51, 0.71}
\definecolor{brickred}{rgb}{0.8, 0.25, 0.33}
\newcommand\boldblue[1]{\textcolor{bondiblue}{\textbf{#1}}}

This 2-page brief provides the 2020 Human Capital Index (HCI) released in September 2020, and a set of indicators that are complementary to the HCI. The HCI measures the amount of human capital that a child born today can expect to attain by age 18. It conveys the productivity of the next generation of workers compared to a benchmark of complete education and full health. Although the effects of COVID-19 on the HCI are yet to be measured due to the lack of data, we expect the post-pandemic HCI to be relatively lower due to the deep learning and health losses globally. **Data collection efforts to allow updates to the HCI remain critical for all countries to inform policies and programs to address the setbacks to human capital.**

\Begin{multicols}{2}

### \boldblue{T\small{HE HUMAN CAPITAL INDEX}}###

A child born in Australia just before the pandemic will be **77 percent** as productive when she grows up as she could be if she enjoyed complete education and full health. 

This is higher than the average for the East Asia & Pacific region (59 percent) and High Income countries (71 percent). 

### \boldblue{T\small{HE HUMAN CAPITAL INDEX COMPONENTS}}###

* **Probability of Survival to Age 5.** **100** out of 100 children born in Australia survive to age 5.

* **Expected Years of School.** In Australia, a child who starts school at age 4 can expect to complete **13.6 years** of school by her 18th birthday.

* **Harmonized Test Scores.** Students in Australia score **516** on a scale where 625 represents advanced attainment and 300 represents minimum attainment.

* **Learning-adjusted Years of School.** Factoring in what children actually learn, expected years of school is only **11.2 years**.

* **Adult Survival Rate.** Across Australia, **95 percent** of 15-year olds will survive until age 60. This statistic is a proxy for the range of health risks that a child born today would experience as an adult under current conditions.

* **Fraction of Children Under 5 Not Stunted.** **98** out of 100 children are **not** stunted. **2** out of 100 children are at risk of cognitive and physical limitations that can last a lifetime.


### \boldblue{T\small{HE HUMAN CAPITAL UTILIZATION}}###

* **U-HCI** The returns on human capital are realized when individuals predominantly utilize that capital through work. Consequently, we introduce a utilization-adjusted Human Capital Index (UHCI) that accounts for underutilization of human capital in the labor market by taking into account the proportion of the employed working-age population. In Australia, adjusting the HCI for utilization leads to a decrease to 0.57. This suggests that nearly more than half of Australia's population is unable to fully leverage their skills and knowledge to contribute effectively to the economy.

\vspace{-1mm}
\begin{table}[H]
\renewcommand{\tabcolsep}{0.8mm}
\begin{tabular}{m{0.3\textwidth}>{\centering\arraybackslash}m{0.054\textwidth}>{\centering\arraybackslash}m{0.054\textwidth}>{\centering\arraybackslash}m{0.054\textwidth}}
\\\textbf{     }   &    &             &  \\ \hline
                         &      &              & \\
\textbf{ Human Capital and Utilization   } & \textbf{ Boys} & \textbf{ Girls} &  \textbf{ Overall} \\\hline
\vspace{-1mm} \\
Human Capital Index (HCI) &   0.76 &   0.78 &    0.77\\
Utilization of Human Capital Index (UHCI) & 0.59  &  0.54 & 0.57 \\
                         & \multicolumn{1}{l}{} & \multicolumn{1}{l}{} &    
\vspace{-4mm}
\\\hline
\end{tabular}
\vspace{1mm} 
\end{table}


\begin{flushright}\includegraphics[height=0.8\textheight]{Graphs/p1_AUS_all} \end{flushright}

\vfill

\End{multicols}


\newpage

\vspace{3mm} 

Human capital, a crucial ingredient for economic growth, is multi-dimensional and cumulatively built over the lifecycle. Due to the slow moving nature of the HCI, an additional set of Human Capital Complementary Indicators (HCCIs) offer a snapshot of proximate dimensions of human capital in Australia that can be monitored to measure simultaneous progress in intermediate outcomes. These selected HCCIs are based on the latest available data (\emph{italicized} and shown in parenthesis) and benchmarked against regional and country income group averages. **They highlight where the need is for investment in people in each stage of life and for data collection and updates for evidence-based policy making.** *Among the 12 selected indicators with available data for Australia, 1 have shown improvement over the past approximately 5 years, while 1 have experienced a decline.*
<<<
\vspace{1mm}

\Begin{multicols}{2}

### \boldblue{E\small{ARLY CHILDHOOD}}###

* **Neonatal mortality rate (deaths per 1,000 live births).** The neonatal mortality rate is **2 per 1,000 live births** (*2021*). The indicator is both below the regional average (10) and the income group average (3).

* **Participation rate in organized learning (% of children one year before the official primary entry age).** As in (*2019*) ,  **83 percent** of children one year before the official primary entry age participate in an organized learning program.. The indicator is higher than the regional average (82%) but lower than the income group average (91%).

* **Diphtheria vaccination (%).** Diphtheria vaccine coverage is **95 percent** (*2021*). The indicator is both above the regional average (83%) and the income group average (94%).


### \boldblue{S\small{CHOOL AGE}}###

* **Child mortality (deaths per 1,000 youth aged 5).**  The mortality rate at ages 5–14 is **1 per 1,000 children aged 15** (*2021*). The indicator is lower than the regional average (4) and similar to the income group average (1).

* **Schools with basic sanitation services (%).** The share of schools with improved sanitation facilities is **100 percent** (*2021*). The indicator is both above the regional average (75%) and the income group average (98%).

* **Net enrolment rate, lower secondary.** The percentage of school net enrolment at lower secondary is **98** (*2020*). The indicator is higher than the regional average (88%) and similar to the income group average (98%).

### \boldblue{Y\small{OUTH}}###

* **Adolescent fertility (births/1000 women).** The adolescent fertility rate, i.e., the number of births for every 1000 women ages 15-19, is **8** (*2021*). The indicator is lower than the regional average (12) but higher than the income group average (7).

* **Youth unemployment (%).** Unemployment among youth ages 15-24 is **8 percent** (*2023*). The indicator is both below the regional average (12%) and the income group average (15%).

* **Gross tertiary school enrollment (%).** The tertiary school gross enrollment ratio is **114 percent** (*2020*). The indicator is higher than both the regional average (76%) and the income group average (81%).

### \boldblue{A\small{DULTS \& ELDERLY}}###

* **Labor force participation (%).** The labor force participation as percentage of the working population is **66 percent** (*2022*). The indicator is above the regional average (65%) but below the income group average (67%).

* **Life expectancy at birth (years).** Life expectancy at birth is **83 years** (*2021*). The indicator is higher than both the regional average (79 years) and the income group average (82 years).

* **Adult unemployment (%).** Unemployment among adults more than 25 years old is **3 percent** (*2023*). The indicator is similar to the regional average (3%) but below the income group average (4%).



\begin{flushright}\includegraphics[height=0.88\textheight]{Graphs/p2_AUS_stages} \end{flushright}

\End{multicols}
