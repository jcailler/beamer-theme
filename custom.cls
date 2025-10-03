\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custom}

\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{tikz}

\newif\ifwith@listings
\with@listingsfalse

\DeclareOption{listings}{\with@listingstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\LoadClass[aspectratio=169, utf8, english]{beamer}

\mode<presentation>
\usetheme{custom}
\mode<all>

\ifwith@listings%
    \RequirePackage{listingscustom}
\fi

% Insert our title frame at the very beginning of the document
\AtBeginDocument{\begin{frame}[plain,noframenumbering]\maketitle\end{frame}}


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