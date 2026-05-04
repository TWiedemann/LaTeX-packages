% thw-notes.cwl
#include:etoolbox
#include:babel
#include:xcolor
#include:setspace
#include:makeidx
#include:fancyhdr
#include:tikz
#include:pgfornament
#include:titlesec
#include:thw-math
#include:booktabs
#include:ragged2e
#include:csquotes
#include:enumitem
#include:idxlayout
#include:geometry
#include:thw-theorems

\frontpage
\semester{semester}
\logo{logo}
\basedon{text}

\printallthmtocs

\defemph{text}
\defemph*{text}

\printallthmtocs
\allthmtocaddchapter{chapter-name}
\allthmtocaddsection{section-name}
