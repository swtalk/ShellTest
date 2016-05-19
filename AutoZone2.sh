############################
#  Park si woo (nBase-ARC) #
#     2015 - 06 - 11       #
############################
#!/bin/bash

#=========================================================
#                   Table of contents                    #	
#=========================================================
#=========================================================
# 1. Control screen                                      #
#=========================================================
#=========================================================
# 2. Dir Setting                                         #
#=========================================================
#=========================================================
# 3. Server list Input END                               #
#=========================================================
#=========================================================
# 4. PATH Setting                                        #
#=========================================================
#=========================================================
# 5. Zookeeper ensemble END                              #
#=========================================================
#=========================================================
# 6. Configuration Master                                #
#=========================================================
#=========================================================
# 7. Python install                                      #
#=========================================================
                                                                                            
echo "         #####                              #    #####    #####      #####  #####  ### ### ###### "
echo "          ## ##                            ###    ## ##  ##   #      #  ## ##   ##  ### #   ##  # "
echo " #####    ## ##  ###    ####  ###          ###    ## ##  ##            ##  ##   ##  ### #   ##    "
echo "  ## ##   ####  ## ##  ###   ## ##         # #    ####   ##           ###  ##   ##  # ###   ####  "
echo "  ## ##   ## ##  ####   ###  ##### #####  #####   ## ##  ##           ##   ##   ##  # ###   ##    "
echo "  ## ##   ## ## ## ##    ### ##           #  ##   ## ##  ##   #      ##  # ##   ##  #  ##   ##  # "
echo " ### ### #####   ##### ####   ####       ### ### #### ##  #####      #####  #####  ### ##  ###### "

#=========================================================
# 1. Server list Input                                   #
#=========================================================
echo "Input IP Address (mgmt-cc IP list)"
echo -en "Input Server.1 IP: "
read server1
echo -en "Input Server.2 IP: "
read server2
echo -en "Input Server.3 IP: "
read server3
echo "SERVER LIST INPUT COMPLETE"
#=========================================================
# 1. Server list Input END                               #
#=========================================================
#=========================================================
# 2. Control screen                                      #
#=========================================================
black="\x1b[30m"
red="\x1b[31m"
green="\x1b[32m"
yellow="\x1b[33m"
blue="\x1b[34m"
magenta="\x1b[35m"
cyan="\x1b[36m"
white="\x1b[37m"
reset="\x1b[39m"
version="1.2.1.1"
#=========================================================
# 2. Control screen END                                  #
#=========================================================
#=========================================================
# 3. Dir Setting					 #
#=========================================================
Dir_Setting() {
	echo "Setting dir nBase-ARC ZONE.."
	ssh irteam@$server2 "cd $HOME; wget http://infra-platform.nhncorp.com/swtalk/zone.sh; sh zone.sh"
	ssh irteam@$server3 "cd $HOME; wget http://infra-platform.nhncorp.com/swtalk/zone.sh; sh zone.sh"
	sleep 3
	mkdir nbase-arc
	cd nbase-arc
	mkdir mgmt
	cd mgmt
	wget http://infra-platform.nhncorp.com/swtalk/mgmt-1.2.1.tgz
	tar xvfz mgmt-1.2.1.tgz
	rm mgmt-1.2.1.tgz
	cd ..
	mkdir bin
	wget http://infra-platform.nhncorp.com/swtalk/script-1.2.0.7.tgz
	wget http://infra-platform.nhncorp.com/swtalk/batch_daemon.tar.gz
	tar xvfz script-1.2.0.7.tgz
	ln -s script-1.2.0.7e33610 script
	tar xvfz batch_daemon.tar.gz
	rm script-1.2.0.7.tgz
	rm batch_daemon.tar.gz
	cd /home1/irteam/nbase-arc/bin
	wget http://infra-platform.nhncorp.com/swtalk/nbase-arc-1.2.1.1.tar.gz #nBase-ARC 버전 바꿀것 
	tar xvfz nbase-arc-1.2.1.1.tar.gz	 #여기도 마찬가지임
	rm nbase-arc-1.2.1.1.tar.gz
	cd
	mkdir bin
	cd bin
	wget http://infra-platform.nhncorp.com/swtalk/jdk1.7.tar.gz
	wget http://infra-platform.nhncorp.com/swtalk/Python-2.7.6.tgz
	tar xvfz jdk1.7.tar.gz
	ln -s jdk1.7.0_25 java
	tar xvfz Python-2.7.6.tgz
	ln -s Python-2.7.6 Python
	rm jdk1.7.tar.gz
	rm Python-2.7.6.tgz
	wget http://infra-platform.nhncorp.com/swtalk/zookeeper-3.4.6.tar.gz
	tar xvfz zookeeper-3.4.6.tar.gz
	ln -s zookeeper-3.4.6 zookeeper
	rm zookeeper-3.4.6.tar.gz
	echo "BYE............"
	sleep 2
}
Dir_Setting
#=========================================================
# 3. Dir Setting END				 	 #
#=========================================================
#=========================================================
# 4. PATH Setting					 #
#=========================================================
#echo export NBASE_ARC_HOME=/home1/irteam/nbase-arc >> ~/.bashrc
#echo export PATH=$NBASE_ARC_HOME/bin:$NBASE_ARC_HOME/script:$PATH >> ~/.bashrc
#echo export PATH=/home1/irteam/bin:$PATH >> ~/.bashrc
#source ~/.bashrc
#echo export ZOOKEEPER_HOME=$HOME/bin/zookeeper-3.4.6 >> ~/.bash_profile
#echo export PATH=$ZOOKEEPER_HOME/bin:$PATH >> ~/.bash_profile
#source ~/.bash_profile
#ssh irteam@$server2 "echo export NBASE_ARC_HOME=/home1/irteam/nbase-arc >> ~/.bashrc; echo export PATH=$NBASE_ARC_HOME/bin:$NBASE_ARC_HOME/script:$PATH >> ~/.bashrc; echo export PATH=/home1/irteam/bin:$PATH >> ~/.bashrc; source ~/.bashrc; echo export ZOOKEEPER_HOME=$HOME/bin/zookeeper-3.4.6 >> ~/.bash_profile; echo export PATH=$ZOOKEEPER_HOME/bin:$PATH >> ~/.bash_profile; source ~/.bash_profile"
#ssh irteam@$server3 "echo export NBASE_ARC_HOME=/home1/irteam/nbase-arc >> ~/.bashrc; echo export PATH=$NBASE_ARC_HOME/bin:$NBASE_ARC_HOME/script:$PATH >> ~/.bashrc; echo export PATH=/home1/irteam/bin:$PATH >> ~/.bashrc; source ~/.bashrc; echo export ZOOKEEPER_HOME=$HOME/bin/zookeeper-3.4.6 >> ~/.bash_profile; echo export PATH=$ZOOKEEPER_HOME/bin:$PATH >> ~/.bash_profile; source ~/.bash_profile"

