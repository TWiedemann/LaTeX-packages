% thw-homework.cwl

#include:article
#include:etoolbox
#include:lastpage
#include:geometry
#include:ntheorem
#include:comment
#include:parskip
#include:tikz
#include:babel
#include:csquotes
#include:amsmath
#include:fancyhdr
#include:translations

# Commands to provide document information
\unilogo{logo}
\semester{name}
\coursename{name}
\timelimit{limit}
\sheetnumber{number}
\examname{name}

# Misc
\points{number}

\makeliveexercisestitle

# Theorem-like environments
\begin{exercise}#\env
\begin{exercise}[name]#\env
\end{exercise}
\begin{exercise*}#\en
\begin{exercise*}[name]#\env
\end{exercise*}
\begin{funfact}#\env
\begin{funfact}[name]#\env
\end{funfact}
\begin{claim}#\env
\begin{claim}[name]#\env
\end{claim}
\begin{claim*}#\env
\begin{claim*}[name]#\env
\end{claim*}
\begin{miscenv}[name]#\env
\end{miscenv}
\begin{solution}[name]#\env
\end{solution}
\begin{solution-fragile}[name]#\env
\end{solution-fragile}
\begin{claimproof}#\env
\begin{claimproof}[name]#\env
\end{claimproof}

# Prooflist
\begin{prooflist}#\env
\end{prooflist}
\plimr{left}{right}
\pliml{left}{right}
\pliff{left}{right}
\pliiffthree{left}{center}{right}
\plsubs{left}{right}
\plsups{left}{right}
\plsymb{symbol}
\pltext{text}
\pltextnobreak{text}
