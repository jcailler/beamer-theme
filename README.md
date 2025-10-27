## A simple yet colorful template for Beamer slides.

The file `example.tex` contains a few frames to show how to use it.

## How to use

- Clone this repository somewhere.
- Add the directory of the cloned repository to your `$TEXINPUTS` environment variable.
  
  I personally like to do that on a per-project basis using a `.envrc` file, but this is not required.
- Add the `-recorder` option to the LaTeX engine that you use. 
  This will ensure that the path to `rainbow-beamer.cls` is correctly found, therefore that the included fonts and assets will correctly be included in your presentation.

## Options

- `listings` (default = `{}`): load the `listings` package, apply the default style, and preload some languages.
  This option accepts a comma-separated list of entries of the form `language-name[=file-name]` where
  - `language-name` is the name of the language to be used in the `lstlisting` environment.
  - `file-name` is an optional `.sty` file (without the extension!) that must be loaded to use the `language-name` in the `listing` environment.
- `fonts/main`, `fonts/sans`, `fonts/mono` are font names (all default to `{}`) to be used instead of the default ones.
  
  You can set all these (in the class options) either one by one like 
  ```
  fonts/main=...,
  fonts/sans=...,
  fonts/mono=...
  ```
  or all at once like 
  ```
  fonts={
    main=...,
    sans=...,
    mono=...
  }
  ```

  Note that you do not necessarily have to set each. 
  You may choose individual aspects to customize (e.g. only the monospace font).
- `withappendix[=true|false]` (default = `false`) redefines the `\appendix` command to automatically number the appendix frames with letters instead of numbers, and removes them from the total frame count.