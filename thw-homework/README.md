The following is a documentation of the package options, commands and environments
defined by the thw-homework class.

# Package options

The following options may be passed to the class with a key-value syntax.

| Option | Permissible values | Default | Description |
| ------ | ------ | ------- | ----------- |
| `type` | `exercise`, `exam` | `exercise` | The type of the document. |
| `exam`  | bool | `false` | Sets `type` to `exam` (which overwrites the option `type`). |
| `solutions` | bool | `true` | Whether solutions are printed. |
| `cleveref` | - | - | Adds [cleveref](https://ctan.org/pkg/cleveref) support. |
| `exercise-numbered-within` | `none` or a $ \LaTeX$ counter | `sheet` | The counter within which exercises are numbered, or `none` if they are standalone. |
| `header-firstpage` | bool | `false` | Whether the page header appears only on the first page. |
| `header-author-pos` | `left`, `right` | `right` | Where in the page header the author name(s) appear. This will also affect the placement of other elements in the header. |
| `coursename-in-header` | bool | `true` | Whether the course name is placed in the page header. Of not, it is placed in the document title. |
| `style` | `head-logo`, `no-logo` | `head-logo` | The style of the document. Currently this only affects the page header. |
| language (e.g. `german`, `english`) | Any language supported by babel | - | Passed on to babel package |
-------------

Package option whose permissible value is "bool" allow `true` and `false`. If no value is given for such an option, the value `true` is passed on: Thus `\documentclass[exam]{thw-homework}` is the same as `\documentclass[exam=true]{thw-homework}`.

Usually, `exercise-numbered-within` should be `sheet` (the counter which holds
the number of the exercise sheet) for exercise sheets and `none` for exams.
However, it can be set to any $\LaTeX$ counter (that is already defined during class loading),
such as `section`.

The following document styles are available:
- `head-logo`: In this style, the logo of the university is printed on the left
or right side of the page header (namely, on the opposite position that is specified
by `header-author-pos`). The author(s), semester and possibly (depending on `coursename-in-header`) the course name are printed on the other side of the page header.
- `no-logo`: The author(s) is/are printed and one side of the page header,
the semester (and possibly the course name) on the other side.

# Specifying document information

The following commands are available to specify information about the document.
They should be used in the preamble of the document.

| Command | Information | Used in |
| - | - | - |
| `\author` | Author | Page header |
| `\semester` | Semester | Page header |
| `\coursename` | Name of the course | Page header or document title |
| `\unilogo` | Logo of the university | Page header |
| `\examname` | Name of the exam | Document title |
| `\sheetnumber` | Number of exercise sheet | Document title |
| `\timelimit` | Submission deadline (for exercise sheet) or time limit (for exam) | Document title |
---

The university logo will probably be an image file.
Depending on its height, you may have to adjust the height of the pager header
with `\setlength{\headheigth}{10pt}`, where `10pt` should be replaced by the
desired length.

# Document title

As in other classes, the document title may be inserted with `\maketitle`.
It consists of:
- The name of the course if the package option `coursename-in-header` is `false`.
- For an exercise sheet, the number of the sheet. For an exam, the name of the exam.
- Additional information that the document contains solutions if the package option
`solutions` is `true`.
- For an exercise sheet, the submission deadline. For an exam, the time limit.
This information is suppressed if `solutions` is `true`.

# Theorem-like environments

The following theorem-like environments are defined (using ntheorem).
Each has an optional argument that specifies additional information.

| Environment name | Numbered | Display name | Usage | Optional argument
| - | - | - | - | - |
| `exercise` | Yes (see `exercise-numbered-within`) | Exercise | For exercises | Appended in brackets |
| `exercise*` | No | Exercise | For exercises | Appended in brackets |
| `solution` | No | Solution proposal | For solutions of exercises without `verbatim` content | Replaces display name |
| `solution-fragile` | No | Solution proposal | For solutions of exercises containing `verbatim` content | Replaces display name |
| `claim` | Yes (within exercise) | Claim | For claims within solutions | Appended in brackets |
| `claim*` | No | Claim | For claims within solutions | Appended in brackets |
| `claimproof` | No | Proof of claim | Appended in brackets |
| `miscthm` | No | | Replaces display name |
---

The content of `solution` and `solution-fragile` environments is not printed if
the package option `solutions=false` is given. Both environments look the same,
but only `solution-fragile` may contain `verbatim` content, such as the
`verbatim` environment or code listings. However, the `solution-fragile` environment
produces compilation errors if the line containing `\end{solution-fragile}`
also contains tabs or spaces before `\end{solution-fragile}`.

# Further commands

`\points{4}` produces the number 4 with a circle around it, which may be used
to indicate points (e.g. in the solution proposal).

`\makeliveexercisestitle` creates a heading "Live exercises" which may be used
to separate live exercises from regular exercises.

The `prooflist` environment may be used (usually within a `solution` environment)
to give a proof with some "canonical parts", such as implications
"$ \text{(i)} \implies \text{(ii)}$" or inclusions "$ A \subseteq B $". For details,
see the documentation of the package thw-theorems.

# Customisation

In addition to specifying package options, there are a few more customisation
that the user can make by redefining internal commands or lengths.
Their names usually contain the @ symbol, so that any code changing them should
be surrounded by `\makeatletter` and `\makeatother`, as in the following example.
```
\makeatletter
% "Exercise" is written in italics and not in boldface
\renewcommand{\@homework@exerciseheaderfont}{\normalfont\itshape}
% Sets space before and after theorem-like environments to 2cm
% (with up to 0.2cm positive and 0.1cm negative stretching)
\setlength{\@homework@afterthmspace}{2cm plus 0.2cm minus 0.1cm}
\makeatother
```

| Command | Default value | Meaning |
| - | - | - |
| `\@homework@timefont` | `\itshape` | Font used for submission deadline and time limit |
| `\@homework@titlefont` | `\LARGE\bfseries` | Font used for first line in document title |
| `\@homework@subtitlefont` | `\Large\bfseries` | Font used for subtitle in document title, if it exists |
| `\@homework@liveexercisestitlefont` | `\LARGE\bfseries` | Font used for header indicating live exercises |
| `@homework@exerciseheaderfont` | `\bfseries` | Font used for "Exercise x.y" |
| `@homework@claimheaderfont` | `\scshape` | Font used for "Claim x" |
| `@homework@miscthmheaderfont` | `\bfseries` | Font used for `miscthm` |
| `@homework@solutionheaderfont` | `\bfseries\itshape` | Font used for "Solution proposal" |
| `@homework@claimproofheaderfont` | `\itshape` | Font used for "Proof of claim" |
| `\@homework@claimproofqedsymbol` | A triangle | QED symbol at the end of each proof of claim |

| Length | Default value | Meaning |
| - | - | - |
| `\@homework@afterthmspace` | `0.7\baselineskip plus 0.2\baselineskip minus 0.1\baselineskip` | Space before/after each theorem-like environment (except (proof of) claim) |
| `\@homework@afterclaimspace` | `\parskip` | Space before/after each (proof of) claim |

# Localisation

The text used by the class may be changed for any language using the
`DeclareTranslation` command from the [translations](https://ctan.org/pkg/translations)
package.
For example, the class file contains the following lines:
```
\DeclareTranslation{English}{deadline}{Submission until}
\DeclareTranslation{German}{deadline}{Abgabe bis}
```
For a full list of texts that are used and may be changed, see the end of the
class file.
