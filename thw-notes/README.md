The following is a documentation of the class options and commands
defined by the thw-notes class.

# Class options

The following class options are passed on to the thw-theorems package:
 `theoremlevel`, `additional-environments`, `thmbreak`, `cleveref`.

Further, the following options are defined.

-------------
| Option | Permissible values | Default | Description |
| ---- | ---- | ---- | ---- |
| `base-class` | article, report | article | Document class that is loaded as a basis. |
| `mode` | boxes, paper | paper | Determines the general layout of the class (see below). |
| `thmtoc` | thmlemdef, thmdef | thmlemdef | Determines which thmtocs are defined (see below). |
------------------

The main function of choosing a `base-class` is to determine whether
the document should contain chapters or not.

## Class mode

In the "boxes" mode, certain theorem-like environment are printed
in a tcolorbox, using the `tcb-default` setting of the
thw-theorems package.
In the "paper" mode, no tcolorboxes are used.

## thmtoc settings

Independent of the value of the class option `thmtoc`, the following commands are defined:
- `\printallthmtocs`: Prints all thmtocs.
- `\allthmtocaddchapter{chaptername}`: Executes the command
`\thmtocaddchapter{chaptername}` from the thmtoc package for all thmtocs that
are defned.
- `\allthmtocaddsection{sectionname}`: As above, but executes `\thmtocaddsection`.

The following options for the class option `thmtoc` are available.

### thmlemdef
Defines three thmtocs: A List of Theorems (including corollaries),
a List of Lemmas and Propositions (including lemcorollaries) and
a List of Definitions (including notations).

### thmdef

Defines two thmtocs: A List of Theorems and Lemmas (including corollaries,
lemcorollaries, and propositions) and a List of Definitions (including notations).

# Front page

The command `\frontpage` prints a front page, similarly to the `\maketitle` command
in the default document classes.
As the `\maketitle` command, `\frontpage` incorporates the document information
that is set by the user with `\title`, `\author` and `\date`.
In addition, the user may specify `\semester` (for lecture notes), `\logo`
(for a logo, e.g. of the university) and
`\basedon`. The latter can be used to differentiate between the author of the
document and the lecturer, e.g. "written by X, based on lectures by Y".

# Indexing

thw-notes loads the makeidx package, so `\index{entry}` can be used to add entries
to the index. The command `\defemph{#1}` is used to emphasise
(in italic shapre and orange colour) any notion that is
being defined, which is then also added to the index.
`\defemph*{#1}` is printed in the same way, but #1 is not added to the index.

# Usage example

The following is a basic template for using this document class.
```
\documentclass[a4paper, base-class=report, cleveref]{thw-notes}
\usepackage{hyperref}
\usepackage{bookmark}
\usepackage{cleveref}

\makeindex

\title{}
\semester{}
\date{}
\author{}
\basedon{}
\logo{}

\begin{document}
	\selectlanguage{english}
	
	\frontpage
	
	\tableofcontents
	
	\printallthmtocs
	
	\newpage
	
	\chapter{Chapter title}
	
	\allthmtocaddchapter{Chapter title}
	
	%% Index
	\pagestyle{normal}
	
	\newpage
	\RaggedRight
	
	\printindex
\end{document}
```

# Troubleshooting

If you get an error message `Undefined control sequence` at `\begin{document}`,
then most likely, you used the cleveref package option but did not load the
cleveref package.
