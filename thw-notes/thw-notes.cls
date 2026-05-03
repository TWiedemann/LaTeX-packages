%% This is a document class for creating notes in mathematics, such as
%% lecture notes.

% ----- Identification part ----

\ProvidesPackage{thw-notes}
% We use the LaTeX 3 syntax for key/value package options, which was introduced to
% the LaTeX kernel in 2020,
% and possibly also \UseName, which according to the LaTeX Companion 3, page 528,
% was added in 2022.
\NeedsTeXFormat{LaTeX2e}[2022/06/02]

%%% ----- Package options -----

\DeclareKeys{
	%% Options passed on to thw-theorems
	theoremlevel.code = {\PassOptionsToPackage{theoremlevel=#1}{thw-theorems}},
	additional-environments.code = {
		\PassOptionsToPackage{additional-environments=#1}{thw-theorems}
	},
	thmbreak.if = @thwnotes@thmbreak,
	cleveref.if = @thwnotes@cleveref,
	% Base class
	base-class.store = \@thwnotes@baseclass,
	% Mode of class
	mode.store = \@thwnotes@mode,
	% thmtoc settings
	thmtoc.store = \@thwnotes@thmtoc,
}

\DeclareUnknownKeyHandler{
	\PassOptionsToClass{\CurrentOption}{article}
	\PassOptionsToClass{\CurrentOption}{report}
}

\SetKeys{
	thmbreak=false,
	theoremlevel=section,
	cleveref=false,
	thmtoc=thmlemdef,
	base-class=article,
	mode=paper
}

\ProcessKeyOptions

%%% ----- Package loading -----

%% Load base document class and choose thmtoc-head
\RequirePackage{etoolbox} % \ifbool etc.
\ifdefstring{\@thwnotes@baseclass}{article}{
	\PassOptionsToPackage{thmtoc-head=section}{thw-theorems}
	\LoadClass{article}
}{}
\ifdefstring{\@thwnotes@baseclass}{report}{
	\PassOptionsToPackage{thmtoc-head=chapter}{thw-theorems}
	\LoadClass{report}
}{}

%% Packages needed for the document class to work
%% thw-theorems is loaded further below
\PassOptionsToPackage{english,german}{babel}
\RequirePackage{babel}
\RequirePackage{xcolor}
\RequirePackage{setspace} % for \setstretch
\RequirePackage{makeidx} % Indexing
\RequirePackage{fancyhdr} % Headline and footline
\RequirePackage{tikz,pgfornament} % For frontpage
\RequirePackage{titlesec} % Customise section titles

%% Convenience packages: Not necessary for the class to work, but I usually want them
%% to be included.
\RequirePackage{thw-math}
\RequirePackage{booktabs}
\RequirePackage{ragged2e} % \RaggedRight
\RequirePackage[autostyle=true, german=quotes, english=american]{csquotes}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage[unbalanced,totoc]{idxlayout}
\RequirePackage[left=2.5cm,right=2.5cm,top=2.5cm,bottom=3cm]{geometry}


%%% ----- Pass package options to thw-theorems -----

%% Boolean options
\ifbool{@thwnotes@thmbreak}{
	\PassOptionsToPackage{thmbreak=true}{thw-theorems}
}{
	\PassOptionsToPackage{thmbreak=false}{thw-theorems}
}
\ifbool{@thwnotes@cleveref}{
	\PassOptionsToPackage{cleveref=true}{thw-theorems}
}{
	\PassOptionsToPackage{cleveref=false}{thw-theorems}
}

%% thmtoc settings
% thmtoc: Theorems, Lemmas, Definitions
\ifdefstring{\@thwnotes@thmtoc}{thmlemdef}{
	\PassOptionsToPackage{
		thmtoc1={theorem,corollary},
		thmtoc2={lemma,proposition,lemcorollary},
		thmtoc3={definition,notation}
	}{thw-theorems}
	\newcommand{\printallthmtocs}{
		\newpage
		\pdfbookmark{\GetTranslation{Theorem-List}}{thmtoc-thm}
		\printthmtoc[1]{\GetTranslation{Theorem-List}}
		\newpage
		\pdfbookmark{\GetTranslation{Lemma-List}}{thmtoc-lem}
		\printthmtoc[2]{\GetTranslation{Lemma-List}}
		\newpage
		\pdfbookmark{\GetTranslation{Definition-List}}{thmtoc-def}
		\printthmtoc[3]{\GetTranslation{Definition-List}}
	}
	\newcommand{\allthmtocaddchapter}[1]{
		\thmtocaddchapter[1]{#1}
		\thmtocaddchapter[2]{#1}
		\thmtocaddchapter[3]{#1}
	}
	\newcommand{\allthmtocaddsection}[1]{
		\thmtocaddsection[1]{#1}
		\thmtocaddsection[2]{#1}
		\thmtocaddsection[3]{#1}
	}
}{}

% thmtoc: Theorems and Lemmas, Definitions
\ifdefstring{\@thwnotes@thmtoc}{thmdef}{
	\PassOptionsToPackage{
		thmtoc1={theorem,corollary,lemma,proposition,lemcorollary},
		thmtoc2={definition,notation}
	}{thw-theorems}
	\newcommand{\printallthmtocs}{
		\newpage
		\pdfbookmark{\GetTranslation{Theorem-Lemma-List}}{thmtoc-thm}
		\printthmtoc[1]{\GetTranslation{Theorem-Lemma-List}}
		\newpage
		\pdfbookmark{\GetTranslation{Definition-List}}{thmtoc-def}
		\printthmtoc[2]{\GetTranslation{Definition-List}}
	}
	\newcommand{\allthmtocaddchapter}[1]{
		\thmtocaddchapter[1]{#1}
		\thmtocaddchapter[2]{#1}
	}
	\newcommand{\allthmtocaddsection}[1]{
		\thmtocaddsection[1]{#1}
		\thmtocaddsection[2]{#1}
	}
}{}

%% Mode of thw-notes
% boxes mode (uses tcolorboxes)
\ifdefstring{\thwnotes@mode}{boxes}{
	\PassOptionsToPackage{tcb-default}{thw-theorems}
}{}
% In mode "paper", there is nothing to actually do

% Finally, load thw-theorems
\RequirePackage{thw-theorems}

%%% ----- Global settings -----

% No page break right before the beginning of a list
\@beginparpenalty=10000
% Equations may break over pages
\allowdisplaybreaks[1]
% Boldface transfers to math mode
\g@addto@macro\bfseries{\boldmath}
% Slightly increase distance between lines
\setstretch{1.1}
% Enumeration of equations
\numberwithin{equation}{section}
\renewcommand{\theequation}{\thesection.\Alph{equation}}

%%% ----- Frontpage -----

%% Comands storing document information
\newcommand{\@thwnotes@semester}{}
\newcommand{\semester}[1]{\renewcommand{\@thwnotes@semester}{#1}}
\newcommand{\@thwnotes@logo}{}
\newcommand{\logo}[1]{\renewcommand{\@thwnotes@logo}{#1}}
\newcommand{\@thwnotes@basedon}{}
\newcommand{\basedon}[1]{\renewcommand{\@thwnotes@basedon}{#1}}
%% Fonts used on front page
\newcommand{\@thwnotes@front@titlefont}{\fontsize{28}{28}\bfseries}
\newcommand{\@thwnotes@front@semesterfont}{\fontsize{18}{18}}
\newcommand{\@thwnotes@front@datefont}{\fontsize{16}{16}}
\newcommand{\@thwnotes@front@authorfont}{\fontsize{14}{14}}
\newcommand{\@thwnotes@front@basedonfont}{\fontsize{12}{12}\itshape}
% Front page command
\newcommand{\frontpage}{%
	\thispagestyle{empty}%
	% Logo in top-left corner
	\ifdefempty{\@thwnotes@logo}{}{%
		\smash{\@thwnotes@logo}%
	}%

	\vspace*{0.2\textheight}
	\begin{center}
		% Title
		\normalfont\@thwnotes@front@titlefont\selectfont%
		\@title
		
		% Semester
		\ifdefempty{\@thwnotes@semester}{}{%
			\vspace{0.5cm}%
			\normalfont\@thwnotes@front@semesterfont\selectfont%
			\@thwnotes@semester%
		}

		% Date
		\ifdefempty{\@date}{}{%
			\vspace{0.5cm}%
			\normalfont\@thwnotes@front@datefont\selectfont%
			\@date%
		}
		
		% Ornament
		\vspace{0.6cm}
		\begin{tikzpicture}
			\path (0,0) to[ornament=83] (10,0);
		\end{tikzpicture}
		
		\vspace{0.5cm}%
		\ifdefempty{\@thwnotes@basedon}{%
			\normalfont\@thwnotes@front@authorfont\selectfont%
			\@author%
		}{%
			\normalfont\@thwnotes@front@authorfont\selectfont%
			\GetTranslation{WrittenBy} \@author
			
			\vspace{0.3cm}%
			\normalfont\@thwnotes@front@basedonfont\selectfont%
			\GetTranslation{BasedOn} \@thwnotes@basedon
		}
	\end{center}
	\newpage
}

%%% ----- Header and footer -----

\fancypagestyle{normal}{
	\fancyhf{}
	\fancyhead[L]{\normalfont \itshape \rightmark}
	\fancyhead[R]{\thepage}
}
\fancypagestyle{plain}{
	\fancyhead{}
	\fancyhead[L]{}
	\fancyhead[R]{\thepage}
}
\fancypagestyle{plain-foot}{
	\fancyhead{}
	\fancyfoot{}
	\fancyfoot[C]{\thepage}
	
}

\pagestyle{normal}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
\setlength{\headheight}{13.69pt}


%%% ----- titlesec -----

\newcommand{\chapformat}[1]{%
	\parbox[c]{0.75\textwidth}{\filright\bfseries\fontsize{30}{30}\selectfont #1}%
	\parbox[c]{0.25\textwidth}{\filleft\fontsize{100}{0}\bfseries\selectfont\thechapter}%
}
\titleformat{\chapter}[block]{\thispagestyle{empty}\filright\normalfont}
	{}{0pt}{\chapformat}[\vspace{5pt}\hrule height 1.5pt]
\titleformat{name=\chapter,numberless}[block]{\filright\normalfont}{}{0pt}
	{\filright\bfseries\Huge\usefont{T1}{ppl}{b}{n}}
\titlespacing{\chapter}{0pt}{0pt}{25pt}

\titleformat{\section}{\bfseries\sffamily\Large}{\thesection}{5pt}{}{}

\titleformat{\part}[display]
	{\thispagestyle{empty}\centering\usefont{T1}{ppl}{m}{n}\bfseries\LARGE}
	{\partname\ \thepart}{15pt}{\Huge}

%% ----- Indexing commands -----

% \defemph{#1} prints #1 (in \emph and orange) and puts it into the index.
% \defemph*{#1} does not put #1 into the index.
\definecolor{defemph}{named}{orange}
\NewDocumentCommand{\defemph}{s m}{%
	\IfBooleanTF{#1}{%
		% Starred version
		\emph{\color{defemph}#2}%
	}{%
		\emph{\color{defemph}#2}\index{#2}%
	}%
}
