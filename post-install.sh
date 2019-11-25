#make
mkdir /tmp/post-install
mkdir -p $HOME/.local/bin
#Search packages on local server before look at internet helps to reduce bandwidth usage
sudo cp apt/detect  /etc/apt/detect-http-proxy
sudo chmod +x /etc/apt/detect-http-proxy
sudo cp apt/30detectproxy  /etc/apt/apt.conf.d/30detectproxy

#Monodevelop
sudo apt install apt-transport-https dirmngr
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list

sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list

echo "atualizando os servidores remotos ..."

sudo apt update
# create a restore point before start
sudo apt install timeshift -y

sudo timeshift-gtk
if [ $? -ne 0 ]; then
	echo "não foi possível instalar o timeshift, saindo do script..."
	exit
fi

# packages section
develpoment='apache2 php7.2 php7.2-curl php7.2-cli php7.2-common php7.2-intl php7.2-json php7.2-mbstring php7.2-mysql
	php7.2-opcache php7.2-readline php7.2-xml mysql-server mono-devel mono-xsp4 monodevelop git'
other='steam-installer zsh todotxt-cli remind xsel conky'

sudo apt install $develpoment $other -y

wget -c https://az764295.vo.msecnd.net/stable/8795a9889db74563ddd43eb0a897a2384129a619/code_1.40.1-1573664190_amd64.deb -O $HOME/Downloads/visual-code.deb
sudo dpkg -i $HOME/Downloads/visual-code.deb

git clone https://github.com/Rodrigo-Barros/dotfiles /tmp/post-install/dotfiles

#oh-my-zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cp /tmp/post-install/dotfiles/.zshrc $HOME/.zshrc

# faster node virtual machine manager fnm
curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash
#nvim
wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage -O $HOME/.local/bin/nvim && chmod +x $HOME/.local/bin/nvim

# recover dotfiles
cp -r /tmp/post-install/dotfiles/nvim $HOME/.config/
cp -r /tmp/post-install/dotfiles/prettier $HOME/.config/
cp -r /tmp/post-install/dotfiles/conky $HOME/.config/conky
cp -r /tmp/post-install/dotfiles/todo-txt $HOME/.config/todo-txt

# apache setting
mkdir $HOME/.web
sudo rm -r /var/www/html
sudo ln -s $HOME/.web /var/www/html
