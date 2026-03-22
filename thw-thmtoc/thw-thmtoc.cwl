% thmtoc.cwl
#include:titletoc
#include:etoolbox

\thmtocmark{entryname}

# Printing thmtocs
\printthmtocas{sec-cmd}{name}
\printthmtocas{sec-cmd}{name}[short-name]
\printthmtocas[thmtoc]{sec-cmd}{name}
\printthmtocas[thmtoc]{sec-cmd}{name}[short-name]
\printthmtocas*{sec-cmd}{name}
\printthmtocas*{sec-cmd}{name}[short-name]
\printthmtocas*[thmtoc]{sec-cmd}{name}
\printthmtocas*[thmtoc]{sec-cmd}{name}[short-name]

\printthmtoc{name}
\printthmtoc[thmtoc]{name}
\printthmtoc{name}[short-name]
\printthmtoc[thmtoc]{name}[short-name]

# Adding elements to thmtocs

\thmtocaddpart{name}
\thmtocaddpart[thmtoc]{name}

\thmtocaddchapter{name}
\thmtocaddchapter[thmtoc]{name}

\thmtocaddsection{name}
\thmtocaddsection[thmtoc]{name}

\thmtocaddsubsection{name}
\thmtocaddsubsection[thmtoc]{name}

\thmtocaddentry{number}{name}
\thmtocaddentry{number}{name}[style]
\thmtocaddentry[thmtoc]{number}{name}
\thmtocaddentry[thmtoc]{number}{name}[style]

\thmtocnewpage
\thmtocnewpage[thmtoc]

# Lengths (commented out because the user normally does not need them)

#\thmtocleftindent
#\thmtoclabelwidth
#\thmtocleaderwidth
