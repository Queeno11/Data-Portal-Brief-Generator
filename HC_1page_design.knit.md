

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

**Human capital – knowledge, skills, and good health – empowers people to achieve their potential and drives economic growth.** This brief tracks progress by Honduras in building and using human capital. The Human Capital Complementary Indicators offer a snapshot of human capital investments at four stages of the lifecycle. The figures show the latest available data, benchmarked against regional averages. The figures also report progress over the previous 5 years.

\vspace{-6mm}

\Begin{multicols}{2} 



\raggedcolumns

\textcolor{white}{--}

\vspace{-5mm}

### \boldblue{E\small{ARLY CHILDHOOD}}###

\vspace{-0.75mm}

* **Neonatal mortality rate.** The neonatal mortality rate is **9** per 1,000 live births (2023), compared to 11 in 2018. The indicator is lower than the regional average.
* **Children who are developmentally on track.** In 2019, **75%** of children (ages 36-59 months) were developmentally on track in health, learning and psychosocial well-being. The indicator is below the regional average.
* **DTP vaccination rate, third dose.** In 2023, **73%** of infants received the third dose of the diphtheria, tetanus and pertussis vaccine, compared to 91% in 2018. The indicator is lower than the regional average.

\vspace{-6.5mm}

### \boldblue{S\small{CHOOL AGE}}###

\vspace{-0.75mm}

* **Child mortality rate.**  The mortality rate for children ages 5-14 is **5** per 1,000 children aged 5 (2022). This remains unchanged since 2017. The indicator is higher than the regional average.
* **Learning poverty.** In 2019, **79%** of children could not read and understand a simple text, by age 10. The indicator is above the regional average.
* **Children engaged in child labor.** The share of children (ages 5-17) who are engaged in economic activities is **12%** (2019). The indicator is higher than the regional average.

\vspace{-6.5mm}

### \boldblue{Y\small{OUTH}}###

\vspace{-0.75mm}

* **Adolescent fertility rate.** The number of births for every 1,000 women ages 15-19 is **82** (2023), compared to 86 in 2018. The indicator is higher than the regional average.
* **Youth literacy rate.** The share of youth (ages 15-24) who are literate is **96%** (2019). This remains unchanged since 2015. The indicator is below the regional average.
* **Youth not in employment, education or training.** In 2023, **30%** of youth (ages 15-24) were not in employment, education or training, compared to 27% in 2018. The indicator is higher than the regional average.

\vspace{-6.5mm}

### \boldblue{A\small{DULTS}}###

\vspace{-0.75mm}

* **Life expectancy at birth.** Life expectancy at birth is **73** years (2023), compared to 72 in 2018. The indicator is lower than the regional average.
* **Probability of dying from NCDs.** The probability of dying from non-communicable diseases between the ages of 30 to 70 is **71%** (2019), compared to 69% in 2015. The indicator is below the regional average.
* **Adult unemployment rate.** Unemployed adults as a share of the adult labor force (ages 25+) is **4%** (2023). This remains unchanged since 2018. The indicator is lower than the regional average.


\columnbreak 
\vspace{-10em}

\begin{flushright}\includegraphics[width=44.44in,height=0.72\textheight]{p2_HND_stages} \end{flushright}

\vspace{-5mm}
\small Note: Missing symbols indicate internationally comparable data are not available to generate the corresponding statistic.
<!-- \vspace(0.1mm) -->

\End{multicols}
