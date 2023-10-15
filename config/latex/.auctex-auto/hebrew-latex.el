(TeX-add-style-hook
 "hebrew-latex"
 (lambda ()
   (setq TeX-command-extra-options
         "-shell-escape")
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("svg" "inkscapeexe=/Applications/Inkscape.app/Contents/MacOS/inkscape" "inkscapearea=page")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "amssymb"
    "xcolor"
    "xpatch"
    "polynom"
    "framed"
    "extarrows"
    "cancel"
    "graphicx"
    "svg"
    "etoolbox"
    "hyperref"
    "pgfplots"
    "polyglossia"
    "amsthm"
    "mathtools")
   (TeX-add-symbols
    "theoremname"
    "definitionname"
    "claimname"
    "lemmaname"
    "remarkname"
    "questionname"
    "examplename"
    "corollaryname"
    "algorithmname"
    "cupdot"
    "trace"
    "Span"
    "divides"
    "diag"
    "en"
    "argmax"
    "argmin"
    "notimplies"
    "notimpliedby")
   (LaTeX-add-xcolor-definecolors
    "darkolivegreen"
    "darkpastelgreen"
    "airforceblue"
    "cadmiumred"
    "fuchsia")
   (LaTeX-add-amsthm-newtheorems
    "theorem"
    "definition"
    "claim"
    "lemma"
    "remark"
    "question"
    "example"
    "corollary"
    "algorithm")
   (LaTeX-add-polyglossia-langs
    '("hebrew" "defaultlanguage" "")
    '("english" "otherlanguage" "")))
 :latex)

