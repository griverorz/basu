VERSION = "patch"

version:
	git checkout master
	git pull origin master
	bumpversion $(VERSION)
	git push origin master --tags
	-rm *.tar.gz
	Rscript -e 'devtools::document("./basu")'
	Rscript -e 'devtools::build("./basu")'

install:
	-rm *.tar.gz
	Rscript -e 'devtools::document("./basu")'
	Rscript -e 'devtools::build("./basu")'
	Rscript -e 'devtools::install("./basu")'

docker:
	docker build -t basu .
	docker run -p 5656:5656 basu
