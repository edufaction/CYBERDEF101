
# -----------------------------------------------
# ===============================================
# 					CYBERDEF101
# 				Build All from sources
# Needs :
#	imagemagick
#	pdf2svg (Used by Tex4ht -> Html & Ebook)
#	ghoscript
#	TexLive
#	Pandoc (Md to Latex & Reveal/js)
# ===============================================
# -----------------------------------------------
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:
SUFFIXES:= 
%.tex:
%.acr:
%.eps:

IMG_DIRS := ./Tex/Pictures
TEX_DIRS := .
COMPILE_DIR := ./out
INSTALL_DIR := ../../Release/SEC101
SUBDIR_TEACHER := Teacher/Lessons
SUBDIR_STUDENT := Student/Lessons
MD_DIRS := ./Markdown
TEXFILES:= *
OPT_PngPdf:= YES


# TEX Sources  ======================================
Src_BookFile := $(shell find $(TEX_DIRS) -name '*.book.tex') # (VAR) Book MainPDF
Src_WebFile := $(shell find $(TEX_DIRS) -name '*.web.tex') # (VAR) WEB PDF & HTML
Src_PrzFiles := $(shell find $(TEX_DIRS) -name '*.prz.tex') # Tex Beamer Files 
Src_QuizzFiles := $(shell find $(TEX_DIRS) -name '*.qzz.tex') # TexQuizz Files 
Src_DocFiles := $(shell find $(TEX_DIRS) -name '*.doc.tex') # Tex Article Files
Src_CoursesFiles :=$(shell find $(TEX_DIRS) -name '*.course.tex') # Book PDF
Src_Lessons :=$(shell find $(TEX_DIRS) -name '*.course.tex') # Book PDF

# PDF Target  ======================================
PDF_PrzFiles :=$(subst $(TEX_DIRS)/,$(TEX_DIRS)/out/,$(subst .prz.tex,.prz.pdf,$(Src_PrzFiles)))
PDF_DocFiles :=$(subst $(TEX_DIRS)/,$(TEX_DIRS)/out/,$(subst .doc.tex,.doc.pdf,$(Src_DocFiles)))

TeacherPDF_PrzFiles:=$(subst $(TEX_DIRS)/out/,$(INSTALL_DIR)/$(SUBDIR_TEACHER)/Slides/,$(PDF_PrzFiles))
StudentPDF_PrzFiles :=$(subst $(TEX_DIRS)/out/,$(INSTALL_DIR)/$(SUBDIR_STUDENT)/,$(PDF_PrzFiles))
StudentPDF_DocFiles :=$(subst $(TEX_DIRS)/out/,$(INSTALL_DIR)/$(SUBDIR_STUDENT)/,$(PDF_DocFiles))

DIR_Lessons :=$(subst $(TEX_DIRS)/,$(TEX_DIRS)/out/,$(subst .prz.tex,.dir,$(Src_PrzFiles)))
# ===============================================
# RULES 
# ===============================================

$(info "--------PREZ------")
$(info SRC="$(Src_PrzFiles)")
$(info PDF="$(PDF_PrzFiles)")
$(info PDF="$(TeacherPDF_PrzFiles)") # PDF with new dimension 1600 x 900 pixels for PNG quality export
$(info "------DOC--------")
$(info SRC Doc="$(Src_DocFiles)")
$(info PDF Doc="$(PDF_DocFiles)")
$(info PDF Doc Release ="$(StudentPDF_DocFiles)") # PDF with new dimension 1600 x 900 pixels for PNG quality export

# ===============================================
# RULES 
# ===============================================

.PHONY: help

help: # Aide sur les commands disponibles
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done



# **********************************************************
# PREPARE DIR
# **********************************************************

release:
	mkdir -p  $(INSTALL_DIR)
	mkdir -p  $(INSTALL_DIR)/Teacher
	mkdir -p  $(INSTALL_DIR)/Student
	mkdir -p  $(INSTALL_DIR)/Student/Lessons
	mkdir -p  $(INSTALL_DIR)/Teacher/Lessons
	mkdir -p  $(INSTALL_DIR)/Teacher/Lessons/Quizz
	mkdir -p  $(INSTALL_DIR)/Teacher/Lessons/Audionotes
	mkdir -p  $(INSTALL_DIR)/Teacher/Lessons/Slides


