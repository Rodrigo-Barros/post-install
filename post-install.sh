# create a restore point before start
echo "atualizando os servidores remotos ..."
sudo apt update

sudo cat apt/detect > /etc/apt/detect-http-proxy
sudo cat apt/30detectproxy > /etc/apt/apt.conf.d/30detectproxy

sudo apt install timeshift
if [[ $? -ne 0 ]]; then
	echo "não foi possível instalar o timeshift, saindo do script..."
fi
echo "iniciando o timeshift crie um ponto de restaução antes do script iniciar"

sudo timeshift-gtk

sudo echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" > /etc/apt/sources.list.d/mono-official-stable.list
sudo echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

# mono repo
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list

# dev-tools section
sudo apt install apache2 php7.2 php7.2-curl php7.2-cli php7.2-common php7.2-intl php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-xml code mysql-server mono-devel mono-xsp4

wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage -O $HOME/.local/bin/nvim && chmod +x $HOME/.local/bin/nvim

# create custom folders
mkdir $HOME/.web
rm -r /var/www/html
sudo ln -s /var/www/html $HOME/.web

