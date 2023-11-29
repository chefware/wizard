#/bin/bash
clear
sleep 2
echo "
                                        
        MMMMMMMMMM                      
                    mm                  
                      mm                
                        mm      ++++    
  MM    MM  mm          mm              
        MM  mm                          
    MM    mmmmmmmmmm                    
      mm  mm                        ++  
          mm            ++  ++    ++    
          mm                            
          mm  mm++++++++++              
          mm                            
            ++++++++++++++"
echo "
   ____   _   _   _____   _____  __        __     _      ____    _____ 
  / ___| | | | | | ____| |  ___| \ \      / /    / \    |  _ \  | ____|
 | |     | |_| | |  _|   | |_     \ \ /\ / /    / _ \   | |_) | |  _|  
 | |___  |  _  | | |___  |  _|     \ V  V /    / ___ \  |  _ <  | |___ 
  \____| |_| |_| |_____| |_|        \_/\_/    /_/   \_\ |_| \_\ |_____|
                                                                       
																	   "
																	   
sleep 3
echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7)Aguarde um momento enquanto verificamos se você possui Java instalado na sua máquina :)"
sleep 2

java -version

if [ $? -eq 0 ]
	then
		echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Parece que está tudo certo com o seu Java"
		sleep 2
	else
		echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7)Parece que não há nenhuma versão de Java instalada na máquina"
		sleep 2 
		echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Gostaria de intstalar o Java? (y/n)"
		read escolha
		if [ \"$escolha\" == \"y\" ]
			then
				echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Fico feliz que optou por instalar o Java, irei atualizar os pacotes, aguarde um instante..."
				sleep 2
				
				sudo apt update -y
				clear
				
				echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Instalando Java..."
				sleep 2
			
				sudo apt-get install openjdk-17-jre -y
				clear
				
				echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Java instalado com sucesso."
				sleep 1
		else
			echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Infelizmente nosso sistema precisa de Java para rodar, mas se mudar de ideia, só me executar novamente ;)"
		fi		
fi


echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Digite o token de acesso que enviamos no seu e-mail"
read token

echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7) Aguarde um momento enquanto baixamos o sistema Chefware na sua máquina :)"
sleep 2

git clone https://$token:x-oauth-basic@github.com/chefware/chefware-jar.git

clear
echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7)Irei configurar o seu banco de dados, aguarde um instante"
sleep 2

sudo docker --version

if [ $? != 0 ]
	then
		sudo apt install docker.io
		sudo systemctl enable docker
fi

cd chefware-jar/container && sudo docker build -t chefware-banco .

sudo docker run -d --name container-banco -p 3306:3306 chefware-banco
sleep 2
sudo docker start container-banco
clear
sleep 2
echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7)Tudo pronto, deseja rodar nosso programa agora? (y/n)"

read escolha1
echo "$(tput setaf 4)[Wizard Chefware]: $(tput setaf 7)Nós da Chefware agradecemos a sua preferência :)"
sleep 2

if [ \"$escolha1\" == \"y\" ]
	then
		cd ../ChefwareLooca && chmod +x chefware-1.0.0.jar
		java -jar chefware-1.0.0.jar

fi

#alias executavel_chefware='sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT && sudo iptables -nL |grep 8080 && cd /home/urubu100/chefware-jar/ChefwareLooca && java -jar chefware-0.0.1-SNAPSHOT.jar'
