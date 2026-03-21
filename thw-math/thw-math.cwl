% mymath.cwl
#include:amssymb
#include:amsmath
#include:mathtools
#include:array

#include:mathdots

#include:xcolor

#include:tikz
#include:tikz-cd

#include:etoolbox

#include:mathrsfs
#include:dsfont

#include:microtype

# Math operators
\GL
\SL
\Sp
\SO
\SU

\gl
\sl

\sgn
\ggT
\kgV
\lcm
\binmod
\Im
\Re
\charac

\Hom
\End
\Aut
\Sym

\Ker
\ker
\Bild
\Fix
\Stab

\diag
\Inn
\Quot
\Rad
\codim

# Math environments
\begin{smallpmatrix}#\tabular
\end{smallpmatrix}

# MathBB
\IA
\IB
\IC
\ID
\IE
\IF
\IG
\IH
\II
\IK
\IL
\IM
\IN
\IO
\IP
\IQ
\IR
\IS
\IT
\IU
\IV
\IW
\IX
\IY
\IZ
\IL
\IOne

# Calligraphic/scripture
\calA
\calB
\calC
\calD
\calE
\calF
\calG
\calH
\calI
\calJ
\calK
\calL
\calM
\calN
\calO
\calP
\calQ
\calR
\calS
\calT
\calU
\calV
\calW
\calX
\calY
\calZ
\diffC
\scrA
\scrB
\scrC
\scrD
\scrE
\scrF
\scrG
\scrH
\scrI
\scrJ
\scrK
\scrL
\scrM
\scrN
\scrO
\scrP
\scrQ
\scrR
\scrS
\scrT
\scrU
\scrV
\scrW
\scrX
\scrY
\scrZ

# Greek
\vphi
\veps
\eps
\vrho
\emptyset

# Differentials
\del{var}
\diff{var}
\pardiff{func}{var}

# Arrows
\ifftop{top}
\impliedbytop{top}
\impliestop{top}
\rightarrowtop{top}
\injarrow
\surjarrow
\bijarrow

# Definitions
\defl
\defr
\defeql
\defeqr

# Operators
\nin
\tensor
\dirsum
\union
\intersect
\bigunion
\bigintersect
\bigland
\biglor
\bigdirsum
\hash

# Relations
\normsub
\notnormsub
\normsup
\neqnormsub
\ideal
\rideal
\subs
\nsubs
\neqsubs
\sups
\neqsups
\isom
\nisom
\congruent
\equalshat
\equalstop{top}

# Misc
\evaluated{term}{at}
\restrict{term}{rest}
\restrictsize{term}{rest}{size}
\map{name}{def}{ziel}{from}{to}
\mapinj{name}{def}{ziel}{from}{to}
\mapsurj{name}{def}{ziel}{from}{to}
\mapbij{name}{def}{ziel}{from}{to}
\mapdash{name}{def}{ziel}{from}{to}
\mapsquig{name}{def}{ziel}{from}{to}
\id

## Complicated stuff
\smallunderbrace{text}

# mathtools paired delimiters
\Set{content}
\Set[size]{content}
\Set*{content}
\compactSet{content}
\compactSet*{content}
\given
\gen{x}
\gen*{x}
\gen[size]{x}
\abs{x}
\abs*{x}
\abs[size]{x}
\norm{x}
\norm*{x}
\norm[size]{x}
\scp{x}{y}
\scp[size]{x}{y}
\scp*{x}{y}
\lie{x}{y}
\lie*{x}{y}
\lie[size]{x}{y}
\commutator{x}{y}
\commutator[size]{x}{y}
\commutator*{x}{y}
\assoc{x}{y}{z}
\assoc*{x}{y}{z}
\assoc[size]{x}{y}{z}
\floor{x}
\floor*{x}
\floor[size]{x}
\ceil{x}
\ceil[size]{x}
\ceil*{x}
\brackets{content}
\brackets*{content}
\brackets[size]{content}
\sqbrackets{content}
\sqbrackets*{content}
\sqbrackets[size]{content}
\trbrackets{content}
\trbrackets*{content}
\trbrackets[size]{content}
\braces{content}
\braces*{content}
\braces[size]{content}

# Misc
\disjunion
\bigdisjunion

\divides
\ndivides

\cycle{numbers}
\cycle[sep]{numbers}

\mywarning{warning}
\removedisplaybelowskip
\refcustomitem{text}

\quotimplies{statement1}{statement2}
\quotiff{statement1}{statement2}
