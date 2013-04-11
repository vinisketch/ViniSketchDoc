##############################################################
##                    COPYRIGHT NOTICE
##
## Copyright (C) 2009-2013. ViniSketch (c) All rights reserved
##
## THIS SOURCE CODE, ALL THE INTELLECTUAL PROPERTY RIGHTS THAT IT
## CONTAINS, AND ALL COPYRIGHTS PERTAINING THERETO ARE THE EXCLUSIVE
## PROPERTY OF VINISKETCH.
##
## THIS SOURCE CODE SHALL NOT BE DISTRIBUTED, COPIED OR REPRODUCED IN
## FULL OR IN PART, NOR SHALL DERIVATIVE WORKS BE CREATED BASED ON THIS
## SOURCE CODE OR THE RELATED SPECIFICATION.
##
## THIS SOURCE CODE MAY BE USED OR COMPILED SOLELY FOR THE PURPOSE OF
## PORTING THE PRODUCT ONTO VENDOR'S SOLUTION. THIS SOURCE
## CODE MAY NOT BE MODIFIED, EVEN PARTIALLY.
##
## THE PRESENT COPYRIGHT NOTICE MAY NOT BE CHANGED NOR REMOVED FROM THE
## PRESENT FILE.
##############################################################

###                     Declaration
##############################################################

SHELL = /bin/sh
CHMOD = chmod
CP = cp
XTEMP = ./manage_template.sh
MV = mv
CD = cd
NOOP = $(SHELL) -c true
RM_F = rm -f
RM_RF = rm -rf
SYNC = rsync -pvtrlL --exclude=.svn/
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = mkdir -p
CAT = cat
MAKE = make
OPEN = open
ECHO = echo
ECHO_N = echo -n
JAVA = java
ASCIIDOC = /usr/local/bin/asciidoc -f conf/layout.conf
ASCIIDOC_BIS = /usr/local/bin/asciidoc -f conf/layoutBis.conf
COMPILE = $(JAVA) -jar lib/closurecompiler/compiler.jar --language_in=ECMASCRIPT5
COMPILE_ADV = $(JAVA) -jar lib/closurecompiler/compiler.jar --language_in=ECMASCRIPT5 --compilation_level ADVANCED_OPTIMIZATIONS
COMPILE_YUI = $(JAVA) -cp lib/yuicompressor/jargs-1.0.jar:lib/yuicompressor/rhino-1.6R7.jar -jar lib/yuicompressor/yuicompressor-2.4.2.jar
GENDOC = $(JAVA) -jar lib/jsdoc-toolkit/jsrun.jar lib/jsdoc-toolkit/app/run.js
SMARTCSS = lib/smartsprites-0.2.8/smartsprites.sh --css-files

RSYNC = rsync -pvtrlL --exclude=.svn/

HTML_HEAD = "src/assets/header.html"
HTML_FOOTER = "src/assets/footer.html"

all :: clean main_docs

clean ::
	-$(RM_RF) out
	-$(MKPATH) out

DATA_API_B2 = "<p>L'API de la toolkit de VSD...</p>"

DATA_ANIMATIONS = "<p>L’API d’animation de VSD vous permet de créer simplement des transitions douces lors d’un changement d’état d’un objet graphique ou encore de créer des IHMs composées d’effets graphiques avancés (un fond animées, …)…</p>"

DATA_ANIMATIONS = "<p>L’API d’animation de VSD vous permet de créer simplement des transitions douces lors d’un changement d’état d’un objet graphique ou encore de créer des IHMs composées d’effets graphiques avancés (un fond animées, …)…</p>"

DATA_CONTROLLERS = "<p>Les Controller de VSD vous proposent un mécanisme générique pour gérer la navigation au sein d’un ensemble de vues graphiques et les états de votre application. Ils s’appuient sur le système de FSM (Final State Machine) pour décrire des états et les transitions entre ces états, et vous permettent d’associer une vue à chaque état, et des animations pour les transitions entre états…</p>"

