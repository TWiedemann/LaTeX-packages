%%% This is a document class for creating exercise sheets (with or without solutions) and exams
%%% in mathematics.

% ----- Identification part ----

\ProvidesClass{thw-homework}
% We use the LaTeX 3 syntax for key/value package options, which was introduced to
% the LaTeX kernel in 2020,
% and also \UseName, which according to the LaTeX Companion 3, page 528 was added in 2022.
\NeedsTeXFormat{LaTeX2e}[2022/06/02]

%%% ----- Package options -----

% List of allowed package options
\DeclareKeys{
	% Type of document: exercise (for exercise sheets) or exam (for exams).
	type.store = \@homework@type,
	% This option sets type to "exam" if given
	exam.code = {\renewcommand{\@homework@type}{exam}},
	% If true, then the content of "solution" and "solution-fragile" environments
	% is printed, otherwise not.
	solutions.if = @homework@solutions,
	% This option should be given if cleveref is used.
	% It ensures that crefnames are defined for all environments that require them.
	cleveref.code = {%
		\AddToHook{begindocument}{%
			\crefname{exercise}{\GetTranslation{exercise}}{\GetTranslation{exercise-plural}}%
			\crefname{solution}{\GetTranslation{solution}}{\GetTranslation{solution-plural}}%
			\crefname{claim}{\GetTranslation{claim}}{\GetTranslation{claim-plural}}%
		}%
		% Cleveref fix needed for LaTeX 2025 and newer, see
		% https://tex.stackexchange.com/questions/732050/cleveref-treats-all-ntheorem-environments-as-lemmas
		\AddToHook{env/exercise/begin}{\crefalias{exercisecounter}{exercise}}
		\AddToHook{env/claim/begin}{\crefalias{claimcounter}{claim}}
	},
	% Either a counter of which the exercise counter should be a subcounter,
	% or "none", which signifies that the exercise counter has no supercounter.
	exercise-numbered-within.store = \@homework@exwithin,
	% If true, the page header is printed only on the first page.
	header-firstpage.if = @homework@headerfirstpage,
	% Position of the column in page header which contains the author.
	% Should be either "left" or "right"
	header-author-pos.store = \@homework@authorpos,
	% If true, the name of the course appears in the page header.
	% Otherwise it appears in \maketitle.
	coursename-in-header.if = @homework@courseheader,
	% The style of the document. Should be one of the following:
	% head-logo: One column of the page header contains the university logo.
	%            The other column contains author, semester, and possibly the course name.
	% no-logo: The university logo does not appear. One column of the page header
	%          contains the author, the other one contains the semester and possibly
	%          the course name.
	style.store = \@homework@docstyle,
	sheet-title-symb.store = \@homework@sheettitlesymb
}

\DeclareUnknownKeyHandler{
    \PassOptionsToClass{\CurrentOption}{article}
}

% Default values for package options
\SetKeys{
	solutions=true,
	type=exercise,
	exercise-numbered-within=sheet,
	header-firstpage=false,
	header-author-pos=right,
	coursename-in-header=true,
	style=head-logo,
	sheet-title-symb={}
}

\ProcessKeyOptions

%%% ----- Package and class loading -----

\LoadClass{article} % based on article class

\RequirePackage{etoolbox} % programming utilities such as \ifbool
\RequirePackage{lastpage} % for \pageref{LastPage}
\RequirePackage[left=4cm,right=4cm,top=2cm,bottom=3cm]{geometry} % Page margins
\RequirePackage[thmmarks]{ntheorem} % For theorem-like environments
\RequirePackage{comment} % For making solutions invisible
\RequirePackage{parskip} % Layout with parskip instead of parindent
\RequirePackage{tikz} % For \points
\RequirePackage{babel} % Language support
\RequirePackage[
	autostyle=true, german=quotes, english=american
]{csquotes} % Quotation marks, used in prooflist
\RequirePackage{amsmath} % For some symbols used in prooflist
\RequirePackage{fancyhdr} % Header and footer
\RequirePackage{translations} % Multi-language support

