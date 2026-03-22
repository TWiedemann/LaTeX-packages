The following is a description how to use this package in a basic way.
For a detailed documentation of all commands, look into the style file.

# Preparations

- Decide how many thmtocs you want to use and what types of environments should be
listed in each of them. In the following example, we assume that we want to create
a thmtoc "List of Theorems and Lemmas" and a thmtoc "List of Definitions".
- For each thmtoc, decide on a (preferably short) internal name. In our example,
we decide on "thm" for the first thmtoc and "def" for the second thmtoc.
The data of the thmtocs will be stored in the files "main.thmtoc_thm" and
"main.thmtoc_def" where "main.tex" is the name of your main tex file.
- If we want to use only one thmtoc, then we do not have to specify an internal name:
All commands that use the internal name accept it as an optional argument, and if
it is not given, then "main.thmtoc" is used instead.

# Loading the package and package options

The title of each thmtoc is formatted using (the starred version of) one of the
standard section commands in $ \LaTeX $, such as `\section*` or `\chapter*`.
The user may specify which one is used by loading the package with the appropriate
thmtoc-head option.
It seems reasonable to use the same sectioning command that is also used for the
table of contents.
In our example, we use the report class, so we want to format our thmtocs as chapters:
```
\usepackage[thmtoc-head={chapter}]
```
Note that *no* backslash and *no* star is used as part of the package option.

The default value of thmtoc-head is "section".
This is not because it is necessarily a good choice,
but rather because `\section*` is defined in most document classes.
If it is not defined in your document class, you have to specifiy thmtoc-head with an appropriate argument.

# Printing a thmtoc

We can print our thmtocs as follows:
```
\printthmtoc[thm]{List of Theorems and Lemmas}
\printthmtoc[def]{List of Definitions}
```
Of course, these thmtocs will be empty in our current example because we did
not yet tell $ \LaTeX $ with which entries they should be filled.

# Filling a thmtoc

## Main entries

Theorems, definitions etc. can be added to a thmtoc with `\thmtocaddentry`:
```
\begin{theorem}\thmtocaddentry[thm]{\thetheoremcounter}{Engel's Theorem}
	...
\end{theorem}

\begin{definition}\thmtocaddentry[def]{\thedefinitioncounter}{Vector space}
	...
\end{definition}
```
Here theoremcounter is the name of the counter used by the theorem environment,
so that `\thetheoremcounter` is its current value. (Or rather, it is the display
of its current value which is usually something like
`\thesection.\arabic{theoremcounter}`.)
The name of this counter need not have anything to do with the environment name,
and most likely, it is not obtained by appending "counter" to the environment name.

If you use one of the standard packages amsthm or ntheorem and defined your
theorem environment as `\newtheorem{theorem}{Theorem}` or
`\newtheorem{theorem}{Theorem}[section]`, then the name of the counter is simply
the name of the associated environment, so theorem in this case.
If you defined your theorem to use another counter, as in
`\newtheorem{definition}[theorem]{Definition}`, then of course you should also
use this counter in `\thmtocaddentry`.
Assuming that our environments "theorem" and "definition" are defined as above,
we can thus add entries to our thmtoc in the following way:
```
\begin{theorem}\thmtocaddentry[thm]{\thetheorem}{Engel's Theorem}
	...
\end{theorem}

\begin{definition}\thmtocaddentry[def]{\thetheorem}{Vector space}
	...
\end{definition}
```
If none of this works for some reason, you can also define your own counter and
use it in the definition of your environments:
```
% thmcounter is reset whenever (the counter) section is increased
\newcounter{thmcounter}[section]
% Counter is printed as section.thmcounter
\renewcommand{\thethmcounter}{\thesection.\arabic{thmcounter}}
% Define environment thm which uses the counter thmcounter
\newtheorem{thm}[thmcounter]{Theorem}
...
\begin{thm}\thmtocaddentry[thm]{\thethmcounter}{Engel's Theorem}
	...
\end{thm}
```

## Structural elements

The setup above ensures that all theorems (etc.), but nothing else, show up in your thmtoc.
You may wish to also enter the names and numbers of sections, chapters and/or other
structural elements into your thmtoc.
To do so, you can use the commands `\thmtocaddpart`, `\thmtocaddchapter`, `\thmtocaddsection`, `\thmtocaddsubsection` immediately after the corresponding structural command:
```
\section{Section name}
\thmtocaddsection[thm]{Section name}
\thmtocaddsection[def]{Section name}
```
Here the name of the section has to be repeated (but nothing prevents you from
supplying a name that is different from the action section name) and the command
has to be used once for every thmtoc which should contain the section.

