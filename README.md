## A simple yet colorful template for Beamer slides.

The file `example.tex` contains a few frames to show how to use it.

## How to use

- Clone this repository somewhere.
- Add the directory of the cloned repository to your `$TEXINPUTS` environment variable.
  
  I personally like to do that on a per-project basis using a `.envrc` file, but this is not required.
- Add the `-recorder` option to the LaTeX engine that you use. 
  This will ensure that the path to `custom.cls` is correctly found, therefore that the included fonts and assets will correctly be included in your presentation.

## Options

- `nofonts` (default = `false`): do not load the default fonts.
  You will have to perform all the fonts setup yourself.
- `listings` (default = `{}`): load the `listings` package, apply the default style, and preload some languages.
  This option accepts a comma-separated list of entries of the form `language-name[:file]` where
  - `language-name` is the name of the language to be used in the `listing` environment.
  - `file` is an optional `.sty` file to be loaded to use the `language-name` in the `listing` environment.