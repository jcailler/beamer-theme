## A simple yet colorful template for Beamer slides.

The file `example.tex` contains a few frames to show how to use it.

## How to use

- Clone this repository somewhere.
- Add the directory of the cloned repository to your `$TEXINPUTS` environment variable.
  
  I personally like to do that on a per-project basis using a `.envrc` file, but this is not required.
- Add the `-recorder` option to the LaTeX engine that you use. 
  This will ensure that the path to `custom.cls` is correctly found, therefore that the included fonts and assets will correctly be included in your presentation.

## Options

- `listings` (default = `{}`): load the `listings` package, apply the default style, and preload some languages.
  This option accepts a comma-separated list of entries of the form `language-name[=file-name]` where
  - `language-name` is the name of the language to be used in the `listing` environment.
  - `file-name` is an optional `.sty` file (without the extension!) that must be loaded to use the `language-name` in the `listing` environment.
- `fonts/main`, `fonts/sans`, `fonts/mono` are font names (default to `{}`) to be used instead of the default ones.
  You can set all these either one by one like 
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