

---
title: "Zimbabwe"
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
  \usepackage[fontsize=9.1pt]{scrextend}
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
  \renewcommand{\tightlist}{\setlength{\itemsep}{1ex}\setlength{\parskip}{0pt}}
  
params:
  countrynamet: "Afghanistan"
  extra: ""

---
\definecolor{bondiblue}{rgb}{0.0, 0.58, 0.71}
\definecolor{steelblue}{rgb}{0.27, 0.51, 0.71}
\definecolor{brickred}{rgb}{0.8, 0.25, 0.33}
\newcommand\boldblue[1]{\textcolor{bondiblue}{\textbf{#1}}}

\vspace{2.3em}

**Human capital – knowledge, skills, and good health – empowers people to achieve their potential and drives economic growth. This brief tracks progress by Zimbabwe in building and using human capital.** This page presents the Human Capital Index (HCI), its components parts, and relevant country benchmarks. The HCI quantifies how underinvestment in education and health for today’s children reduces future incomes. Data are most recently available as for 2020. Next page presents a set of Human Capital Complementary Indicators (HCCI) that show progress at each stage of the lifecycle.


\vspace{0.5em}

\Begin{multicols}{2}

\vspace{-2mm}
### \boldblue{T\small{HE HUMAN CAPITAL INDEX}}###
\vspace{-2mm}

A child born in Zimbabwe just before the pandemic will be **47%** as productive when she grows up as she could be if she enjoyed complete education and full health. 

This is similar to the average for the Sub-Saharan Africa region (40%) and Lower Middle Income countries (48%). 

\vspace{-2mm}
### \boldblue{T\small{HE HUMAN CAPITAL INDEX COMPONENTS}}###
\vspace{-2mm}

* **Probability of Survival to Age 5.** Of every 100 children born in Zimbabwe, **95** survive to age 5.

* **Expected Years of School.** In Zimbabwe, a child who starts school at age 4 can expect to complete **11.1** years of school by her 18th birthday.

* **Average Harmonized Test Scores.** Students in Zimbabwe score **396** on a scale where 625 represents advanced attainment and 300 represents minimum attainment.

* **Learning-Adjusted Years of School.** Factoring in what children actually learn, expected years of school is only **7** years.

* **Survival Rate, ages 15-60.** Across Zimbabwe, the proportion of 15-year-olds that will survive until age 60 is **65**. This statistic is a proxy for the range of health risks that a child born today would experience as an adult under current conditions.

* **Fraction of Children Under 5 Not Stunted.** Approximately **77** out of 100 children are not stunted. This means that **23** out of 100 children are at risk of cognitive and physical limitations that can last a lifetime.

\vspace{-6mm}
### \boldblue{U\small{TILIZATION-ADJUSTED HUMAN CAPITAL INDEX}}###
\vspace{-2mm}

The data on the utilization-adjusted human capital index are not available for Zimbabwe. The regional average for this indicator is **0.23** and the income group average is **0.25**.


\vspace{-7mm}
\begin{table}[H]
\renewcommand{\tabcolsep}{0.8mm}
\begin{tabular}{m{0.29\textwidth}>{\centering\arraybackslash}m{0.054\textwidth}>{\centering\arraybackslash}m{0.054\textwidth}>{\centering\arraybackslash}m{0.054\textwidth}}
\\\textbf{     }   &    &             &  \\ \hline
                         &      &              & \\
\textbf{ Human Capital and Utilization   } & \textbf{Boys} & \textbf{Girls} &  \textbf{Overall} \\\hline
\vspace{-1mm} \\
Human Capital Index (HCI) &   - &   - &    0.47 \\
Utilization-Adjusted HCI & -  &  - & - \\
                         & \multicolumn{1}{l}{} & \multicolumn{1}{l}{} &    
\vspace{-4mm}
\\\hline
\end{tabular}
\vspace{1mm} 
\end{table}


\begin{flushright}\includegraphics[height=0.82\textheight]{Graphs/p1_ZWE_all} \end{flushright}

\vfill

\End{multicols}


\newpage
 
$$\\[-3em]$$

**The Human Capital Complementary Indicators (HCCIs) offer a snapshot of human capital investments at four stages of the lifecycle.** The figures show the latest available data, benchmarked against regional averages. The figures also report country progress over the last 5 years.

\vspace{1mm}

\Begin{multicols}{2}

### \boldblue{E\small{ARLY CHILDHOOD}}###

* **Neonatal mortality rate (per 1,000 live births).** The neonatal mortality rate is **25** per 1,000 live births (2021), compared to 27 in 2016. The indicator is higher than the regional average (24).
* **Children who are developmentally on track (%).** In 2019, **71%** of children 24-59 months are developmentally on track in health, learning and psychosocial well-being. The indicator is above the regional average (59%).
* **Minimum meal frequency (%).** Adequate meal frequency among children 0-23 months is **68%** (2019), compared to 59% in 2014. The indicator is higher than the regional average (44%).

### \boldblue{S\small{CHOOL AGE}}###

* **Children engaged in child labor (%).** The share of children aged 5-17 years who are engaged in economic activities is **26%** (2019). The indicator is higher than the regional average (17%).
* **Child mortality rate (per 1,000 children aged 5).**  The mortality rate for children at ages 5-14 is **11** per 1,000 children aged 5 (2021), compared to 13 in 2016. The indicator is below the regional average (13).
* **Net school enrollment rate, lower secondary.** The percentage of secondary school-aged children enrolled at that level is **78%** (2021), compared to 85% in 2016. The indicator is higher than the regional average (70%).

### \boldblue{Y\small{OUTH}}###

* **Youth literacy rate (%).** The literacy rate for youth ages 15-24 years is **91%** (2021), compared to 90% in 2014. The indicator is higher than the regional average (79%).
* **Youth not in employment, education or training (%).** In 2021, **30%** of the youth ages 15-24 are not in employment, education or training, compared to 17% in 2014. The indicator is below the regional average (31%).
* **Youth mortality rate (per 1,000 youth aged 15).**  The mortality rate at ages 15–24 is **24** per 1,000 youth aged 15 (2021), compared to 26 in 2016. The indicator is higher than the regional average (21).

### \boldblue{A\small{DULTS \& ELDERLY}}###

* **Female labor force participation rate (%).** The female labor force participation rate (ages 25+) as a percentage of the working population is **66%** (2023). This remains unchanged since 2018. The indicator is higher than the regional average (60%).
* **Adult unemployment rate (%).** The unemployment rate among adults older than 25 years old is **6%** (2023), compared to 5% in 2018. The indicator is below the regional average (7%).
* **Health care facilities with basic sanitation services (%).** The share of health care facilities with improved sanitation facilities is **17%** (2021). This remains unchanged since 2016. The indicator is higher than the regional average (15%).



\begin{flushright}\includegraphics[height=0.82\textheight]{Graphs/p2_ZWE_stages} \end{flushright}

\End{multicols}
