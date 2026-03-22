Examples of new commands and additions:
- (Upright) Math operators such as GL, lcm, Aut.
- Blackboard bold, scripture and calligraphic letters.
- More semantic variants for several standard LaTeX commands, e.g. `\tensor` for `\otimes`, `\union` for `\cup`, `\injarrow` for `\hookrightarrow`.
- Switches the roles of `\phi`, `\epsilon` and `\rho` with their `\var...` variants, and renames the (new) variants as `\vphi`, `\veps`, `\vrho`.
- `\map{f}{X}{Y}{x}{f(x)}` for $ f \colon X \to Y, x \mapsto f(x) $ with automatic recognition of empty arguments:
`\map{f}{X}{Y}{}{}` is $ f \colon X \to Y $,
`\map{}{}{}{x}{f(x)}` is $x \mapsto f(x)$.
Variants `\mapinj`, `\mapsurj`, `\mapbij`, `\mapdash`, `\mapsquig` for different kinds of arrows are defined.
- Paired delimiters from the [mathtools](https://ctan.org/pkg/mathtools) package:
	- `\Set{x \in X \given f(x)=5}` is $ \{ x \in X \mid f(x)=5 \} $. `\Set[\big]` makes the surrounding braces and the vertical rule in the middle bigger, `\Set*` chooses the size of the braces and vertical rule depending on the content (like `\left( ... \right)` in standard LaTeX).
	- Round brackets, square brackets, braces, triangular brackets, norms, absolute values, floor, ceil with a similar syntax as for sets.
- Amazing tricks that I collected from https://tex.stackexchange.com/, such as `\cycle{1,2,3,4}` for a cycle $ (1 \: 2 \: 3 \: 4) $. The optional argument sets the separator: `\cycle[\quad]{1,2,3}` is $(1 \quad 2 \quad 3) $. (Try to do this with a standard `\newcommand{\cycle}{...}`.)
- A few useful non-math commands, such as `\mywarning{message}` which prints a warning `message` into your log file.
This is useful for inserting "todo"-types of messages,
because you can simply compile your file and then look into your log
(which your LaTeX editor should display to you in a convenient way)
to see what is left to do.
- It loads the [microtype](https://ctan.org/pkg/microtype) package, which seems to be a good idea for most types of documents (unless you want to upload your document to the arXiv, in which case I have experienced problems with microtype).