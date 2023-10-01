
# **********************************************************
#  
# ----------------------------------------------------------
#  < mdtex: > RULE
# ----------------------------------------------------------
mdtex: $(MDTEXF) # Construction des fichiers TEX a partir de MD (Test only)
	pandoc --template=Markdown/template/md2tex.template.tex -s Chapters/mdsec-intro-infosec.md -o Chapters/mdsec-intro.infosec.tex
# ----------------------------------------------------------
#  < mdreveal: > RULE
# ----------------------------------------------------------

$(MD_DIRS)/out/RJS/%.html: $(MD_DIRS)/Files/%.rjs.md
#	pandoc --standalone -t revealjs -s  $<  -o $@ -V revealjs-url=reveal.js  --include-in-header=$(MD_DIRS)/template/revealjsmd.css -V theme=blood 
	pandoc --standalone -t revealjs -s  $<  -o $@ -V revealjs-url=reveal.js  --template=$(MD_DIRS)/Templates/RJS/revealjs.template.html --include-in-header=$(MD_DIRS)/Templates/RJS/revealjsmd.css -V theme=orange 


#	pandoc --standalone -t html5 -s  $<  -o $@  --template=$(MD_DIRS)/template/revealjs.template.html

#	pandoc -t html5 --template=template-revealjs.html \
	--standalone --section-divs \
  --variable theme="beige" \
  --variable transition="linear" \
  slides.md -o slides.html


#	pandoc -t revealjs -s  $<  -o $@ -V revealjs-url=https://unpkg.com/reveal.js/ --include-in-header=$(MD_DIRS)/template/revealjsmd.css -V theme=blood
#--metadata title=Cyberdef101

mdreveal:  $(JSFiles) $(MD_DIRS)/Templates/RJS/revealjs.template.html # Construction des fichiers REVEAL JS a partir de MD (tous les md dans Markdown/Chapters)

#movebuilder: #Installation BUILDER pour publication GITHUB
#	cp -f ./*.pdf ./../Builder
#	cp -f out/*.pdf ./../Builder

../Builder/%.pdf: out/%.pdf #Installation BUILDER pour publication GITHUB	
	cp -f $< $@

# Clear *.html produced
mdrevealall :  cleanmd mdreveal
# ----------------------------------------------------------
#  < wedpdf: > RULE
# ----------------------------------------------------------
# use latexmkrc (implicit)
webpdf: pictures $(WebFile) # Construction des fichiers TEX de la racine "Sources"
	latexmk -output-directory=$(COMPILE_DIR)  $(TEXFILES).tex 

out/%.pdf:  # Construction des fichiers TEX de la racine "Sources"
	latexmk -pdf -output-directory=$(COMPILE_DIR)  $(TEXFILES).tex 

# -interaction : batchmode nonstopmode
#pdflatex="-interaction=batchmode -output-directory=$(COMPILE_DIR)"
#-pdf 

# Web (Tex4ht) --------------------------------------
web: pictures # Construction des images pour TEX to PDF
	make4ht -c edx.cfg -f html5 -d $(COMPILE_DIR)/html $(WEBF).tex "3,frames-fn";open $(COMPILE_DIR)/html/$(WEBF).html
#-c edx.cfg 

test: pictures
	make4ht -c edx.cfg -f html5 -d $(COMPILE_DIR)/html minitest.tex "3,frames-fn"

# PICTURES -----------------------------------------------
pictures: $(IMG_EPS) $(IMG_SVG) $(IMG_PNG) 

# (IMG_PNG) rule
$(IMG_DIRS)/%.png: $(IMG_DIRS)/%.pdf
	convert -density 96 $< $@
	ebb -x $<
# (IMG_EPS) rule
$(IMG_DIRS)/%.eps: $(IMG_DIRS)/%.pdf
	pdf2ps $< $@
# (IMG_SVG) rule
$(IMG_DIRS)/%.svg: $(IMG_DIRS)/%.pdf
	pdf2svg $< $@

