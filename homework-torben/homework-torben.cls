\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework-torben}
\RequirePackage{lastpage} % for \pageref{LastPage}
\RequirePackage{xkeyval} % Key-value package options
\RequirePackage{etoolbox}

%%% ----- Legacy information ---
% Exercise sheets for "Algebraische Strukturen WS24/25" and "Cryptography SS25" need to use "style=obsolete1". Further, the key "no-solutions" used in these sheets is deprecated (but still available) and should be replaced by "solutions=false".

%%% ----- Package options -----

%% no-solutions: Solutions are not printed and altered title
\newbool{solutions}
\booltrue{solutions}
\DeclareOptionX{solutions}[true]{\setbool{solutions}{#1}}
\ExecuteOptionsX{solutions=true} % Default
% Legacy option
\DeclareOption{no-solutions}{
	\boolfalse{solutions}
}
%% Style: classic (no logo) or logo-header (logo and names in header on each page) or obsolete1 (used in WS24, SS25)
\newcommand{\docstyle}{}
\DeclareOptionX{style}{\renewcommand{\docstyle}{#1}}
\ExecuteOptionsX{style=classic}
%% Font for "Submission until"
\newcommand{\timefont}{}
\DeclareOptionX{time-font}{\renewcommand{\timefont}{#1}}
\ExecuteOptionsX{time-font=\itshape}
%% exam: Exam mode
\newbool{exam}
\boolfalse{exam}
\DeclareOption{exam}{
	\booltrue{exam}
}
%% Legay option: solution-doctitle-newline: The string "Solutions" (or similar) in the document title is printed in a new line. Only applies in style "obsolete1"
\newbool{solution-doctitle-newline}
\boolfalse{solution-doctitle-newline}
\DeclareOption{solution-doctitle-newline}{
	\booltrue{solution-doctitle-newline}
}
%% Pass unknown options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
%% Process package options (after all options have been defined)
\ProcessOptions\relax
\ProcessOptionsX\relax

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

%%% ----- Global variables and user commands -----
%% For all document types (exam, homework, solutions)
\newcommand{\unilogovar}{} % Logo of the university
\newcommand{\unilogo}[1]{\renewcommand{\unilogovar}{#1}}
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

%%% ----- Page styles -----
%% Head rule width
\ifdefstring{\docstyle}{logo-header}{
	\renewcommand{\headrulewidth}{0.4pt}
}{
	\renewcommand{\headrulewidth}{0pt}
}
%% Define page styles
\fancypagestyle{logo-header}{
	\fancyhead[L]{\unilogovar}
	\fancyhead[C]{\semestervar}
	\fancyhead[R]{\@author}
}
\fancypagestyle{backside}{
	\fancyfoot{}
	\fancyfoot[C]{\GetTranslation{backside}}
	\fancyfoot[R]{\thepage/\pageref*{LastPage}}
	\renewcommand{\footrulewidth}{0.4pt}
}
\fancypagestyle{pagenum}{
	\fancyfoot{}
	\fancyfoot[C]{\thepage/\pageref*{LastPage}}
	\renewcommand{\footrulewidth}{0pt}
}
%% Set page style
% Footer
\ifbool{solutions}{
	\pagestyle{pagenum} % Solutions of exams or exercise sheets
}{
	\ifbool{exam}{
		\pagestyle{backside} % Exams
	}{
		\pagestyle{empty} % Exercise sheets
	}
}
% Header
\ifdefstring{\docstyle}{logo-header}{
	\pagestyle{logo-header}
}{}
%%% ----- End of page styles -----

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
	\ifdefstring{\docstyle}{obsolete1}{%
		\begin{center}
			\bfseries\LARGE\coursenamevar{}: 
			\ifbool{exam}{
				\examnamevar\solutiontitleaddition
			}{
				\GetTranslation{sheet}~\thesheet\solutiontitleaddition
			}
			
			\addvspace{0.1cm}
			\normalsize\normalfont\@author\qquad\qquad\semestervar
			
			\addvspace{0.1cm}%
			\timefont%
			\ifbool{exam}{
				\GetTranslation{time-limit}: \timelimitvar
			}{
				\GetTranslation{deadline}: \deadlinevar
			}
			
			\vspace{0.5cm}
		\end{center}
		\addvspace{0.5cm}
	}{}%
	\ifdefstring{\docstyle}{classic}{%
		\begin{center}
			\bfseries\LARGE\coursenamevar{}

			% Subtitle "Solutions", if necessary
			\Large --%
			\ifbool{exam}{
				\examnamevar%
			}{
				\GetTranslation{sheet}~\thesheet%
			}%
			\ifbool{solutions}{%
				: \GetTranslation{solution-doctitle}%
			}{} --
			
			\addvspace{0.1cm}
			\normalsize\normalfont\@author\qquad\qquad\semestervar
			
			\addvspace{0.1cm}%
			\timefont%
			\ifbool{exam}{
				\GetTranslation{time-limit}: \timelimitvar
			}{
				\GetTranslation{deadline}: \deadlinevar
			}
			
			\vspace{0.5cm}
		\end{center}
		\addvspace{0.5cm}
	}{}%
	\ifdefstring{\docstyle}{logo-header}{%
		\begin{center}
			% Course title
			\bfseries\LARGE\coursenamevar
			
			% Subtitle "Solutions", if necessary
			\Large --%
			\ifbool{exam}{
				\examnamevar%
			}{
				\GetTranslation{sheet}~\thesheet%
			}%
			\ifbool{solutions}{%
				: \GetTranslation{solution-doctitle}%
			}{} --

			% Time for submission
			\normalfont\normalsize\timefont\ifbool{solutions}{}{
				\ifbool{exam}{
					\GetTranslation{time-limit}: \timelimitvar
				}{
					\GetTranslation{deadline}: \deadlinevar
				}
			}
		\end{center}
	}{}%
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