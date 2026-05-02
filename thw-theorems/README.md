The following is a documentation of the package options, commands and environments
defined by the thw-theorems class.
Throughout, we use the name "theorem" for any kind of theorem-like environment that is defined by this packages, such as theorem, remark, lemma, ... The only exception is the claim environment, which is not considered to be a theorem-like environment because it works differently.

# Package options

The following options may be passed to the class with a key-value syntax.
| Option | Permissible values | Default | Description |
| ------ | ------ | ------- | ----------- |
| `thmbreak` | bool | `false` | Whether a line break occurs after the heading of a theorem. |
| `theoremlevel` | `none` or a $\LaTeX$ counter | `section` | The counter within which theorems are numbered, or `none` if they are standalone. |
| `cleveref` | - | - | Adds [cleveref](https://ctan.org/pkg/cleveref) support. |
| `no-standard-environments` | - | - | Unless this option is given, a standard list of theorems is defined (see below). |
| `additional-environments` | list of names | empty | A theorem-like environment is defined for every name in the list. |
| `tcb-environments` | list of names | empty | A list of theorem names whose environments are printed in a tcolorbox. |
| `italic-environments` | list of names | `theorem, lemma, corollary, lemcorollary, proposition` | A list of theorem-like environments whose contents are printed in italic (unless the environment is printed in a tcolorbox). |
| `tcb-default` | - | - | If this option is given, a certain default choice (see below) of environments that should be printed in a tcolorbox is used. |
| `thmtoc1`, ..., `thmtoc9` | list of names | - | The list of environments that use the thmtoc with the corresponding number. |
-------------

## Notes on package options

- By default, the following theorem-like environments are defined:
definition, notation, theorem, lemma, corollary, lemcorollary, proposition, algorithm,
remark, example, examples, convention, secconvention, counterexample, counterexamples,
exercise, observation, fact, reminder, construction, note, warning, goal, miscthm.
Here miscthm is special environment that has no heading (except for a number), so
by providing the optional first argument (see below), an environment with an arbitrary
name can be created.
- Environment names given to `tcb-environments` or `italic-environments` that do not
appear in the list of default environments (if used) or in the list given to
`additional-environments` will be ignored without a warning.
- All package options that receive a list of environment names should receive this list
withing braces. For example, `italic-environments = {theorem, lemma}`.
- The order in which package options are given has no effect.

# Syntax for theorem-like environments

## Normal environments

### Unstarred version

A theorem-like environment with name `name` may be used as follows:
```
\begin{name}{additional heading}{label}{thmtoc entry}
	Content.
\end{name}
```
The `additional heading` will be printed after the theorem heading, separated by a space
but not surrounded by brackets. For example,
```
\begin{theorem}{of Gauss}...
```
will print as "x.y Theorem of Gauss".

If `label` is non-empty, it is the name of the label that is given to the environment
for cross-referencing.

`thmtoc entry` is the description of the environment that will appear in the correspoding
thmtoc(s). If the environment `name` is not set up to appear in any thmtoc, this argument
is simply ignored.

Thus altogether, the lines
```
\begin{name}{additional heading}{label}{thmtoc entry}
	Content.
\end{name}
```
are roughly equivalent to the following lines using the standard amsthm or ntheorem
packages:
```
\begin{name}[additional heading]%
	\label{label}%
	\thmtocaddentry[thmtoc number for name]{\thename}{thmtoc entry}
	Content.
\end{name}
```

### Starred version

For every theorem-like environment `name`, there is also an environment `name*` which
is unnumbered. Such environments cannot receive labels and do not appear in thmtocs,
so they receive only one argument: the one for an additional heading.

## Claims

In addition, environments `claim` (numbered) and `claim*` (unnumbered) are also defined,
even if the option `no-standard-environments` is given.
They should be used within proofs.
The numbering of claims is reset after every theorem-like environment.

The syntax for claims is the same as for normal environments, except that there is no argument
for a thmtoc entry. Hence they can be used as follows:
```
\begin{claim}{(Induction step)}{label}
	Content.
\end{claim}

\begin{claim*}{(Induction step)}
	Content.
\end{claim*}
```

## Proofs

Environments `proof` and `claimproof` are defined, even if the option
`no-standard-environments` is given. They receive no mandatory and one optional argument.
If the optional argument is given, it replaces the standard heading "Proof" or "Proof of claim".
The end of a `proof` is marked with a square and the end of a `claimproof` is marked
with a triangle.

# tcolorbox environments

## User commands

If an environment name appears in `tcb-environments`, it will be printed in a
black tcolorbox with grey background. The command
```
\settcbcolor{environment name}{background colour}{frame colour}
```
can be used to change these colours.
This will only affect all environments created after this command.
Internally, this command uses `\colorlet`
to redefine certain colours. The colours should be specified as named colours known
to the xcolor package (or defined by the user), such as "red" or "yellow".
The syntax "red!90!black" for "90% red, 10% black" or "yellow!90" for
"90% yellow, 10% white" is also allowed. If more fine control is required, the
user should first define a new colour with `\definecolor` and then use this
colour in `\settcbcolour`.

## Default settings (`tcb-default`)

If the option `tcb-default` is passed to the package, then the following
environments will be printed in a tcolorbox:
| Environment | Colour |
| ---- | ---- |
| theorem | red |
| definition, notation | yellow, brown |
| corollary | green |
| lemma | blue |
| lemcorollary | dark blue |
| proposition | violet |
| convention, secconvention | black |
-------------

The colours of these environments may be changed with `\settcbcolor` in the
usual way. If the option `tcb-default` is given, additional environments
may be specified in `tcb-environments` to be printed in a tcolorbox.
However, it is not possible to use `tcb-default` with only a proper subset
of the environments listed above printed in a tcolorbox.

# Further commands

## Proof lists

The `prooflist` environment may be used (usually within a `solution` environment)
to give a proof with some "canonical parts", such as implications
"$ \text{(i)} \implies \text{(ii)}$" or inclusions "$ A \subseteq B $". Example:

```
\begin{solution}
	\mbox{}% Ensure line break after "Solution proposal"
	\begin{prooflist}
		\plimr{(i)}{(ii)}
			A proof that statement (i) implies statement (ii).
		
		\plsubs{$A$}{$B$}
			A proof that $A$ is contained in $B$.
		
		\pltext{$\phi$ is a homomorphism}
			A proof that $\phi$ is a homomorphism.
	\end{prooflist}
\end{solution}
```

The following commands are available within a `prooflist`.

| Command | Number of arguments | Displays as |
| - | - | - |
| `\plimr` | 2 | "#1 $\implies$ #2" |
| `\pliml` | 2 | "#1 $\impliedby$ #2" |
| `\pliff` | 2 | "#1 $\iff$ #2" |
| `\pliffthree` | 3 | "#1 $\iff$ #2 $\iff$ #3" |
| `\plsubs` | 2 | "#1 $\subseteq$ #2" |
| `\plsups` | 2 | "#1 $\supseteq$ #2" |
| `\plsymb` | 1 | "#1" |
| `\pltext` | 1 | *#1:* [in italics] |
| `\pltextnobreak` | 1 | *#1:* [in italics, line break afterwards] |
---

## Referencing commands

The command `\thmitemref{thm-label}{item-label}` produces a reference to x.y~(i) where
x.y is the number of the theorem thm-label and (i) is the number of the item
item-label. If the package `hyperref` is loaded, it is equipped with a hyperlink
to `thm-label`.

For example, if
```
\begin{definition}{}{def-label}{}
	\begin{defenumerate}
		\item ...
		\item\label{item-label} ..
	\end{defenumerate}
\end{definition}
```
appears in the document, it may be desirable to reference
`\thmitemref{def-label}{item-label}`.

The variant `\thmitemcref` prepends `\thmitemref` with the crefname of `thm-label`.
Naturally, it may only be used if the `cleveref` package is loaded.

The command `\claimshortref{claim-label}` may be used in place of `\cref{claim-label}`
to abbreviate the word "Claim" to "Cl.".

## Enumerations

The following wrappers of the `enumerate` environments using certain standard
settings are defined:
| Environment name | `\item` |
| ---- | ---- |
| defenumerate, thmenumerate, lemenumerate, proenumerate | (a), (b), ... |
| exenumerate, remenumerate | (1), (2), ... |
| stenumerate | (i), (ii), ... |
-----
By using these environments, the user can ensure that all environments of a certain
type use the same numbering scheme.

# Changing the style

The package defines several "global variables" in the form of commands that may
be changed by the user to change the way things look. Each command name in the
following list must be preprended with `\@thwthm@`
| Command name | Default value | Meaning |
| ---- | ---- | ---- |
| `afterthmspace` | `0.7\baselineskip plus 0.2\baselineskip minus 0.1\baselineskip` | vertical space before and after unboxed theorems and proof |
| `beforeclaimspace` | `0.2\baselineskip plus 0.2\baselineskip minus 0.1\baselineskip` | vertical space before claim and proof of claim |
| `afterboxspace` | `0.4cm plus 0.2cm minus 0.15cm` | vertical space before and after tcolorbox |
| `proofheadfont` | `\normalfont\bfseries\itshape` | Font for header of proof |
| `claimproofheadfont` | `\normalfont\itshape` | Font for header of proof of claim |
| `thmheadfont` | `\normalfont\bfseries` | Font for header of unboxed theorem |
| `tcbthmheadfont` | `\normalfont\bfseries` | Font for header of tcolorbox |
| `claimheadfont` | `\normalfont\scshape` | Font for header of claim |
| `thmbodyfont` | `\normalfont` | Default font for body of unboxed theorem |
| `claimbodyfont` | `\normalfont\itshape` | Font for body of claim |

For example, the font for claim headings may be changed from small capitals to
italics as follows:
```
\makeatletter
\renewcommand{\@thwthm@claimheadfont}{\normalfont\itshape}
\makeatother
```