%%% ----- Warnings for incorrect package options -----

\ifdefstring{\@homework@docstyle}{head-logo}{}{
	\ifdefstring{\@homework@docstyle}{no-logo}{}{
		\PackageWarning{thw-homework}{
			Incorrect option for key "style": Only "head-logo" and "no-logo" are allowed.
		}
	}
}

\ifdefstring{\@homework@type}{exam}{}{
	\ifdefstring{\@homework@type}{exercise}{}{
		\PackageWarning{thw-homework}{
			Incorrect option for key "type": Only "exam" and "exercise" are allowed.
		}
	}
}

\ifdefstring{\@homework@authorpos}{left}{}{
	\ifdefstring{\@homework@authorpos}{right}{}{
		\PackageWarning{thw-homework}{
			Incorrect option for key "header-author-pos": Only "left" and "right" are allowed.
		}
	}
}

%%% ----- Global variables and user commands -----

%% For all document types
\newcommand{\@homework@unilogo}{} % Logo of the university
\newcommand{\unilogo}[1]{\renewcommand{\@homework@unilogo}{#1}}
\newcommand{\@homework@semester}{} % Current semester
\newcommand{\semester}[1]{\renewcommand{\@homework@semester}{#1}}
\newcommand{\@homework@coursename}{} % Course name
\newcommand{\coursename}[1]{\renewcommand{\@homework@coursename}{#1}}
\newcommand{\@homework@timelimit}{} % Time limit for the exam / Deadline for submission
\newcommand{\timelimit}[1]{\renewcommand{\@homework@timelimit}{#1}}
% Ensure that, if the user provides no \author{...} statement, then \@author is
% blank. This is necessary for the skipping of empty lines in the page header.
\author{}

%% Only in exercise mode
\newcounter{sheet}
\newcommand{\sheetnumber}[1]{\setcounter{sheet}{#1}} % Sheet number

%% Only in exam mode
\newcommand{\@homework@examname}{} % Name of the exam (e.g. "Abschlussklausur")
\newcommand{\examname}[1]{\renewcommand{\@homework@examname}{#1}}


%%%  ----- Misc commands -----
\newcommand*\points[1]{\tikz[baseline=(char.base)]{ % Points
	\node[shape=circle,draw,inner sep=1pt] (char) {#1};}
}

%%% ----- Define page styles -----

% Empty styles
\fancypagestyle{head-empty}{
	\fancyhead{}%
	\renewcommand{\headrulewidth}{0pt}
}

\fancypagestyle{foot-empty}{
	\fancyfoot{}%
	\renewcommand{\footrulewidth}{0pt}
}

%% Page headers

% Style "head-logo"
\newcommand{\@homework@authorhead}{} % Part of header which contains author name. Used in head-logo.

\fancypagestyle{head-logo}{
	\fancyhead{}%
	\setlength{\headheight}{46.55pt}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\@homework@authorhead}{
		\def\@homework@sep{}% Internal helper. Is set to "\\" after first non-empty line.
		\ifbool{@homework@courseheader}{%
			% Print course name, semester, author separated by "\\", but leave out
			% empty lines
			\ifdefempty{\@homework@coursename}{}{%
				\textbf{\@homework@coursename}%
				\def\@homework@sep{\\}%
			}%
			\ifdefempty{\@homework@semester}{}{%
				\@homework@sep\textbf{\@homework@semester}%
				\def\@homework@sep{\\}%
			}%
			\ifdefempty{\@author}{}{%
				\@homework@sep\@author%
			}%
		}{%
			\ifdefempty{\@author}{}{%
				\@author%
				\def\@homework@sep{\\}%
			}%
			\ifdefempty{\@homework@semester}{}{
				\@homework@sep\@homework@semester
			}
		}%
	}
	\ifdefstring{\@homework@authorpos}{left}{
		\fancyhead[R]{\@homework@unilogo}%
		\fancyhead[L]{\@homework@authorhead}%
	}{
		\fancyhead[L]{\@homework@unilogo}%
		\fancyhead[R]{\@homework@authorhead}%
	}
}

% Style "head-no-logo"
\newcommand{\@homework@semesterhead}{}

\fancypagestyle{head-no-logo}{
	\fancyhead{}%
	\setlength{\headheight}{22.55pt}
	\renewcommand{\@homework@semesterhead}{%
		\def\@homework@sep{}% Internal helper. Is set to "\\" after first non-empty line.
		\ifbool{@homework@courseheader}{%
			\ifdefempty{\@homework@coursename}{}{%
				\@homework@coursename%
				\def\@homework@sep{\\}%
			}%
		}{}%
		\ifdefempty{\@homework@semester}{}{\@homework@sep\@homework@semester}%
	}%
	\ifdefstring{\@homework@authorpos}{left}{
		\fancyhead[L]{\@author}%
		\fancyhead[R]{\@homework@semesterhead}%
	}{%
		\fancyhead[R]{\@author}%
		\fancyhead[L]{\@homework@semesterhead}%
	}
}

%% Page footers

\fancypagestyle{foot-pagenum}{
	\fancyfoot{}%
	\fancyfoot[C]{\thepage/\pageref*{LastPage}}%
	\renewcommand{\footrulewidth}{0pt}%
}

\fancypagestyle{foot-backside}{
	\fancyfoot{}%
	\fancyfoot[C]{\GetTranslation{backside}}%
	\fancyfoot[R]{\thepage/\pageref*{LastPage}}%
	\renewcommand{\footrulewidth}{0.4pt}%
}

%%% ----- Set page style depending on package options -----

\fancyhf{} % Reset header and footer

% Page footer
\ifdefstring{\@homework@type}{exam}{
	\pagestyle{foot-backside}
}{
	\pagestyle{foot-pagenum}
}

% Page header
\ifbool{@homework@headerfirstpage}{% Header should only appear on first page
	% Normal page style is empty
	\pagestyle{head-empty}
	% Page style for this (i.e. first) page is non-empty
	\ifdefstring{\@homework@docstyle}{head-logo}{
		\thispagestyle{head-logo}
	}{}
	\ifdefstring{\@homework@docstyle}{no-logo}{
		\thispagestyle{head-no-logo}
	}
}{% Header appears on all pages
	% Set appropriate page style
	\ifdefstring{\@homework@docstyle}{head-logo}{
		\pagestyle{head-logo}
	}{}
	\ifdefstring{\@homework@docstyle}{no-logo}{
		\pagestyle{head-no-logo}
	}
}

%%% ----- Document title (\maketitle) -----

% The string "Sheet 5" of "Final exam" that appears in the title,
% possibly appended by ": Solution proposal",
% and surrounded by \@homework@sheettitlesymb (e.g. --).
\newcommand{\@homework@sheetstring}{
	\@homework@sheettitlesymb{}
	\ifdefstring{\@homework@type}{exam}{%
		\@homework@examname%
	}{}%
	\ifdefstring{\@homework@type}{exercise}{%
		\GetTranslation{sheet}~\thesheet%
	}{}%
	\ifbool{@homework@solutions}{%
		: \GetTranslation{solution-doctitle}%
	}{}
	\@homework@sheettitlesymb
}

% Font for \@homework@timestring
\newcommand{\@homework@timefont}{\itshape}

% The string "Submission until: ..." or "Time limit: ..." for homework/exam.
\newcommand{\@homework@timestring}{
	\@homework@timefont%
	\ifdefstring{\@homework@type}{exam}{
		\GetTranslation{time-limit}%
	}{}%
	\ifdefstring{\@homework@type}{exercise}{
		\GetTranslation{deadline}%
	}{}%
	: \@homework@timelimit
}

% Font for first/second line in \maketitle
\newcommand{\@homework@titlefont}{\LARGE\bfseries}
\newcommand{\@homework@subtitlefont}{\Large\bfseries}

% Title of document
\renewcommand{\maketitle}{
	\begin{center}
		\ifbool{@homework@courseheader}{%
			\@homework@titlefont\@homework@sheetstring

			\ifbool{@homework@solutions}{}{\normalfont\normalsize\@homework@timestring}
		}{%
			\@homework@titlefont\@homework@coursename

			\normalfont\normalsize% Reset font
			\@homework@subtitlefont\@homework@sheetstring

			\ifbool{@homework@solutions}{}{\normalfont\normalsize\@homework@timestring}
		}
		
		\addvspace{0.5cm}
	\end{center}
}

%%% ----- Intermediate title for live exercises -----

\newcommand{\@homework@liveexercisestitlefont}{\bfseries\large}

\newcommand{\makeliveexercisestitle}{
	\vspace{0.5cm}
	\begin{samepage}
		\begin{center}
			\bfseries\large\GetTranslation{live-exercises}
		\end{center}
		\GetTranslation{live-exercises-explanation}
	\end{samepage}
}

%%% ----- Setup for theorem-like environments -----

%% Exercise counter, either as an independent counter or as a subcounter
\ifdefstring{\@homework@exwithin}{none}{
	\newcounter{exercisecounter}
	\renewcommand{\theexercisecounter}{\arabic{exercisecounter}}
}{
	% Subcounter of \@homework@exwithin
	\newcounter{exercisecounter}[\@homework@exwithin]
	% Exercise number is preprended by supercounter number (\UseName{xyz} = \xyz)
	\renewcommand{\theexercisecounter}{\UseName{the\@homework@exwithin}.\arabic{exercisecounter}}
}

%% Claim counter
% This counter is reset after every exercise, but the exercise number is not printed as part of
% the claim number
\newcounter{claimcounter}
\counterwithin{claimcounter}{exercisecounter}
\renewcommand{\theclaimcounter}{\arabic{claimcounter}}

%% Theorem styles
% Exactly like "plain" in ntheorem
\newtheoremstyle{exercise}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\ ##2\theorem@separator]}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\ ##2\ (##3)\theorem@separator]}%
% Like "exercise", but without numbering
\newtheoremstyle{exercisenonumber}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\theorem@separator]}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\ (##3)\theorem@separator]}%
% Like "exercise", but no numbering and
% if optional name is given, only the optional name is displayed
\newtheoremstyle{solution}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\theorem@separator]}%
	{\item[\hskip\labelsep \theorem@headerfont ##3\theorem@separator]}%
% Environments with custom names
\newtheoremstyle{miscenv}%
	{\item[\hskip\labelsep \theorem@headerfont ##1\theorem@separator]}%
	{\item[\hskip\labelsep \theorem@headerfont ##1##3\theorem@separator]}%

%% Lengths
% Space before/after each theorem-like environment (except (proof of) claim)
\newlength{\@homework@afterthmspace}
\setlength{\@homework@afterthmspace}{0.7\baselineskip plus 0.2\baselineskip minus 0.1\baselineskip}
% Space before/after each (proof of) claim
\newlength{\@homework@afterclaimspace}
\setlength{\@homework@afterclaimspace}{\parskip}

%% Fonts
\newcommand{\@homework@exerciseheaderfont}{\bfseries}
\newcommand{\@homework@funfactheaderfont}{\bfseries}
\newcommand{\@homework@claimheaderfont}{\scshape}
\newcommand{\@homework@miscenvheaderfont}{\bfseries}
\newcommand{\@homework@solutionheaderfont}{\bfseries\itshape}
\newcommand{\@homework@claimproofheaderfont}{\itshape}

%% Separator symbols
\newcommand{\@homework@exerciseseparator}{.}
\newcommand{\@homework@funfactseparator}{.}
\newcommand{\@homework@claimseparator}{:}
\newcommand{\@homework@miscenvseparator}{.}
\newcommand{\@homework@solutionseparator}{:}
\newcommand{\@homework@claimproofseparator}{:}

%%% ----- Definition of theorem-like environments -----

%% Standard settings for all environments
\theorembodyfont{\normalfont}
\theoremsymbol{} % No symbol at the end of environment

%% exercise (numbered)
\theoremstyle{exercise}
\theoremheaderfont{\normalfont\@homework@exerciseheaderfont}
\theoremseparator{\@homework@exerciseseparator}
\theorempreskip{\@homework@afterthmspace}
\theorempostskip{\@homework@afterthmspace}
\newtheorem{exercise}[exercisecounter]{\protect\GetTranslation{exercise}}

%% exercise* (unnumbered)
\theoremstyle{exercisenonumber}
\renewtheorem{exercise*}{\protect\GetTranslation{exercise}}

%% funfact (unnumbered)
\theoremstyle{exercisenonumber}
\theoremheaderfont{\normalfont\@homework@funfactheaderfont}
\theoremseparator{\@homework@funfactseparator}
\theorempreskip{\@homework@afterthmspace}
\theorempostskip{\@homework@afterthmspace}
\newtheorem{funfact}{\protect\GetTranslation{funfact}}

% claim (numbered)
\theoremstyle{exercise}
\theoremheaderfont{\normalfont\@homework@claimheaderfont}
\theoremseparator{\@homework@claimseparator}
\theorempreskip{\@homework@afterclaimspace}
\theorempostskip{\@homework@afterclaimspace}
\newtheorem{claim}[claimcounter]{\protect\GetTranslation{claim}}

%% claim* (unnumbered)
\theoremstyle{exercisenonumber}
\renewtheorem{claim*}{\protect\GetTranslation{claim}}

%% miscenv
\theoremstyle{miscenv}
\theoremheaderfont{\normalfont\@homework@miscenvheaderfont}
\theoremseparator{\@homework@miscenvseparator}
\theorempreskip{\@homework@afterthmspace}
\theorempostskip{\@homework@afterthmspace}
\newtheorem{miscenv}{}

%% Solution
\theoremstyle{solution}
\theoremheaderfont{\normalfont\@homework@solutionheaderfont}
\theoremseparator{\@homework@solutionseparator}
\theorempreskip{\@homework@afterthmspace}
\theorempostskip{\@homework@afterthmspace}
% There are two ways of defining an environment whose content is not shown if a
% boolean switch is active:
% 1. Using \NewDocumentEnvironment with an explicit body argument b.
%    (The "+" prefix before "b" esnures that multiple paragraphs in the body are allowed.)
%    This does not work if the body contains verbatim content, e.g. from the verbatim environment.
%    See https://tex.stackexchange.com/a/489459/166297
% 2. Using the "comment" package, we can use \excludecomment to define an environment
%    that does nothing and does not print its content.
%    In such environments, verbatim content is allowed.
%    However, the end statement of such an environment may not be preceded by tabs
%    or spaces, which is annoying.
%    See https://tex.stackexchange.com/questions/624081/including-an-optional-answer-in-an-exam-paper/624212#624212
% We define an environment "solution" with approach 1, which is used in the (usual)
% case that no verbatim content is needed.
% We define a second environment "solution-fragile" with approach 2. It can be used
% when verbatim content is desired, and the user has to ensure that "\end{solution-fragile}"
% is not preceded by any content on its line.
% Both environments "solution" and "solution-fragile" are wrappers for the
% ntheorem environment "solution-internal".
\newtheorem{solution-internal}{\protect\GetTranslation{solution}}
\NewDocumentEnvironment{solution}{o +b}{%
	\ifbool{@homework@solutions}{
		% Wrap solution-internal, and pass on the optional argument correctly.
		\IfNoValueTF{#1}{%
			\begin{solution-internal}
				#2
			\end{solution-internal}
		}{%
			\begin{solution-internal}[#2]
				#2
			\end{solution-internal}
		}%
	}{} % If @homework@solutions is false, do nothing
}{}
\ifbool{@homework@solutions}{
	\NewDocumentEnvironment{solution-fragile}{o}{%
		% Wrap solution-internal, and pass on the optional argument correctly.
		\IfNoValueTF{#1}{\begin{solution-internal}}{\begin{solution-internal}[#1]}
	}{%
		\end{solution-internal}%
		\ignorespacesafterend% see https://tex.stackexchange.com/a/82860/166297
	}%
}{% If @homework@solutions is false, use \excludecomment
	\excludecomment{solution-fragile}
}

%% Proof of claim
\theoremstyle{solution}
\newcommand{\@homework@qedtriangle}{\hspace{0.5cm}\begin{tikzpicture}[scale=0.23]
	\draw (0,0) -- (1,0) -- (0,1) -- cycle;
\end{tikzpicture}}
\newcommand{\@homework@claimproofqedsymbol}{\@homework@qedtriangle}
\theoremsymbol{\@homework@claimproofqedsymbol}
\theoremheaderfont{\normalfont\@homework@claimproofheaderfont}
\theoremseparator{\@homework@claimproofseparator}
\theorempreskip{\@homework@afterclaimspace}
\theorempostskip{\@homework@afterclaimspace}
\newtheorem{claimproof}{\protect\GetTranslation{claimproof}}

%%% ----- Proof list environment -----

% This environment is intended for proofs with different "canonical" components such as
% "(1) \implies (2)" or "A \subset B".
% Example:
% \begin{prooflist}
% 	\plimr{(i)}{(ii)}% (i) => (ii)
% 		...
% 	\plimr{(ii)}{(i)}% (ii) => (i)
% 		...
% \end{prooflist}

%% Internal helper command
\newcommand*{\@homework@prooflistlabel}[1]{#1}

\newenvironment{prooflist}{%
	\begin{list}{}{
		\setlength{\labelwidth}{0pt}%
		\setlength{\labelsep}{4pt}%
		\setlength{\itemindent}{\labelsep}%
		\setlength{\leftmargin}{\labelwidth}%
		\setlength{\itemsep}{0.0cm}%
		\let\makelabel\@homework@prooflistlabel%
	}
}{%
	\end{list}
}

%% Items within prooflist
\newcommand*{\plimr}[2]{\item[\enquote{#1 $ \implies $ #2}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pliml}[2]{\item[\enquote{#1 $ \impliedby $ #2}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pliff}[2]{\item[\enquote{#1 $ \iff $ #2}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pliffthree}[3]{\item[\enquote{#1 $ \iff $ #2 $ \iff $ #3}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\plsymb}[1]{\item[\enquote{#1}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pltext}[1]{\item[\emph{#1}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\pltextnobreak}[1]{\item[\emph{#1}]}
\newcommand*{\plsubs}[2]{\item[\enquote{#1 $ \subseteq $ #2}]\mbox{}\nopagebreak\par\nopagebreak}
\newcommand*{\plsups}[2]{\item[\enquote{#1 $ \supseteq $ #2}]\mbox{}\nopagebreak\par\nopagebreak}

%%% ----- Dictionary for multilanguage support -----
\DeclareTranslation{English}{exercise}{Exercise}
\DeclareTranslation{German}{exercise}{Aufgabe}
\DeclareTranslation{English}{exercise-plural}{Exercises}
\DeclareTranslation{German}{exercise-plural}{Aufgaben}
\DeclareTranslation{English}{funfact}{Fact of the Week}
\DeclareTranslation{German}{funfact}{Information der Woche}
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
\DeclareTranslation{German}{live-exercises-explanation}{%
	Die folgenden Aufgaben sind dazu gedacht, während der Übungsstunde bearbeitet zu werden,
	wenn nach der Besprechung der Lösungsvorschläge noch Zeit bleibt.
	Sie sind ein Zusatzangebot und \emph{nicht} Teil der Abgabe.
}
\DeclareTranslation{English}{solution-doctitle}{Solution proposal}
\DeclareTranslation{German}{solution-doctitle}{Lösungsvorschläge}
\DeclareTranslation{English}{time-limit}{Time limit}
\DeclareTranslation{German}{time-limit}{Bearbeitungszeit}
\DeclareTranslation{English}{backside}{Please turn over.}
\DeclareTranslation{German}{backside}{Rückseite beachten!}
