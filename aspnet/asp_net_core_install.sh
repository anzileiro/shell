#!/bin/sh

wellcome_to_aspnet(){
echo '                                                                 '
echo '   ___   _______    _  ____________  _____               ___ ___ '
echo '  / _ | / __/ _ \  / |/ / __/_  __/ / ___/__  _______   <  // _ \'
echo ' / __ |_\ \/ ___/ /    / _/  / /   / /__/ _ \/ __/ -_)  / // // /'
echo '/_/ |_/___/_/  (_)_/|_/___/ /_/    \___/\___/_/  \__/  /_(_)___/ '
echo '                                               A useful installer'
echo '                                                                 '

verify_packages
install_dnvm
install_dnx
install_libvu
}

verify_packages(){
	echo '>>>>> Verificando dependências...'
	sudo apt-get update && sudo apt-get install unzip curl
	echo 'Os Pacotes foram atualizados e dependências necessárias foram instaladas: (unzip e curl)'
}

install_dnvm(){
	echo '\n>>>>> Instalando DNVM...'
	sudo curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_BRANCH=dev sh && source ~/.dnx/dnvm/dnvm.sh
	echo 'O DNVM foi instalado'
}

install_dnx(){
	echo '\n>>>>> Instalando DNX...'
	sudo apt-get install libunwind8 gettext libssl-dev libcurl4-openssl-dev zlib1g libicu-dev uuid-dev
	dnvm upgrade -r coreclr
	echo 'O DNX foi instalado'
}

install_libvu(){
	echo '\n>>>>> Instalando dependência para o Kestrel...'
	sudo apt-get install make automake libtool curl
	curl -sSL https://github.com/libuv/libuv/archive/v1.8.0.tar.gz | sudo tar zxfv - -C /usr/local/src
	cd /usr/local/src/libuv-1.8.0
	sudo sh autogen.sh
	sudo ./configure
	sudo make
	sudo make install
	sudo rm -rf /usr/local/src/libuv-1.8.0 && cd ~/
	sudo ldconfig
	echo 'As Dependências para o Kestrel foram instaladas\n'
}

wellcome_to_aspnet