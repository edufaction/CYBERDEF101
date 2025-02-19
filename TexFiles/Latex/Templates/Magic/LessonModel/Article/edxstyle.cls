% ---------------------------------------------------------------------
% Conference proceedings and article templates for
% personal open-archiving activities
% September 2012
% ---------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{edxstyle}[25/01/2012, v1.0] %edxstyle
\RequirePackage{ifthen}
\RequirePackage{calc}
\AtEndOfClass{\RequirePackage{microtype}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*
\LoadClass{article}
\RequirePackage{ifpdf}      % Needed to pick between latex and pdflatex

%----------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------

\RequirePackage{times}      % Loads the Times-Roman Fonts
\RequirePackage{mathptmx}   % Loads the Times-Roman Math Fonts

%----------------------------------------------------------------------
%	VARIOUS USEFUL PACKAGES
%----------------------------------------------------------------------

\RequirePackage[utf8]{inputenc}
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage{graphicx,xcolor}
%\RequirePackage[english]{babel}
\RequirePackage{booktabs}

%----------------------------------------------------------------------
%	MARGINS	
%----------------------------------------------------------------------
	  	  
\RequirePackage[left=2cm,%
                right=2cm,%
				top=2.25cm,%
				bottom=2.25cm,%
				headheight=11pt]{geometry}%
				
%----------------------------------------------------------------------
%	FIGURES AND TABLES CAPTIONS
%----------------------------------------------------------------------

\RequirePackage[labelfont={bf,sf,small},%
                labelsep=period,%
                justification=centering]{caption}
\setlength{\abovecaptionskip}{5pt}
\setlength{\belowcaptionskip}{5pt}
				
%----------------------------------------------------------------------
%	PAGE HEADER
%----------------------------------------------------------------------

%\RequirePackage{fancyhdr}  % Needed to define custom headers/footers
%\RequirePackage{lastpage}  % Number of pages in the document
%\pagestyle{fancy}          % Enables the custom headers/footers
%% Headers
%\lhead{}%
%\chead{}%
%\rhead{\small\sffamily\bfseries\@PaperTitle\  --- \thepage/\pageref{LastPage}}
%% Footers
%\lfoot{}%
%\cfoot{}%
%\rfoot{}%
%\renewcommand{\headrulewidth}{0pt}% % No header rule
%\renewcommand{\footrulewidth}{0pt}% % No footer rule

%----------------------------------------------------------------------
%	SECTION/SUBSECTION/PARAGRAPH SET-UP
%----------------------------------------------------------------------



\RequirePackage[explicit]{titlesec}

\titleformat{\section}
  {\color{uMainColor}\Large\sffamily\bfseries}
  {}
  {0em}
  {\colorbox{color2!30}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\centering\arabic{section}. #1}}}
  []
  
  
\titleformat{name=\section,numberless}
  {\color{uMainColor}\Large\sffamily\bfseries}
  {}
  {0em}
  {\colorbox{color2!20}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\centering#1}}}
  []  
  
  
\titleformat{\subsection}
  {\color{uMainColor}\sffamily\large\bfseries}
  {\thesubsection}
  {0.5em}
  {#1}
  []
\titleformat{\subsubsection}
  {\sffamily\normalsize\bfseries}
  {\thesubsubsection}
  {0.5em}
  {#1}
  []    
\titleformat{\paragraph}[runin]
  {\sffamily\small\bfseries}
  {}
  {0em}
  {#1} 
\titlespacing*{\section}{0pc}{1ex \@plus4pt \@minus3pt}{10pt}
\titlespacing*{\subsection}{0pc}{1ex \@plus3pt \@minus2pt}{10pt}
\titlespacing*{\subsubsection}{0pc}{1ex \@plus2.5pt \@minus1.5pt}{10pt}
\titlespacing*{\paragraph}{0pc}{1ex \@plus2pt \@minus1pt}{10pt}

%----------------------------------------------------------------------
%	TABLEOFCONTENTS SET-UP
%----------------------------------------------------------------------
\newlength{\tocsep} 
\setlength\tocsep{1.5pc} % Sets the indentation of the sections in the table of contents
\setcounter{tocdepth}{3} % Three levels in the table of contents section: sections, subsections and subsubsections

\usepackage{titletoc}
\contentsmargin{0cm}
\titlecontents{section}[\tocsep]
  {\addvspace{4pt}\small\bfseries\sffamily}
  {\contentslabel[\thecontentslabel]{\tocsep}}
  {}
  {\hfill\thecontentspage}
  []
\titlecontents{subsection}[\tocsep]
  {\addvspace{2pt}\sffamily}
  {\contentslabel[\thecontentslabel]{\tocsep}}
  {}
  {\ \titlerule*[.5pc]{.}\ \thecontentspage}
  []
\titlecontents*{subsubsection}[\tocsep]
  {\footnotesize\sffamily}
  {}
  {}
  {}
  [\ \textbullet\ ]  

%----------------------------------------------------------------------
%	MULTIPLE AUTHOR SET
%----------------------------------------------------------------------  
  
\newcount\@authcnt
\newcount\@tmpcnt\@tmpcnt\z@

\def\@affiliation{%
  \ifnum\@tmpcnt<\@authcnt
   \global\advance\@tmpcnt1
    \raggedright \csname @auth\romannumeral\the\@tmpcnt\endcsname\hfill\\%
   \let\next\@affiliation \vskip1pt
  \else
   \let\next\relax
  \fi
\next}
	 
\newcommand{\affiliation}[1]{%
    \global\advance\@authcnt1
    \expandafter\gdef\csname @auth\romannumeral\the\@authcnt\endcsname
    {#1}}

	
%----------------------------------------------------------------------
%	LIST CONTROL
%----------------------------------------------------------------------  

%\RequirePackage{enumitem}
%\setlist{nolistsep} % Uncomment to remove spacing between items in lists (itemize, itemize)

%-----------------------------------------------
%	ABSTRACT+AUTHOR FRAME
%-----------------------------------------------  
\newcommand{\PaperTitle}[1]{\def\@PaperTitle{#1}}
\newcommand{\Archive}[1]{\def\@Archive{#1}}
\newcommand{\Authors}[1]{\def\@Authors{#1}}
\newcommand{\JournalInfo}[1]{\def\@JournalInfo{#1}}
\newcommand{\Abstract}[1]{\def\@Abstract{#1}}
\newcommand{\Keywords}[1]{\def\@Keywords{#1}}

% ----------------------------------------------

\renewcommand{\@maketitle}{%
\onecolumn{%
\thispagestyle{empty}%
\vskip-36pt%
{\raggedleft\small\sffamily\bfseries\@JournalInfo\\\@Archive\par}%
\vskip20pt%
{\raggedright\color{uMainColor}\sffamily\bfseries\fontsize{20}{25}\selectfont \@PaperTitle\par}%
\vskip10pt%
{\raggedright\color{uMainColor}\sffamily\fontsize{12}{16}\selectfont  \@Authors\par}%
\vskip18pt%
\raggedright\fcolorbox{uMainColor}{white}{%
\parbox{\textwidth-2\fboxsep-2\fboxrule}{\centering%
\colorbox{color2!10}{%
\parbox{\textwidth-4\fboxsep-2\fboxrule}{%
\ifx\@Keywords\@empty%
\sffamily\textbf{\abstractname}\\ \rmfamily \@Abstract%
\else%
\faicon{arrow-circle-o-right} \sffamily\small\textbf{\abstractname}\\ \rmfamily \@Abstract\\[4pt]%
\faicon{arrow-circle-o-right} \sffamily\textbf{\keywordname}\\ \rmfamily \@Keywords%
\fi%
}%
}%
\vskip4pt%
\begingroup%
\raggedright\sffamily\small%
\footnotesize\@affiliation\par%
\endgroup%%
}%
}%
\vskip5pt%
}%]
}

%----------------------------------------------------------------------
%	REFERENCES
%----------------------------------------------------------------------  

% Remove brackets from numbering in List of References
\renewcommand{\@biblabel}[1]{\bfseries\color{uMainColor}\textsuperscript{[#1]}}
%\setlength{\bibitemsep}{0cm}
\let\oldbibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
\addcontentsline{toc}{section}{\refname}%
\oldbibliography{#1}%
\setlength\itemsep{0pt}}%