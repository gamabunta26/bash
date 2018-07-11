clear

#argument : fichier list de depot
var_serveur_list=$1

echo
echo "======================================================================================"
cat $var_serveur_list  | grep -v "^##" | column -t -s ":"
echo "======================================================================================"

# Saisie User
echo -en 'Numero de la connexion: '
read var_user_input

#Chargement des variables depuis le fichier
var_serveur_user=$(cat .connexion.list | grep $var_user_input | cut -d":" -f 2)
var_serveur_serveur=$(cat .connexion.list | grep $var_user_input | cut -d":" -f 3 )

# echo user : $var_serveur_user
# echo serveur : $var_serveur_serveur

# lancement connexion
case $var_user_input in
	# Ajout la cle pub sur le serveur
	000 ) echo -en 'Entrez le user et serveur user@serveur : ';read var_user_serveur;ssh-copy-id -i ~/.ssh/id_rsa.pub  ${var_user_serveur};break;;

	# Connexion SSH
	* ) ssh ${var_serveur_user}@${var_serveur_serveur};break;;

	# Exit
	999 ) break;;
esac

