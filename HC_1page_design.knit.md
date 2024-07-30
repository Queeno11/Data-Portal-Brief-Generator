

---
title: "Afghanistan"
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

\vspace{1em}

**Human capital – knowledge, skills, and good health – empowers people to achieve their potential and drives economic growth.** This brief tracks progress by Afghanistan in building and using human capital. The Human Capital Complementary Indicators (HCCIs) offer a snapshot of human capital investments at four stages of the lifecycle. The figures show the latest available data, benchmarked against regional averages. The figures also report progress over the previous 5 years.

\vspace{0.5mm}

\Begin{multicols}{2} 

\raggedcolumns

### \boldblue{E\small{ARLY CHILDHOOD}}###

\vspace{-3mm}

* **Neonatal mortality rate.** The neonatal mortality rate is **35** per 1,000 live births (2022), compared to 40 in 2017. The indicator is higher than the regional average.
* **Diphtheria vaccination rate, third dose.** In 2023, **60%** of infants received the third dose of the diphtheria vaccine, compared to 67% in 2018. The indicator is below the regional average.
* **Postnatal care for newborns.** In 2018, **19%** of newborns had postnatal contact with health providers during their first two days of life, compared to 9% in 2015. The indicator is lower than the regional average.

\vspace{-7mm}

### \boldblue{S\small{CHOOL AGE}}###

\vspace{-3mm}

* **Children engaged in child labor.** The share of children (ages 5-17) who are engaged in economic activities is **9%** (2020). The indicator is higher than the regional average.
* **Child mortality rate.**  The mortality rate for children ages 5-14 is **10** per 1,000 children aged 5 (2022), compared to 7 in 2017. The indicator is above the regional average.
* **Primary school completion rate.** The proportion of children at the entrance age of the last grade of primary school that are enrolled at that grade (regardless of age) is **86%** (2019), compared to 83% in 2016. The indicator is lower than the regional average.

\vspace{-7mm}

### \boldblue{Y\small{OUTH}}###

\vspace{-3mm}

* **Youth not in employment, education or training.** In 2020, **54%** of youth (ages 15-24) were not in employment, education or training, compared to 43% in 2017. The indicator is higher than the regional average.
* **Adolescent fertility rate.** The number of births for every 1,000 women ages 15-19 is **80** (2022), compared to 90 in 2017. The indicator is above the regional average.
* **Youth literacy rate.** The share of youth (ages 15-24) who are literate is **56%** (2021), compared to 64% in 2015. The indicator is lower than the regional average.

\vspace{-7mm}

### \boldblue{A\small{DULTS \& ELDERLY}}###

\vspace{-3mm}

* **Life expectancy at birth.** Life expectancy at birth is **63** years (2022). This remains unchanged since 2017. The indicator is lower than the regional average.
* **Adult unemployment rate.** Unemployed adults as a share of the adult labor force (ages +25) is **10%** (2020), compared to 7% in 2015. The indicator is above the regional average.
* **High skill employment rate.** In 2020, **15%** of total employed adults were high-skilled (levels 3-4), compared to 16% in 2017. The indicator is higher than the regional average.

\vspace{-7mm}

\columnbreak 


\begin{flushright}\includegraphics[height=0.72\textheight]{p2_AFG_stages} \end{flushright}


\vspace{-5mm}
\small Note: Missing symbols indicate internationally comparable data are not available to generate the corresponding statistic.

<!-- \vspace(0.1mm) -->

\End{multicols}
