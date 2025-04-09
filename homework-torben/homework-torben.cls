\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework-torben}
\RequirePackage{etoolbox}

%%% ----- Package options -----

%% no-solutions: Solutions are not printed and altered title
\newbool{solutions}
\booltrue{solutions}
\DeclareOption{no-solutions}{
	\boolfalse{solutions}
}
%% solution-doctitle-newline: The string "Solutions" (or similar) in the document title is printed in a new line
\newbool{solution-doctitle-newline}
\boolfalse{solution-doctitle-newline}
\DeclareOption{solution-doctitle-newline}{
	\booltrue{solution-doctitle-newline}
}
%% exam: Exam mode
\newbool{exam}
\boolfalse{exam}
\DeclareOption{exam}{
	\booltrue{exam}
}
%% Pass unknown options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
%% Process package options (after all options have been defined)
\ProcessOptions\relax

%%% ----- End of package options -----

%%% Based on article class
\LoadClass{article}

%%% Packages
\RequirePackage[left=4cm,right=4cm,top=2cm,bottom=3cm]{geometry}
\RequirePackage{ntheorem,comment,parskip}
\RequirePackage[autostyle=true, german=quotes, english=american]{csquotes}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{babel}
\RequirePackage{fancyhdr}
\RequirePackage{translations}
\RequirePackage{tikz}

%%% Misc
\setlist[enumerate]{label=(\alph*)}