DATA_BINDINGS = "<p>La programmation par événements, est un principe d’architecture logicielle vous permettant de définir des actions qui serons exécutées non pas séquentiellement comme en programmation séquentielle, mais en réaction d’un événement se produisant dans votre application (typiquement en réaction d’un click de la souris). Il s’agit donc d’un concept très important en programmation d’interface homme machine, puisque votre application devra réagir aux actions de l’utilisateur, i.e. réagir à des évènements…</p>"

PROGRAMMING_PRINCIPLES = "<p>This chapter explains how to create components in order to assemble elements, structure your application, or make reusable widgets…</p>"

DESIGN_PATTERNS = "<p>In this chapter, you learn about the main design patterns you wille use in VS Application…</p>"

DATA_DATAFLOW = "<p>Le dataflow est un mode de programmation pour lequel un programme est représenté sous la forme d'un graphe; les noeuds du graphe représentant les composants du programme (widgets, …) et les arcs représentant le chemin de circulation des données entre les composants…</p>"

DATA_MEMORY= "<p>La mémoire peut être un facteur rapidement limitant de votre application en particulier si vous gérez des images. Ce document donne des astuces et recommandations…</p>"

DATA_MULTI_TARGET= "<p>XXX…</p>"

main_docs: userguide
	$(CP) src/assets/*.css out/
	$(CP) src/assets/*.js out/
	$(CP) src/assets/*.png out/
	$(CP) src/assets/index.html out/
	$(MKPATH) out/guidelines
	$(CP) src/guidelines/tree.html out/guidelines
	$(RSYNC) src/tutorial out/
	$(CAT) ${HTML_HEAD} > out/main.html
	$(ECHO) "<div class=\"docTitle\"></div>" >> out/main.html
	$(ECHO) "<a href=\"api_b2/index.html\">API Beta 2</a>" >> out/main.html
	$(ECHO) $(DATA_API_B2) >> out/main.html
	$(ECHO) "<a href=\"tutorial/index.html\">API Beta 2</a>" >> out/main.html
	$(ECHO) $(DATA_API_B2) >> out/main.html
#	$(MKPATH) out/guidelines/programmingPrinciples
#	$(ASCIIDOC) docs/programmingPrinciples/programmingPrinciples.asc
#	$(MV) docs/programmingPrinciples/programmingPrinciples.html out/guidelines/programmingPrinciples
#	$(ECHO) "<a href=\"guidelines/programmingPrinciples/programmingPrinciples.html\">Programming Principles</a>" >> out/main.html
#	$(ECHO) $(PROGRAMMING_PRINCIPLES) >> out/main.html
	$(MKPATH) out/guidelines/designPatterns
	$(ASCIIDOC) src/guidelines/designPatterns/designPatterns.asc
	$(MV) src/guidelines/designPatterns/designPatterns.html out/guidelines/designPatterns
	$(ECHO) "<a href=\"guidelines/designPatterns/designPatterns.html\">Design Patterns</a>" >> out/main.html
	$(ECHO) $(DESIGN_PATTERNS) >> out/main.html
	$(MKPATH) out/guidelines/animations
	$(ASCIIDOC) src/guidelines/animations/animations.asc
	$(MV) src/guidelines/animations/animations.html out/guidelines/animations
	$(RSYNC) src/guidelines/animations/data out/guidelines/animations
	$(ECHO) "<a href=\"guidelines/animations/animations.html\">Animations</a>" >> out/main.html
	$(ECHO) $(DATA_ANIMATIONS) >> out/main.html
	$(MKPATH) out/guidelines/controllers
	$(ASCIIDOC) src/guidelines/controllers/controllers.asc
	$(MV) src/guidelines/controllers/controllers.html out/guidelines/controllers
	$(ECHO) "<a href=\"guidelines/controllers/controllers.html\">Controllers</a>" >> out/main.html
	$(ECHO) $(DATA_CONTROLLERS) >> out/main.html
	$(RSYNC) src/guidelines/controllers/data out/guidelines/controllers
	$(MKPATH) out/guidelines/bindings
	$(ASCIIDOC) src/guidelines/bindings/bindings.asc
	$(MV) src/guidelines/bindings/bindings.html out/guidelines/bindings
	$(ECHO) "<a href=\"guidelines/bindings/bindings.html\">Bindings</a>" >> out/main.html
	$(ECHO) $(DATA_BINDINGS) >> out/main.html
	$(RSYNC) src/guidelines/bindings/data out/guidelines/bindings
	$(MKPATH) out/guidelines/dataflow
	$(ASCIIDOC) src/guidelines/dataflow/dataflow.asc
	$(MV) src/guidelines/dataflow/dataflow.html out/guidelines/dataflow
	$(ECHO) "<a href=\"guidelines/dataflow/dataflow.html\">Dataflow</a>" >> out/main.html
	$(ECHO) $(DATA_DATAFLOW) >> out/main.html
	$(RSYNC) src/guidelines/dataflow/data out/guidelines/dataflow
	$(MKPATH) out/guidelines/memory
	$(ASCIIDOC) src/guidelines/memory/memory.asc
	$(MV) src/guidelines/memory/memory.html out/guidelines/memory
	$(ECHO) "<a href=\"guidelines/memory/memory.html\">Gestion de la mémoire</a>" >> out/main.html
	$(ECHO) $(DATA_MEMORY) >> out/main.html
	$(MKPATH) out/guidelines/multitarget
	$(ASCIIDOC) src/guidelines/multitarget/multitarget.asc
	$(MV) src/guidelines/multitarget/multitarget.html out/guidelines/multitarget
	$(ECHO) "<a href=\"guidelines/multitarget/multitarget.html\">Gestion du multicible</a>" >> out/main.html
	$(ECHO) $(DATA_MULTI_TARGET) >> out/main.html
	$(CAT) ${HTML_FOOTER} >> out/main.html

userguide:
	$(MKPATH) out/userguide_ja
	$(CP) src/userguide_ja/tree.html out/userguide_ja
	$(ASCIIDOC_BIS) src/userguide_ja/ug_ch1.ja.asc
	$(MV) src/userguide_ja/ug_ch1.ja.html out/userguide_ja
	$(ASCIIDOC_BIS) src/userguide_ja/ug_ch2.ja.asc
	$(MV) src/userguide_ja/ug_ch2.ja.html out/userguide_ja
	$(ASCIIDOC_BIS) src/userguide_ja/ug_ch3.ja.asc
	$(MV) src/userguide_ja/ug_ch3.ja.html out/userguide_ja
	$(ASCIIDOC_BIS) src/userguide_ja/ug_ch4.ja.asc
	$(MV) src/userguide_ja/ug_ch4.ja.html out/userguide_ja
	$(ASCIIDOC_BIS) src/userguide_ja/ug_ch5_1.ja.asc
	$(MV) src/userguide_ja/ug_ch5_1.ja.html out/userguide_ja
	$(ASCIIDOC_BIS) src/userguide_ja/ug_ch5_2.ja.asc
	$(MV) src/userguide_ja/ug_ch5_2.ja.html out/userguide_ja
	$(ASCIIDOC_BIS) src/userguide_ja/ug_ch5_3.ja.asc
	$(MV) src/userguide_ja/ug_ch5_3.ja.html out/userguide_ja
	$(RSYNC) src/userguide_ja/images out/userguide_ja
	$(MKPATH) out/userguide_ja/phonegap
	$(ASCIIDOC) src/userguide_ja/phonegap/exp_android.ja.asc
	$(MV) src/userguide_ja/phonegap/exp_android.ja.html out/userguide_ja/phonegap
	$(ASCIIDOC) src/userguide_ja/phonegap/exp_ios.ja.asc
	$(MV) src/userguide_ja/phonegap/exp_ios.ja.html out/userguide_ja/phonegap