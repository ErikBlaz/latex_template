PAPER_NAME 	= Template

TMP_DIR 	= /tmp
IMAGES_DIR 	= ./images

IMAGES = $(IMAGES_DIR)/curvas_portada_color.png \
		 $(IMAGES_DIR)/curvas_portada2_color.png \
		 $(IMAGES_DIR)/curvas_portada3_color.png \
		 $(IMAGES_DIR)/curvas_portada4_color.png \
		 $(IMAGES_DIR)/curvas_portada5_color.png \
		 $(IMAGES_DIR)/curvas_portada6_color.png \
		 $(IMAGES_DIR)/logo_portada_color.png

all: main



# main: images
main: $(IMAGES)
	latexmk -pdf main.tex -outdir=$(TMP_DIR) -lualatex 
	# echo "makeglossaries -d $(TMP_DIR) $(PAPER_NAME)"
	# makeglossaries -d $(TMP_DIR) $(PAPER_NAME)
	# latexmk -pdf main.tex -outdir=$(TMP_DIR)  -lualatex 
	mv $(TMP_DIR)/main.pdf ./$(PAPER_NAME).pdf
	# open $(PAPER_NAME).pdf

FORCE: ;

.SECONDEXPANSION:

$(IMAGES): config.cfg
	./configure.py
	./change_color.py -f $(subst _color,,$@) -o $@


images: config.cfg
	./configure.py
	./change_color.py -f $(IMAGES_DIR)/curvas_portada.png -o $(IMAGES_DIR)/curvas_portada_color.png
	./change_color.py -f $(IMAGES_DIR)/curvas_portada2.png -o $(IMAGES_DIR)/curvas_portada_color2.png
	./change_color.py -f $(IMAGES_DIR)/logo_portada.png -o $(IMAGES_DIR)/logo_portada_color.png
	convert $(IMAGES_DIR)/logo_portada_color.png -resize 200x200 -gravity center -background "rgba(255,0,255,0)" -extent 200x200 $(IMAGES_DIR)/out.png

review:
	sed -i 's/iffalse/iftrue/g' $(PAPER_NAME).tex
	latexmk -pdf $(PAPER_NAME).tex -outdir=$(TMP_DIR)
	#sed -i 's/iftrue/iffalse/g' $(PAPER_NAME).tex
	mv $(TMP_DIR)/$(PAPER_NAME).pdf .

clean:
	rm -fv \
  $(TMP_DIR)/$(PAPER_NAME).aux \
  $(TMP_DIR)/$(PAPER_NAME).bbl \
  $(TMP_DIR)/$(PAPER_NAME).blg \
  $(TMP_DIR)/$(PAPER_NAME).fdb_latexmk \
  $(TMP_DIR)/$(PAPER_NAME).fls \
  $(TMP_DIR)/$(PAPER_NAME).log \
  $(TMP_DIR)/$(PAPER_NAME).out \
  $(TMP_DIR)/$(PAPER_NAME).* \
  $(PAPER_NAME).pdf \
  $(TMP_DIR)/comment.cut
	latexmk -c
	latexmk -C
	rm -f $(PAPER_NAME).pdf

