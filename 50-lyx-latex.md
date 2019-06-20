# Installing Lyx 

https://wiki.lyx.org/LyX/LyXOnUbuntu#toc3

Installing
If you already have a repository version of LyX installed, you will have to remove it:
```
sudo apt-get remove lyx # (remove your repository version)
sudo apt-get autoremove # (remove repository dependencies)
```
If you don't do this, the fourth step that follows may fail.

Do the following:
```
sudo add-apt-repository ppa:lyx-devel/release # (add the PPA for the 'release', i.e. stable, compilation)
sudo apt-get update # (update so that apt is aware of the new PPA)
sudo apt-get install lyx # (install from the PPA)
lyx # (run LyX)
```

# Installing LaTeX
