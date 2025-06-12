

---
title: "¨"
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
  \renewcommand{\headrulewidth}{0pt}
  
params:
  countrynamet: "Afghanistan"
  extra: ""

---
\definecolor{bondiblue}{rgb}{0.0, 0.58, 0.71}
\definecolor{steelblue}{rgb}{0.27, 0.51, 0.71}
\definecolor{brickred}{rgb}{0.8, 0.25, 0.33}
\newcommand\boldblue[1]{\textcolor{bondiblue}{\textbf{#1}}}

\vspace{0.5em}

**Human capital – knowledge, skills, and good health – empowers people to achieve their potential and drives economic growth.** This brief tracks progress by Monaco in building and using human capital. The Human Capital Complementary Indicators offer a snapshot of human capital investments at four stages of the lifecycle. The figures show the latest available data, benchmarked against regional averages. The figures also report progress over the previous 5 years.

\vspace{-6mm}

\Begin{multicols}{2} 



\raggedcolumns

\textcolor{white}{--}

\vspace{-5mm}

### \boldblue{E\small{ARLY CHILDHOOD}}###

\vspace{-0.75mm}

* **Neonatal mortality rate.** The neonatal mortality rate is **2** per 1,000 live births (2023). This remains unchanged since 2018. The indicator is lower than the regional average.
* **DTP vaccination rate, third dose.** In 2023, **99%** of infants received the third dose of the diphtheria, tetanus and pertussis vaccine. This remains unchanged since 2018. The indicator is above the regional average.
* **Prevalence of anemia in children.** In 2019, **14%** of children ages 6–59 months had anemia, compared to 13% in 2015. The indicator is lower than the regional average.

\vspace{-6.5mm}

### \boldblue{S\small{CHOOL AGE}}###

\vspace{-0.75mm}

* **Child mortality rate.**  The mortality rate for children ages 5-14 is **1** per 1,000 children aged 5 (2022). This remains unchanged since 2017. The indicator is similar to the regional average.
* **Repetition rate in primary education.** In 2018, **1%** of students in primary school remained in the same grade in the following school year. The indicator is similar to the regional average.
* **Over-age lower secondary students.** The percentage of lower secondary school students who are older than the typical age for their respective school level is **0%** (2023), compared to 1% in 2018. The indicator is lower than the regional average.

\vspace{-6.5mm}

### \boldblue{Y\small{OUTH}}###

\vspace{-0.75mm}

* **Adolescent fertility rate.** The number of births for every 1,000 women ages 15-19 is **10** (2023), compared to 11 in 2018. The indicator is lower than the regional average.
* **Youth mortality rate.**  The mortality rate of youth ages 15–24 is **3** per 1,000 youth aged 15 (2022), compared to 4 in 2017. The indicator is below the regional average.
* **Qualified teachers in secondary education.** The share of secondary school teachers who are qualified is **71%** (2023), compared to 77% in 2019. The indicator is lower than the regional average.

\vspace{-6.5mm}

### \boldblue{A\small{DULTS}}###

\vspace{-0.75mm}

* **Life expectancy at birth.** Life expectancy at birth is **86** years (2023). This remains unchanged since 2018. The indicator is higher than the regional average.
* **Adult unemployment rate.** Internationally comparable data on this indicator is not available for Monaco. The regional average for this indicator is 5%.
* **Adult unemployment rate.** Internationally comparable data on this indicator is not available for Monaco. The regional average for this indicator is 5%.


\columnbreak 
\vspace{-10em}

\begin{flushright}\includegraphics[width=1\linewidth,height=0.72\textheight]{p2_MCO_stages} \end{flushright}

\vspace{-5mm}
\small Note: Missing symbols indicate internationally comparable data are not available to generate the corresponding statistic.
<!-- \vspace(0.1mm) -->

\End{multicols}
