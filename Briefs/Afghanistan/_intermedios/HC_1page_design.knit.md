

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

**Human capital – knowledge, skills, and good health – empowers people to achieve their potential and drives economic growth.** This brief tracks progress by Afghanistan in building and using human capital. The Human Capital Complementary Indicators offer a snapshot of human capital investments at four stages of the lifecycle. The figures show the latest available data, benchmarked against regional averages. The figures also report progress over the previous 5 years.

\vspace{-6mm}

\Begin{multicols}{2} 



\raggedcolumns

\textcolor{white}{--}

\vspace{-5mm}

### \boldblue{E\small{ARLY CHILDHOOD}}###

\vspace{-0.75mm}

* **Children who are developmentally on track.** In 2023, **31%** of children (ages 36-59 months) were developmentally on track in health, learning and psychosocial well-being. The indicator is lower than the regional average.
* **Neonatal mortality rate.** The neonatal mortality rate is **34** per 1,000 live births (2023), compared to 39 in 2018. The indicator is above the regional average.
* **Minimum meal frequency.** The share of children ages 6-23 months who regularly consume an age-appropriate meal is **34%** (2022), compared to 49% in 2015. The indicator is lower than the regional average.

\vspace{-6.5mm}

### \boldblue{S\small{CHOOL AGE}}###

\vspace{-0.75mm}

* **Child mortality rate.**  The mortality rate for children ages 5-14 is **5** per 1,000 children aged 5 (2023), compared to 6 in 2018. The indicator is higher than the regional average.
* **Children engaged in child labor.** The share of children (ages 5-17) who are engaged in economic activities is **11%** (2023). The indicator is above the regional average.
* **Primary school completion rate.** The primary school completion rate is  **86%** (by the official entrance age of the last grade) (2019), compared to 83% in 2016. The indicator is lower than the regional average.

\vspace{-6.5mm}

### \boldblue{Y\small{OUTH}}###

\vspace{-0.75mm}

* **Youth literacy rate.** The share of youth (ages 15-24) who are literate is **63%** (2022), compared to 36% in 2015. The indicator is lower than the regional average.
* **Adolescent fertility rate.** The number of births for every 1,000 women ages 15-19 is **64** (2023), compared to 73 in 2018. The indicator is above the regional average.
* **Youth not in employment, education or training.** In 2023, **56%** of youth (ages 15-24) were not in employment, education or training, compared to 43% in 2018. The indicator is higher than the regional average.

\vspace{-6.5mm}

### \boldblue{A\small{DULTS}}###

\vspace{-0.75mm}

* **Life expectancy at birth.** Life expectancy at birth is **66** years (2023), compared to 62 in 2018. The indicator is lower than the regional average.
* **Adult unemployment rate.** Unemployed adults as a share of the adult labor force (ages 25+) is **12%** (2023), compared to 9% in 2018. The indicator is above the regional average.
* **Adult informal employment rate.** The rate of informal employment among working adults (ages 25+) is **85%** (2021). The indicator is higher than the regional average.


\columnbreak 
\vspace{-10em}

\begin{flushright}\includegraphics[width=1\linewidth,height=0.72\textheight]{p2_AFG_stages} \end{flushright}

\vspace{-5mm}
\small Note: Missing symbols indicate internationally comparable data are not available to generate the corresponding statistic.
<!-- \vspace(0.1mm) -->

\End{multicols}
