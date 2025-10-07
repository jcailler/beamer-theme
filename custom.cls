\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custom}

\RequirePackage{kvoptions}
\RequirePackage{listofitems}
\RequirePackage[abspath]{currfile}
\RequirePackage{xstring}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{tikz}

\begingroup
    \getabspath{custom.cls}%
    \xdef\custom@path{\theabsdir}%
\endgroup

%%% Options

\SetupKeyvalOptions{
    family=custom,
    prefix=custom@
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imports the package `listings`, and include a
% default style for the listings.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareStringOption{listings}[]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not load the default fonts. Instead, you 
% should specify your own using `\setmainfont`, 
% `\setsansfont` and `\setmonofont`.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareBoolOption[false]{nofonts}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debugging option, please do not use.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareBoolOption[false]{debug}
% Give other options to beamer, but remove some
\DisableKeyvalOption[action=error, class=custom]{custom}{aspectratio}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessKeyvalOptions{custom}

%% Load class

\LoadClass[aspectratio=169, utf8, english]{beamer}


\mode<presentation>
\usetheme{custom}
\mode<all>


%% Setup listings, if required

\IfStrEq{\custom@listings}{\@empty}{}{%
    \RequirePackage{listingscustom}
}

% Insert our title frame at the very beginning of the document
\AtBeginDocument{\begin{frame}[plain,noframenumbering]\maketitle\end{frame}}
% When debugging, insert a special frame right after
\ifcustom@debug
\AtBeginDocument{%
    \section{Debugging frame}
    \begin{sframe}
        \begin{tabular}{r@{\ =\ }l}
            listings & \custom@listings \\
            nofonts & \ifcustom@nofonts true \else false\fi \\ 
            debug & \ifcustom@debug true \else false\fi
        \end{tabular}
    \end{sframe}
}
\fi


\let\beamer@oldauthor\author
\renewcommand\author[2][]{%
    \let\speaker\underline%
    \beamer@oldauthor[#1]{#2}%
}


% \let\beamer@oldframe\frame
% \let\endbeamer@oldframe\endframe

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