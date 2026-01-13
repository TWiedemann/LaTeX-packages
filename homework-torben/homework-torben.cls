\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework-torben}
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

%% cleveref: This option should be given if cleveref is used. It ensures that crefnames are defined
\DeclareOptionX{cleveref}[true]{\AddToHook{begindocument}{
	\crefname{exercise}{\GetTranslation{exercise}}{\GetTranslation{exercise-plural}}
	\crefname{solution}{\GetTranslation{solution}}{\GetTranslation{solution-plural}}
	\crefname{claim}{\GetTranslation{claim}}{\GetTranslation{claim-plural}}
}}
%% Style: classic (no logo) or logo-header (logo and names in header on each page) or obsolete1 (used in WS24, SS25)
\newcommand{\docstyle}{}
\DeclareOptionX{style}{\renewcommand{\docstyle}{#1}}
\ExecuteOptionsX{style=classic}
%% Font for "Submission until"
\newcommand{\timefont}{}
\DeclareOptionX{time-font}{\renewcommand{\timefont}{#1}} % TODO: time-font=\bfseries (or any other command) does not work when loading the class
\ExecuteOptionsX{time-font=\itshape}
%% exam: Exam mode
\newbool{exam}
\boolfalse{exam}
\DeclareOption{exam}{
	\booltrue{exam}
}
%% Legacy option: solution-doctitle-newline: The string "Solutions" (or similar) in the document title is printed in a new line. Only applies in style "obsolete1"
\newbool{solution-doctitle-newline}
\boolfalse{solution-doctitle-newline}
\DeclareOption{solution-doctitle-newline}{
	\booltrue{solution-doctitle-newline}
}
%% Pass unknown options to article class
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}
%% Process package options (after all options have been defined)
\ProcessOptions\relax
\ProcessOptionsX\relax

%%% ----- End of package options -----

%%% Based on article class
\LoadClass{article}

%%% Packages
\RequirePackage{lastpage} % for \pageref{LastPage}
\RequirePackage[left=4cm,right=4cm,top=2cm,bottom=3cm]{geometry}
\RequirePackage[thmmarks]{ntheorem}
\RequirePackage{comment,parskip}
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
	\setlength{\headheight}{52.55pt}
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
\DeclareTranslation{English}{exercise-plural}{Exercises}
\DeclareTranslation{German}{exercise-plural}{Aufgaben}
\DeclareTranslation{English}{solution}{Proposed solution}
\DeclareTranslation{German}{solution}{Lösungsvorschlag}
\DeclareTranslation{English}{solution-plural}{Proposed solutions}
\DeclareTranslation{German}{solution-plural}{Lösungsvorschläge}
\DeclareTranslation{English}{claim}{Claim}
\DeclareTranslation{German}{claim}{Behauptung}
\DeclareTranslation{English}{claim-plural}{Claims}
\DeclareTranslation{German}{claim-plural}{Behauptungen}
\DeclareTranslation{English}{claimproof}{Proof of claim}
\DeclareTranslation{German}{claimproof}{Beweis der Behauptung}
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
			
			%\addvspace{0.1cm}%
			% Time for submission
			\normalfont\normalsize\timefont\ifbool{solutions}{}{
				\ifbool{exam}{
					\GetTranslation{time-limit}: \timelimitvar
				}{
					\GetTranslation{deadline}: \deadlinevar
				}
			}
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
			\normalfont\normalsize\timefont\ifbool{solutions}{}{%
				\ifbool{exam}{%
					\GetTranslation{time-limit}: \timelimitvar%
				}{%
					\GetTranslation{deadline}: \deadlinevar%
				}%
			}
		\end{center}
		\addvspace{0.5cm}
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
\newcounter{claimcounter}
\counterwithin{claimcounter}{ex}
\renewcommand{\theclaimcounter}{\arabic{claimcounter}}

%% Theorem styles
\newtheoremstyle{exercise}% Exactly like "plain" in ntheorem
{\item[\hskip\labelsep \theorem@headerfont ##1\ ##2\theorem@separator]}%
{\item[\hskip\labelsep \theorem@headerfont ##1\ ##2\ ##3\theorem@separator]}%
\newtheoremstyle{exercisenonumber}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\theorem@separator]}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\ (##3)\theorem@separator]}%
\newtheoremstyle{solution}% Like "exercise", but 1. no number and 2. if optional name is given, only the optional name is displayed
{\item[\hskip\labelsep \theorem@headerfont ##1\theorem@separator]}%
{\item[\hskip\labelsep \theorem@headerfont ##3\theorem@separator]}%
\newtheoremstyle{miscenv}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\theorem@separator]}%
	{\item[\hskip\labelsep \theorem@headerfont ##1##3\theorem@separator]}%

%% Exercise and solution environment

% Length
\newlength{\afterthmspace}
\newlength{\afterclaimspace}
\setlength{\afterthmspace}{0.7\baselineskip plus 0.2\baselineskip minus 0.1\baselineskip} % Placed after and before every unboxed theorem
\setlength{\afterclaimspace}{\parskip} % Placed after and before claims and proofs of claims

% Standard settings for all environments
\theorembodyfont{\normalfont}
\theoremsymbol{}

% Exercise (numbered and unnumbered)
\theoremstyle{exercise}
\theoremheaderfont{\normalfont\bfseries}
\theoremseparator{.}
\theorempreskip{\afterthmspace}
\theorempostskip{\afterthmspace}
\newtheorem{exercise}[ex]{\protect\GetTranslation{exercise}}

\theoremstyle{exercisenonumber}
\renewtheorem{exercise*}{\protect\GetTranslation{exercise}}

% Claim (numbered and unnumbered)
\theoremstyle{exercise}
\theoremheaderfont{\normalfont\scshape}
\theoremseparator{:}
\theorempreskip{\afterclaimspace}
\theorempostskip{\afterclaimspace}
\newtheorem{claim}[claimcounter]{\protect\GetTranslation{claim}}

\theoremstyle{exercisenonumber}
\renewtheorem{claim*}{\protect\GetTranslation{claim}}

% miscthm
\theoremstyle{miscenv}
\theoremheaderfont{\normalfont\bfseries}
\theoremseparator{.}
\theorempreskip{\afterthmspace}
\theorempostskip{\afterthmspace}
\newtheorem{miscenv}{}

% Solution
\theoremstyle{solution}
\theoremheaderfont{\normalfont\bfseries\itshape}
\theoremseparator{:}
\theorempreskip{\afterthmspace}
\theorempostskip{\afterthmspace}
\newtheorem{solution}{\protect\GetTranslation{solution}}

% Proof of claim
\theoremstyle{solution}
\newcommand{\qedtriangle}{\hspace{0.5cm}\begin{tikzpicture}[scale=0.23]
	\draw (0,0) -- (1,0) -- (0,1) -- cycle;
\end{tikzpicture}}
\theoremsymbol{\qedtriangle}
\theoremheaderfont{\normalfont\itshape}
\theoremseparator{:}
\theorempreskip{\afterclaimspace}
\theorempostskip{\afterclaimspace}
\newtheorem{claimproof}{\protect\GetTranslation{claimproof}}

% Depending on the bool "solutions", do not print solutions
\ifbool{solutions}{}{
	\renewenvironment{solution}{}{}
	\excludecomment{solution}
}
%%% ----- End of theorem-like environments -----

%%% ----- Proof list environment for proofs with different "canonical" components such as "(1) \implies (2)" or "A \subset B" -----

\newenvironment{prooflist}{\begin{list}{}%
		{\setlength{\labelwidth}{0pt}\setlength{\labelsep}{4pt}\setlength{\itemindent}{\labelsep}\setlength{\leftmargin}{\labelwidth}\setlength{\itemsep}{0.0cm}%
			\let\makelabel\prooflistlabel}}%
	{\end{list}}

\newcommand*{\prooflistlabel}[1]{#1}
\newcommand*{\plimr}[2]{\item[\glqq#1 $ \imr $ #2\grqq]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pliml}[2]{\item[\glqq#1 $ \iml $ #2\grqq]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pleq}[2]{\item[\glqq#1 $ \eq $ #2\grqq]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pleqthree}[3]{\item[\glqq#1 $ \eq $ #2 $ \eq $ #3\grqq]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\plsymb}[1]{\item[\glqq#1\grqq]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pltext}[1]{\item[\emph{#1}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pltextnobreak}[1]{\item[\emph{#1}]}
\newcommand*{\plsubs}[2]{\item[\glqq#1 $ \subs $ #2\grqq]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\plsups}[2]{\item[\glqq#1 $ \sups $ #2\grqq]\mbox{}\nopagebreak\par\nopagebreak}

%%% ----- End of proof list environment -----

%%% ----- Live exercises -----

\newcommand{\makeliveexercisestitle}{
	\vspace{0.5cm}
	\begin{samepage}
		\begin{center}
			\bfseries\large\GetTranslation{live-exercises}
		\end{center}
		\GetTranslation{live-exercises-explanation}
	\end{samepage}
}