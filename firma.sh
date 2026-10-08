#!/bin/bash
# richtet Rechner für Nordlicht GmbH ein (Tag14 Aufgabe1)
# Author marvin
# Start: sudo ./firma.sh

# --- aktualisierung Pakete ---

echo "1. Pakete"
apt update && apt upgrade -y
sleep 2

# --- neue Pakete ---

echo "2. Installiere git, htop und curl"
apt install -y git htop curl
sleep 2

# --- Benutzer ---

echo "3. Benutzer anlegen"
useradd -m -s /bin/bash timo
useradd -m -s /bin/bash lena
useradd -s /bin/bash mika
sleep 2

# --- Passwörter ---

echo "4. Passwörter vergeben"
echo "lena:Start123" | chpasswd
echo "timo:Start123" | chpasswd
echo "mika:Start123" | chpasswd
sleep 2

# --- Gruppen ---

echo "5. Gruppen erstellen"
groupadd devteam
groupadd office
sleep 2

echo "6. Gruppen zuweisen"
usermod -aG devteam lena
usermod -aG devteam timo 
usermod -aG office mika
usermod -aG sudo lena
sleep 2

# --- Ordner ---

echo "7. ordner Anlegen und Grupen zuweisen"

mkdir -p /home/lena/Projekte
mkdir -p /home/lena/Backup
mkdir -p /home/lena/Temp
mkdir -p /home/lena/Credentials
chown "lena:devteam" /home/lena/Projekte
chown "lena:devteam" /home/lena/Backup
chown "lena:devteam" /home/lena/Temp
chown "lena:devteam" /home/lena/Credentials

mkdir -p /home/timo/Projekte
chown "timo:office" /home/timo/Projekte
chmod 770 /home/timo/Projekte

mkdir -p /srv/temp
chown "mika:devteam" /srv/temp
chmod 770 /home/timo/Projekte

sleep 2

# --- Testdateien ---

echo "lena: Start123" > /home/lena/Credentials/lena.txt
echo "timo: Start123" > /home/lena/Credentials/timo.txt
echo "mika: Start123" > /home/lena/Credentials/mika.txt

chown "lena:devteam" /home/lena/Credentials/lena.txt
chown "lena:devteam" /home/lena/Credentials/timo.txt
chown "lena:devteam" /home/lena/Credentials/mika.txt

chmod 600 /home/lena/Credentials/lena.txt
chmod 600 /home/lena/Credentials/timo.txt
chmod 600 /home/lena/Credentials/mika.txt

sleep 2

echo "Teil 1 Fertig"
sleep 2

# Teil 2 (Tag14 Aufgabe2)

# --- .bashrc von lena ---

echo "1. Alias update_sys wird hinzugefügt"
echo 'alias update_sys="sudo apt update && sudo apt upgrade -y"' >> /home/lena/.bashrc
sleep 2

echo "2. Permanente variable COMPANY_NAME"
echo 'COMPANY_NAME="Nordlicht GmbH"' >> /home/lena/.bashrc
sleep 2

echo "3. .bashrc besitz an lena"
chown "lena" /home/lena/.bashrc
sleep 2

# --- Cronjobs ---

echo "4. Cronjob Backup für lena"
echo '0 0 * * 7 cp -r /home/lena/Projekte /home/lena/Backup/$(date +\%Y-\%m-\%d)' > /home/lena/lenact.txt
crontab -u lena /home/lena/lenact.txt
sleep 2

echo "5. Cronjob zeitlog für timo"
echo '*/20 * * * * $(date +\%Y-\%m-\%d) > /home/timo/.zeitlog' > /home/timo/timoct.txt
crontab -u timo /home/timo/timoct.txt
sleep 2

echo "6. Cronjob temp leeren für mika"
echo '0 */8 * * * rm -r /srv/temp/*' > /home/mikact.txt 
crontab -u mika /home/mikact.txt
sleep 2

echo "7. Cronjob Kontrolle"
echo "lenas Cronjobs : "
crontab -u lena -l
echo "timos Cronjobs : "
crontab -u timo -l
echo "mikas Cronjobs : "
crontab -u mika -l
sleep 2

#--- Abschluss ---

echo "Teil 2 Fertig."
sleep 2

echo "initiiere Neustart in :"
sleep 1
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
reboot

