\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custom}

\RequirePackage{pgfkeys, pgfopts}
\RequirePackage[abspath]{currfile}
\RequirePackage{xstring}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{tikz}

\begingroup
\getabspath{custom.cls}%
\xdef\custom@path{\theabsdir}%
\endgroup

%%% Options

\newif\ifcustom@debug
\newif\ifcustom@nofonts
\let\custom@fonts@main\@empty
\let\custom@fonts@sans\@empty
\let\custom@fonts@mono\@empty
\let\custom@listings\@empty

\pgfkeys{/custom/.is family}
\pgfqkeys{/custom}{%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Imports the package `listings`, and include a
	% default style for the listings.
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	listings/.store in=\custom@listings,
	listings/.initial={},
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Set these whenever you don't plan on using the 
	% shipped fonts.
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	fonts/main/.store in=\custom@fonts@main,
	fonts/main/.initial={},
	fonts/sans/.store in=\custom@fonts@sans,
	fonts/sans/.initial={},
	fonts/mono/.store in=\custom@fonts@mono,
	fonts/mono/.initial={},
	fonts/.is family,
	fonts/.code={\pgfqkeys{/custom/fonts}{#1}},
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Debugging option, please do not use.
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	debug/.is if=custom@debug,
	debug/.initial=false,
	%
	% Give other options to beamer, but remove some
	.unknown/.code={%
			\PassOptionsToClass{\pgfkeyscurrentkey}{beamer}%
		},
}

\ProcessPgfOptions{/custom}

%% Load class
\LoadClass[aspectratio=169, utf8, english]{beamer}



\mode<presentation>{\usetheme{custom}}


%% Setup listings, if required

\newif\ifcustom@has@listings
\IfStrEq{\custom@listings}{\@empty}{}{%
	\custom@has@listingstrue
	\RequirePackage{listingscustom}
}

% Insert our title frame at the very beginning of the document
\AtBeginDocument{\begin{frame}[plain,noframenumbering]\maketitle\end{frame}}
% When debugging, insert a special frame right after
\ifcustom@debug
	\AtBeginDocument{%
		\begin{frame}[noframenumbering]{{Debugging frame}}
			\begin{tabular}{r@{\ =\ }l}
				listings   & \custom@listings                    \\
				fonts/main & \custom@fonts@main                  \\
				fonts/sans & \custom@fonts@sans                  \\
				fonts/mono & \custom@fonts@mono                  \\
				debug      & \ifcustom@debug true \else false\fi
			\end{tabular}
		\end{frame}
	}
\fi


\let\beamer@oldauthor\author
\renewcommand\author[2][]{%
	\let\speaker\underline%
	\beamer@oldauthor[#1]{#2}%
}


% \let\beamer@oldframe\frame
% \let\endbeamer@oldframe\endframe

\AtBeginSection{%
	\renewcommand{\subsecname}{}%
}

% TODO: why can't we just redefine the `frame` environment?
\renewenvironment<>{sframe}[1][]{%
	\begin{frame}#2[environment=sframe,#1]
		\expandafter\ifx\relax\secname\relax\else%
			\frametitle{\secname}%
		\fi%
		\expandafter\ifx\relax\subsecname\relax\else%
			\framesubtitle{\subsecname}%
		\fi%
		}{\end{frame}}

\newenvironment<>{sframe*}[1][]{%
	\begin{sframe}#2[#1]
		}{\end{sframe}\addtocounter{framenumber}{-1}%
}


%%%% Various buttons

\newcommand*\custom@gotobutton[2]{\hyperlink{#1}{\beamergotobutton{#2}}}
\newcommand*\custom@returnbutton[2]{\hyperlink{#1}{\beamerreturnbutton{#2}}}
\newcommand*\custom@skipbutton[2]{\hyperlink{#1}{\beamerskipbutton{#2}}}
\newcommand*\button[1]{\beamerbutton{#1}}
\newcommand*\gotobutton{\@ifstar\beamergotobutton\custom@gotobutton}
\newcommand*\skipbutton{\@ifstar\beamerskipbutton\custom@skipbutton}
\newcommand*\returnbutton{\@ifstar\beamerreturnbutton\custom@returnbutton}