#=========================================================
# 4. PATH Setting END                                    #
#=========================================================
#=========================================================
# 5. Zookeeper ensemble					 #
#=========================================================
cd /home1/irteam/bin/zookeeper/conf
mv zoo_sample.cfg zoo.cfg
sed -i "s/\/tmp\/zookeeper/\/home1\/irteam\/bin\/zookeeper\/data/g" zoo.cfg
ssh irteam@$server2 "cd /home1/irteam/bin/zookeeper/conf; mv zoo_sample.cfg zoo.cfg; sed -i 's/\/tmp\/zookeeper/\/home1\/irteam\/bin\/zookeeper\/data/g' zoo.cfg; echo "server.1=$server1:2888:3888" >> zoo.cfg; echo "server.2=$server2:2888:3888" >> zoo.cfg; echo "server.3=$server3:2888:3888" >> zoo.cfg; "
ssh irteam@$server3 "cd /home1/irteam/bin/zookeeper/conf; mv zoo_sample.cfg zoo.cfg; sed -i 's/\/tmp\/zookeeper/\/home1\/irteam\/bin\/zookeeper\/data/g' zoo.cfg; echo "server.1=$server1:2888:3888" >> zoo.cfg; echo "server.2=$server2:2888:3888" >> zoo.cfg; echo "server.3=$server3:2888:3888" >> zoo.cfg; "

