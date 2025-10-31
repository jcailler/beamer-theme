\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rainbow-beamer}

\RequirePackage{pgfkeys, pgfopts}
\RequirePackage[abspath]{currfile}
\RequirePackage{xstring}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{tikz}

% Ensure luatex or xetex engine
\RequirePackage{iftex}
\RequireTUTeX%

\begingroup
\getabspath{rainbow-beamer.cls}%
\xdef\rainbow@path{\theabsdir}%
\endgroup

%%% Options

\newif\ifrainbow@debug
\newif\ifrainbow@nofonts
\newif\ifrainbow@withappendix
\newif\ifrainbow@sectionpage
\let\rainbow@fonts@main\@empty
\let\rainbow@fonts@sans\@empty
\let\rainbow@fonts@mono\@empty
\let\rainbow@fonts@math\@empty
\let\rainbow@listings\@empty


\pgfkeys{/rainbow/.is family}
\pgfqkeys{/rainbow}{%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Imports the package `listings`, and include a
	% default style for the listings.
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	listings/.store in=\rainbow@listings,
	listings/.initial={},
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Set these whenever you don't plan on using the 
	% shipped fonts.
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	fonts/main/.store in=\rainbow@fonts@main,
	fonts/main/.initial=\@empty,
	fonts/sans/.store in=\rainbow@fonts@sans,
	fonts/sans/.initial=\@empty,
	fonts/mono/.store in=\rainbow@fonts@mono,
	fonts/mono/.initial=\@empty,
	fonts/math/.store in=\rainbow@fonts@math,
	fonts/math/.initial=\@empty,
	fonts/.is family,
	fonts/.code={\pgfqkeys{/rainbow/fonts}{#1}},
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Debugging option, please do not use.
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	debug/.is if=rainbow@debug,
	debug/.initial=false,
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Sectionpage option
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	sectionpage/.is if=rainbow@sectionpage,
	sectionpage/.initial=false,
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Will you use `\appendix'?
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	withappendix/.is if=rainbow@withappendix,
	withappendix/.initial=false,
	%
	% Give other options to beamer, but remove some
	.unknown/.code={%
			\PassOptionsToClass{\pgfkeyscurrentkey}{beamer}%
		},
}

\ProcessPgfOptions{/rainbow}

%% Load class
\LoadClass[
	aspectratio=169,
	noamssymb,
	10pt
]{beamer}



\mode<presentation>{\usetheme{rainbow}}


%% Setup listings, if required

\newif\ifrainbow@has@listings
\IfStrEq{\rainbow@listings}{\@empty}{}{%
	\rainbow@has@listingstrue
	\RequirePackage{listings-rainbow}
}

% Insert our title frame at the very beginning of the document
\AtBeginDocument{\begin{frame}[plain,noframenumbering]\maketitle\end{frame}}
% When debugging, insert a special frame right after
\ifrainbow@debug
	\AtBeginDocument{%
		\begin{frame}[noframenumbering]{Debugging frame}
			\begin{tabular}{r@{\ =\ }l}
				listings     & \rainbow@listings                           \\
				fonts/main   & \rainbow@fonts@main                         \\
				fonts/sans   & \rainbow@fonts@sans                         \\
				fonts/mono   & \rainbow@fonts@mono                         \\
				fonts/math   & \rainbow@fonts@math                         \\
				debug        & \ifrainbow@debug true \else false\fi        \\
				sectionpage  & \ifrainbow@sectionpage true \else false\fi  \\
				withappendix & \ifrainbow@withappendix true \else false\fi
			\end{tabular}
		\end{frame}
	}
\fi


\ifrainbow@withappendix%
	\RequirePackage{appendixnumberbeamer}%

	\let\rainbow@oldappendix\appendix%
	\renewcommand\appendix{%
		\rainbow@oldappendix%
		\renewcommand{\insertframenumber}{\Alph{framenumber}}%
		\renewcommand{\theframenumber}{\Alph{framenumber}}%
	}%
\else
	\def\appendix{\ClassError{rainbow}{Appendices not supported without the `withappendix' option}{Please add the `withappendix' option to the class}}
\fi


%% Section page
\newlength{\sectionprogressbarwd}

\ifrainbow@sectionpage
	\AtBeginSection{
		\begin{frame}[plain,noframenumbering]{}
			\IfInteger{\insertframenumber}{%
				\ifnum\insertframenumber0>0%
					\setlength{\sectionprogressbarwd}{\dimexpr(\linewidth*\insertframenumber/\inserttotalframenumber)}%
				\else%
					\setlength{\sectionprogressbarwd}{\dimexpr(\linewidth/\inserttotalframenumber)}%
				\fi%
			}{%
				\setlength{\sectionprogressbarwd}{\linewidth}%
			}
			\centering
			\begin{minipage}{0.6\paperwidth}
				\raggedright
				\usebeamerfont{section title}
				\insertsection\\[-1ex]%
				\tikz{%
					\clip (0, 0) rectangle (\sectionprogressbarwd, \progressbarht);
					\shade[shading=rainbow, shading angle=-90] (0, 0) rectangle (\linewidth, \progressbarht);
				}%
			\end{minipage}
		\end{frame}
	}
\fi



\let\beamer@oldauthor\author
\renewcommand\author[2][]{%
	\@ifpackageloaded{hyperref}{
		\pdfstringdefDisableCommands{%
			\let\speaker\relax%
		}
	}{}
	\@ifpackageloaded{ulem}{
		\let\speaker\uline%
	}{%
		\let\speaker\underline%
	}%
	\beamer@oldauthor[#1]{#2}%
}


%%% Some useful defaults
\institute{Université de Lorraine \and CNRS \and Inria \and LORIA}
\titlegraphic{%
	\includegraphics[height=8mm]{\rainbow@path assets/logo_ul}
	\and%
	\includegraphics[height=8mm]{\rainbow@path assets/logo_cnrs}
	\and%
	\includegraphics[height=8mm]{\rainbow@path assets/logo_inria}
	\and%
	\includegraphics[height=8mm]{\rainbow@path assets/logo_loria}
}
\date{\today}



% \let\beamer@oldframe\frame
% \let\endbeamer@oldframe\endframe


%%%% Various buttons

\newcommand*\rainbow@gotobutton[2]{\hyperlink{#1}{\beamergotobutton{#2}}}
\newcommand*\rainbow@returnbutton[2]{\hyperlink{#1}{\beamerreturnbutton{#2}}}
\newcommand*\rainbow@skipbutton[2]{\hyperlink{#1}{\beamerskipbutton{#2}}}
\newcommand*\button[1]{\beamerbutton{#1}}
\newcommand*\gotobutton{\@ifstar\beamergotobutton\rainbow@gotobutton}
\newcommand*\skipbutton{\@ifstar\beamerskipbutton\rainbow@skipbutton}
\newcommand*\returnbutton{\@ifstar\beamerreturnbutton\rainbow@returnbutton}