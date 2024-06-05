mkdir scheme
cd scheme && touch simplyscm
# copy the code from here https://people.eecs.berkeley.edu/~bh/ssch27/appendix-simply.html into the file created in the previous step
install docker
sudo docker pull stklos/stklos:latest
sudo docker run -v $(pwd):/home -it stklos/stklos:latest
stklos>(load "61A/simplyscm")