echo "server.1=$server1:2888:3888" >> zoo.cfg
echo "server.2=$server2:2888:3888" >> zoo.cfg
echo "server.3=$server3:2888:3888" >> zoo.cfg
mkdir $HOME/bin/zookeeper/data
cd $HOME/bin/zookeeper/data
echo "1" > myid
cd /home1/irteam/bin/zookeeper-3.4.6/bin
sh zkServer.sh start
ssh irteam@$server2 "mkdir $HOME/bin/zookeeper/data; cd $HOME/bin/zookeeper/data; echo "2" > myid; cd /home1/irteam/bin/zookeeper/bin; sh zkServer.sh start; "
ssh irteam@$server3 "mkdir $HOME/bin/zookeeper/data; cd $HOME/bin/zookeeper/data; echo "3" > myid; cd /home1/irteam/bin/zookeeper/bin; sh zkServer.sh start; "
#=========================================================
# 5. Zookeeper ensemble END                              #
#=========================================================
#=========================================================
# 6. Configuration Master                                #
#=========================================================
cd $NBASE_ARC_HOME/mgmt
sed -i "s/10.97.20.82/$server1/ " cc.properties
sed -i "s/10.97.20.84/$server2/ " cc.properties
sed -i "s/10.97.20.86/$server3/ " cc.properties
ssh irteam@$server2 "s/10.97.20.82/$server1/ " cc.properties
ssh irteam@$server2 "s/10.97.20.84/$server2/ " cc.properties
ssh irteam@$server2 "s/10.97.20.86/$server3/ " cc.properties
ssh irteam@$server3 "s/10.97.20.82/$server1/ " cc.properties
ssh irteam@$server3 "s/10.97.20.84/$server2/ " cc.properties
ssh irteam@$server3 "s/10.97.20.86/$server3/ " cc.properties
sh mgmt-cc-1.2.1.sh &>/dev/null &
ssh irteam@$server2 "cd $NBASE_ARC_HOME/mgmt; sed -i "s/server_ip=$server1/server_ip=$server2/" cc.properties "
ssh irteam@$server3 "cd $NBASE_ARC_HOME/mgmt; sed -i "s/server_ip=$server1/server_ip=$server3/" cc.properties "
ssh irteam@$server2 "cd /home1/irteam/nbase-arc/mgmt"
ssh irteam@$server3 "cd /home1/irteam/nbase-arc/mgmt"
ssh irteam@$server2 "sh mgmt-cc-1.2.1.sh &>/dev/null &"
ssh irteam@$server3 "sh mgmt-cc-1.2.1.sh &>/dev/null &"
#=========================================================
# 6. Configuration Master END                            #
#=========================================================
#=========================================================
# 7. Python install                                      #
#=========================================================
cd /home1/irteam/bin/Python
sed -i 's/#_ssl/_ssl/' /home1/irteam/bin/Python/Modules/Setup.dist
sed -i 's/#.*-DUSE_SSL/       -DUSE_SSL/' /home1/irteam/bin/Python/Modules/Setup.dist
sed -i 's/#.*-L$(SSL)/       -L$(SSL)/' /home1/irteam/bin/Python/Modules/Setup.dist
ssh irteam@$server2 "cd /home1/irteam/bin/Python; sed -i 's/#_ssl/_ssl/' /home1/irteam/bin/Python/Modules/Setup.dist; sed -i 's/#.*-DUSE_SSL/       -DUSE_SSL/' /home1/irteam/bin/Python/Modules/Setup.dist; sed -i 's/#.*-L\$(SSL)/       -L\$(SSL)/' /home1/irteam/bin/Python/Modules/Setup.dist; cd Python-2.7.6; ./configure --prefix=$HOME; make; make install"
ssh irteam@$server3 "cd /home1/irteam/bin/Python; sed -i 's/#_ssl/_ssl/' /home1/irteam/bin/Python/Modules/Setup.dist; sed -i 's/#.*-DUSE_SSL/       -DUSE_SSL/' /home1/irteam/bin/Python/Modules/Setup.dist; sed -i 's/#.*-L\$(SSL)/       -L\$(SSL)/' /home1/irteam/bin/Python/Modules/Setup.dist; cd Python-2.7.6; ./configure --prefix=$HOME; make; make install"

echo -en "${yellow}"
./configure -- prefix=$HOME
echo -en "${reset}"
echo "Build Start..."
sleep 2
echo -en "${cyan}"
make && make install
echo -en "${reset}"
sleep 1
wget --no-check-certificate https://raw.github.com/pypa/pip/master/contrib/get-pip.py
ssh irteam@$server2 "cd /home1/irteam/bin/Python; wget --no-check-certificate https://raw.github.com/pypa/pip/master/contrib/get-pip.py"
ssh irteam@$server3 "cd /home1/irteam/bin/Python; wget --no-check-certificate https://raw.github.com/pypa/pip/master/contrib/get-pip.py"

echo -en "${yellow}"
python get-pip.py
ssh irteam@$server2 "python get-pip.py"
ssh irteam@$server3 "python get-pip.py"
echo -en "${reset}"
echo "pip install complete & starting fabfic "
sleep 2
echo -en "${cyan}"
pip install fabric
ssh irteam@$server2 "pip install fabric"
ssh irteam@$server3 "pip install fabric"


echo -en "${reset}"
sleep 1
cd $NBASE_ARC_HOME/script/
sed -i "s/10.97.20.82/$server1/" config.py
sed -i "s/1.2.1/$version/" config.py #$NBASE_ARC_HOME/script/config.py IP & version setting
cd /home1/irteam/nbase-arc/batch_daemon
sed -i "s/10.113.186.44/$server1/" config.py #batch daemon IP setting
python batch_daemon.py &>/dev/null &
ssh irteam@$server2 "cd $NBASE_ARC_HOME/script/; sed -i "s/10.97.20.82/$server1/" config.py; sed -i "s/1.2.1/$version/" config.py; cd /home1/irteam/nbase-arc/batch_daemon; sed -i "s/10.113.186.44/$server2/" config.py"
ssh irteam@$server3 "cd $NBASE_ARC_HOME/script/; sed -i "s/10.97.20.82/$server1/" config.py; sed -i "s/1.2.1/$version/" config.py; cd /home1/irteam/nbase-arc/batch_daemon; sed -i "s/10.113.186.44/$server3/" config.py"
#=========================================================
# 7. Python install END                                  #
#=========================================================

echo "nBase-ARC ZONE Install Success!!" 
sleep 1