# **********************************************************
# COMPILATION LESSONS
# **********************************************************
# ----------------------------------------------------------
#  PRZ rules
# ----------------------------------------------------------
all: release mkprz mkdoc

mkprz: $(TeacherPDF_PrzFiles) $(StudentPDF_PrzFiles)

$(TeacherPDF_PrzFiles): $(PDF_PrzFiles)
ifeq ($(OPT_PngPdf),YES)
	$(info PNG Dir create ="$@.images")
	mkdir -p  $@.images
	$(info "Expand PDF to 1600x000 px" of $<")
	gs -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=1600 -dDEVICEHEIGHTPOINTS=900 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 -o $@ $<
	$(info "Export PDF to PNG for video of $@")
	gs -dNOPAUSE -dBATCH -sDEVICE=png16m -r300 -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sOutputFile=$@.images/Pic-%d.png $<
endif

$(COMPILE_DIR)/%.prz.pdf: $(TEX_DIRS)/%.prz.tex	
	latexmk -output-directory=$(COMPILE_DIR) $<

$(StudentPDF_PrzFiles):	$(PDF_PrzFiles)	
	cp -rf "./$<" "$@"	

# ----------------------------------------------------------
#  DOC rules
# ----------------------------------------------------------

mkdoc: $(StudentPDF_DocFiles) 

$(StudentPDF_DocFiles): $(PDF_DocFiles) # copy if compiled
	cp -rf "./$<" "$@"

$(COMPILE_DIR)/%.doc.pdf: $(TEX_DIRS)/%.doc.tex	
	latexmk -output-directory=$(COMPILE_DIR) $<

# ----------------------------------------------------------
#  PRZ rules
# ----------------------------------------------------------

#mkprz: $(Src_PrzFiles)

# mkprz: # Make PRZ
# 	latexmk -output-directory=$(COMPILE_DIR) $(Src_PrzFiles).tex 
# mkdoc:
# 	latexmk -output-directory=$(COMPILE_DIR) $(Src_docFiles).tex 
# mkqzz:
# 	latexmk -output-directory=$(COMPILE_DIR) $(Src_qzzFiles).tex 


cleanout: # Purge de tous les fichiers OUT
	rm -f $(COMPILE_DIR)/*.*

clean: # Purge de tous les fichiers auxilaires Racine
	latexmk -c
	rm -f *.xml
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.bbl
	rm -f *.snm
	rm -f *.ptc 
	rm -f *.nav
	rm -f *.toc
	rm -f *.xref
	rm -f *.tmp
	rm -f *.ps
	rm -f *.pdf
	rm -f *.out
	rm -f *.dvi
	rm -f *.bcf
	rm -f *.4ct
	rm -f *.4tc 
	rm -f *.aux
	rm -f *.bbl
	rm -f *.nav
	rm -f *.snm
	rm -f *.out
	rm -f *.toc
	rm -f *.ptc
	rm -f *.xml
	rm -f *.log
	rm -f *.idv
	rm -f *.lg
	rm -f *.html
	rm -f *.svg

cleanmd: # Purge de tous les fichiers auxiliaires (HTML,TEX) dans /MarkDown
	rm -f $(MD_DIRS)/out/RJS/*.html
	rm -f $(MD_DIRS)/out/LTX/*.tex

cleanimg: # Purge de tous les fichiers auxiliaires dans /MarkDown
	rm -f $(IMG_DIRS)/*.png
	rm -f $(IMG_DIRS)/*.svg
	rm -f $(IMG_DIRS)/*.eps
	rm -f $(IMG_DIRS)/*.xbb 
	rm -f $(IMG_DIRS)/*.nav

install: # Installation dans Builder (PDF TEX et HTML TEX)
	cp $(COMPILE_DIR)/*.pdf $(INSTALL_DIR)