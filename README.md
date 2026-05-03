This is a collection of math-related LaTeX packages and classes that I wrote for my personal use.

# Installation

If you want to use one of these packages or classes in a single document, the easiest solution is
to simply copy the package/class into the same folder as your main tex file.

If you want to use these these packages or classes for many documents, you can add them to you
local `texmf` folder. Instructions on how to do this may be found here, for example:
- https://www.dickimaw-books.com/latex/novices/html/installsty.html
- https://tex.stackexchange.com/questions/2063how-can-i-manually-install-a-package-on-miktex-windows

There are also `.cwl` ("completion word list") files to improve the user experience in TeXstudio
(and possibly other TeX editors) when using these packages/classes.
Information on how to install `.cwl` files may be found
[here](https://texstudio-org.github.io/background.html#cwl-file-placement).

# Overview of the packages and classes

## thw-math

This is the main package that I load in every math-related document
(unless I have a specific reason not to).
It loads several packages that are either standard to include in any math-related document
(such as amsmath) or that I personally use frequently enough to not want to bother 
loading them separately (such as tikz-cd).
It also defines various commands and (a few) environments that I use frequently.
For a precise list of additions, look into the style file.

This package does *not* include any features that are only relevant for specific types of documents,
such as lecture notes or beamer slides,
or whose realisation should depend on the type of document.
This includes the definition of theorem-like environments.
Such tasks are handled by the more specialised packages in this collection.

**Known problems:** I am not aware of any. However, this package loads the font-related packages 
dsfont and mathrsfs and the microtype package, which could conceivably conflict with 
some other things you are doing.

## thw-thmtoc

This package provides an interface for automatically creating a "List of Theorems", 
"List of Definitions" and similar lists, which I refer to as "thmtocs".
This is based on the functionality of the titletoc package.
The packages thw-theorems and thw-lecture-notes use thw-thmtoc to define thmtocs.
For more details, see the readme file for thw-thmtoc.

## thw-theorems

This package defines many theorem-like environments with a variety of
customisation options.
All theorem-like environments may be used with thw-thmtoc.

## thw-notes

This is a document class (not a package) for creating (lecture) notes in mathematics.
Its main job is to load the thw-theorems package with some default settings.
It also loads some other useful packages, such as thw-math, and sets the layout
of the following elements: Page headers and footers, headers of sections/chapters/...,
front page.


## thw-homework

This is document class (not a package) for creating exercise sheets and exams.
It is designed to work as a standalone and hence independent from the other packages.
However, it works well together with thw-math.
This class defines its own theorem-like environments, such as "exercise" and
"solutions", so it should not be combined with thw-theorems.

Key features:
- Defines theorem-like environments such as "exercise", "claim" and "solution".
In particular, this class should not be combined with thw-theorems.
- The printing of solutions can be disabled with a package option.
Hence exercises can go into the same source file as their solutions.
- English and German language support. The desired language should be specified as a package
option and can be changed in the middle of the document with the babel command
`\selectlanguage{name}`.
- Configurable style for page headers, footers and the document title.