%%% ----- Page styles -----
%% Define page styles for exams
\fancypagestyle{backside}{
	\fancyhead{}
	\fancyfoot[C]{\GetTranslation{backside}}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0.4pt}
}
\fancypagestyle{pagenum}{
	\fancyhead{}
	\fancyfoot[C]{\thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
%% Set page style
\ifbool{solutions}{
	\pagestyle{pagenum} % Solutions of exams or exercise sheets
}{
	\ifbool{exam}{
		\pagestyle{backside} % Exams
	}{
		\pagestyle{empty} % Exercise sheets
	}
}
%%% ----- End of page styles -----

%%% ----- Global variables and user commands -----
%% For all document types (exam, homework, solutions)
\newcommand{\semestervar}{} % Current semester
\newcommand{\semester}[1]{\renewcommand{\semestervar}{#1}}
\newcommand{\coursenamevar}{} % Course name
\newcommand{\coursename}[1]{\renewcommand{\coursenamevar}{#1}}
\ifbool{solutions}{% Title addition for solutions
		\ifbool{solution-doctitle-newline}{
			\newcommand{\solutiontitleaddition}{\newline-- \GetTranslation{solution-doctitle} --}
		}{
			\newcommand{\solutiontitleaddition}{ -- \GetTranslation{solution-doctitle}}
		}
}{%
	\newcommand{\solutiontitleaddition}{}
}
\newcommand*\points[1]{\tikz[baseline=(char.base)]{ % Points
	\node[shape=circle,draw,inner sep=1pt] (char) {#1};}
}
%% Only in homework mode (default)
\newcounter{sheet}
\newcommand{\sheetnumber}[1]{\setcounter{sheet}{#1}} % Sheet number
\newcommand{\deadlinevar}{} % Deadline for submission
\newcommand{\deadline}[1]{\renewcommand{\deadlinevar}{#1}}
%% Only in exam mode
\newcommand{\examnamevar}{} % Name of the exam (e.g. "Abschlussklausur")
\newcommand{\examname}[1]{\renewcommand{\examnamevar}{#1}}
\newcommand{\timelimitvar}{} % Time limit for the exam
\newcommand{\timelimit}[1]{\renewcommand{\timelimitvar}{#1}}
%%% ----- End of global variables and user commands -----


%%% ----- Multilanguage support -----
\DeclareTranslation{English}{exercise}{Exercise}
\DeclareTranslation{German}{exercise}{Aufgabe}
\DeclareTranslation{English}{solution}{Proposed solution}
\DeclareTranslation{German}{solution}{Lösungsvorschlag}
\DeclareTranslation{English}{sheet}{Sheet}
\DeclareTranslation{German}{sheet}{Blatt}
\DeclareTranslation{English}{deadline}{Submission until}
\DeclareTranslation{German}{deadline}{Abgabe bis}
\DeclareTranslation{English}{live-exercises}{Live exercises}
\DeclareTranslation{German}{live-exercises}{Präsenzübungen}
\DeclareTranslation{German}{live-exercises-explanation}{Die folgenden Aufgaben sind dazu gedacht, während der Übungsstunde bearbeitet zu werden, wenn nach der Besprechung der Lösungsvorschläge noch Zeit bleibt. Sie sind ein Zusatzangebot und \emph{nicht} Teil der Abgabe.}
\DeclareTranslation{English}{solution-doctitle}{Solutions}
\DeclareTranslation{German}{solution-doctitle}{Lösungen}
\DeclareTranslation{English}{time-limit}{Time limit}
\DeclareTranslation{German}{time-limit}{Bearbeitungszeit}
\DeclareTranslation{English}{backside}{Note reverse side!}
\DeclareTranslation{German}{backside}{Rückseite beachten!}
%%% ----- End of multilanguage support -----

%%% ----- Title header -----
\renewcommand{\maketitle}{
	\begin{center}
		\bfseries\LARGE\coursenamevar{}: 
		\ifbool{exam}{
			\examnamevar\solutiontitleaddition
		}{
			\GetTranslation{sheet}~\thesheet\solutiontitleaddition
		}
		
		\addvspace{0.1cm}
		\normalsize\normalfont\@author\qquad\qquad\semestervar
		
		\addvspace{0.1cm}
		\ifbool{exam}{
			\GetTranslation{time-limit}: \timelimitvar
		}{
			\GetTranslation{deadline}: \deadlinevar
		}
		
		\vspace{0.5cm}
%		\hrule
	\end{center}
	\addvspace{0.5cm}
}
%%% ----- End of title header -----

%%% ----- Theorem-like environments -----
%% Exercise counter
\ifbool{exam}{ % In homework mode (default), the sheet number is part of the exercise numbering
	\newcounter{ex}
	\renewcommand{\theex}{\arabic{ex}}
}{
	\newcounter{ex}[sheet]
	\renewcommand{\theex}{\thesheet.\arabic{ex}}
}

%% Theorem styles
\newtheoremstyle{exercise}% Exactly like "plain" in ntheorem
{\item[\hskip\labelsep \theorem@headerfont ##1\ ##2\theorem@separator]}%
{\item[\hskip\labelsep \theorem@headerfont ##1\ ##2\ ##3\theorem@separator]}%
\newtheoremstyle{solution}% Like "exercise", but 1. no number and 2. if optional name is given, only the optional name is displayed
{\item[\hskip\labelsep \theorem@headerfont ##1\theorem@separator]}%
{\item[\hskip\labelsep \theorem@headerfont ##3\theorem@separator]}%

%% Exercise and solution environment
\theorembodyfont{\normalfont}
\theoremsymbol{}

\theoremstyle{exercise}
\theoremheaderfont{\normalfont\bfseries}
\theoremseparator{.}
\newtheorem{exercise}[ex]{\protect\GetTranslation{exercise}}

\theoremstyle{solution}
\theoremheaderfont{\normalfont\bfseries\itshape}
\theoremseparator{:}
\newtheorem{solution}{\protect\GetTranslation{solution}}

% Do not print solutions depending on the bool "solutions"
\ifbool{solutions}{}{
	\renewenvironment{solution}{}{}
	\excludecomment{solution}
}
%%% ----- End of theorem-like environments -----

%%% Live exercises

\newcommand{\makeliveexercisestitle}{
	\vspace{0.5cm}
	\begin{samepage}
		\begin{center}
			\bfseries\large\GetTranslation{live-exercises}
		\end{center}
		\GetTranslation{live-exercises-explanation}
	\end{samepage}
}