The commands `\thmtocaddpart`, `\thmtocaddchapter`, `\thmtocaddsection`, `\thmtocaddsubsection`
differ only by the formatting of the desired entry in the thmtoc. If you use
`\thmtocaddsection`, then the entry will be formatted just like a section in the regular
table of contents, even if the entry is actually a chapter.

*Wouldn't it be neat if we didn't have to repeat the section name, and if the
`\thmtocaddsection` command was executed automatically after every section without 
specifying it by hand?* Yes, certainly. Here are some thoughts.
- I normally add only the chapters, of which there are usually just a handful,
to my thmtocs. While an automatic solution would be nice, it is not a huge burden
to add `\thmtocaddchapter` to my document a few times.
- The [nameref](https://ctan.org/pkg/nameref) package allows 
the referencing of the names (and not just the numbers) of sections etc., but it is only intended
for sections that have a label. One could probably use the `\@currentlablename`
command that is used internally by nameref to circumvent this restriction, but
this relies on the internal implementation of nameref, which seems dangerous.
Further, I am cautious about relying more than necessary on a package that patches
important commands such as `\section`.
- At first glance, this seems like a use case for `AddToHook` or rather
`AddToHookWithArguments`. [However, it turns out that, weirdly as it sounds,
the `\section` command is actually a command without arguments.
](https://tex.stackexchange.com/questions/729066/can-addtohookwitharguments-let-us-access-to-the-arguments-of-a-command-that-has#comment1815401_729066)
Hence you can patch `\section` to execute some code at its end, but this code
cannot access the section name (at least not as an argument).
- If you really want to, you can define something like
`\newcommand{\mychapter}[1]{\chapter{#1}\thmtocaddchapter[thm]{#1}}`.
This might break your LaTeX editor's internal table of contents, if it provides one,
but otherwise it should work fine. (In TeXstudio at least, you can probably avoid even this problem by using a .cwl which declares `\mychapter` as a sectioning command.) Maybe you can even manage to make the new command
`\mychapter` available under the old name `\chapter`. However, since the implementation
of the standard LaTeX sectioning commands is known to involve at least some amount
of hardcoding, this may end up being a mess.

## Other elements

You can also enforce a page break in your thmtoc with
`\thmtocnewpage[thm]`.

# Further improvements

Now you know everything you need to create your own thmtocs.
However, there are a few more things you might want to do.

## Adding a thmtoc argument to theorem environments

The above setup relies on you to add a `\thmtocaddentry` command to every theorem
environment.
If you ever forget about this, you will receive no warning.
You may even deliberately make use of this behaviour to omit certain theorems from your thmtoc.
However, if you want to ensure that every theorem is included in your thmtoc
(possibly with an empty string), you can
achieve this by defining a wrapper environment around your theorem environment:
```
\newcounter{thmcounter}[section]
\renewcommand{\thethmcounter}{\thesection.\arabic{thmcounter}}
\newtheorem{internal-theorem}[thmcounter]{Theorem}
% Wrapper environment for internal-theorem
\newenvironment{theorem}[2][]{%
	% Open internal-theorem environment, and pass on optional argument if present
	\ifblank{#1}{\begin{internal-theorem}}{\begin{internal-theorem}[#1]}%
	% Add theorem to thmtoc (with entry name given by second argument)
	\thmtocaddentry[thm]{\thethmcounter}{#2}
}{%
	% Close internal-theorem environment
	\end{internal-theorem}
}%
```
This also avoids specifying the redundant `\thethmcounter` every time, so
altogether it seems like something you should do.
If you find it annoying to copy and paste the definition of the wrapper environment
for every environment you use, have a look at the implementation of the
thw-lecture-notes package, which solves this problem with a foreach loop.


## Customisation

If you are unhappy with the layout of your thmtoc entries,
you can redefine the lengths `\thmtocleftindent`, `\thmtoclabelwidth`, `\thmtocleaderwidth`
that are used in these entries.
You can even change the layout completely by defining a new entry
type with `\dottedcontents{newentrytype}...` or `\titlecontents{newentrytype}...`
and then using this type for your
thmtoc entries.
The latter can be done by passing the new type as a final optional argument to `\thmtocaddentry`:
`\thmtocaddentry[lem]{5.8}{Technical lemma}[newentrytype]`.
Do not forget to declare your new entry type to titletoc with
`\contentsuse{newentrytype}{thmtoc}`.

If you are unhappy with the layout of chapter (or similar) entries in your thmtoc,
you can define a new entry type as above and then redefine `\thmtocaddchapter`.

If you customise the layout of your page headers and footers (with fancyhdr for example),
you may want to redefine `\thmtocmark` which is used to set the mark that is
provided by a thmtoc.

If you want to have some thmtocs in your document whose title is formatted as a
`\section*` and others which are formatted as a `\chapter*`, have a look at the
documentation of `\printthmtocas` in the style file.
