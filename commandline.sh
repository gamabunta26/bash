# Recherche un parametre dans des fichiers de configuration
find . -type f -name "*.xml" -exec grep -Hin stash {} --color=auto \; -o -name "*.sh" -exec grep -Hin stash {} --color=auto \; 

# lister et trier tous les fichiers de plus de 100 M dans une arborescence
for i in `find . -type f -size +100000000c -exec du -m {} \; 2>/dev/null | sort -rn  | cut -f2`; do du -h $i; done


# parcourir un ldap
var_server_list=$1

for i in `cat $var_server_list`
do
        var_user_test=$i
        nb=`ldapsearch -x -H ldap://server:port -D "uid=adm_ldap, ou=Directory Administrators, o=aspi.fr" -b "o=aspi.fr" -w pwd_adm_ldap "(&(uid=$var_user_test)(adlogon=*exp*))" uid | grep -vE "#|search|result|^$" | wc -l`

        if [ $nb != 0 ]
        then
                # uid EndValidateDate adlogon cn mail
                var_EndValidateDate=`ldapsearch -x -H ldap://server:port -D "uid=adm_ldap, ou=Directory Administrators, o=aspi.fr" -b "o=aspi.fr" -w pwd_adm_ldap "(&(uid=$var_user_test)(adlogon=*exp*))" EndValidateDate | grep EndValidateDate | grep -vE "#|search|result|^$" | cut -d" " -f2`
                var_cn=`ldapsearch -x -H ldap://server:port -D "uid=adm_ldap, ou=Directory Administrators, o=aspi.fr" -b "o=aspi.fr" -w pwd_adm_ldap "(&(uid=$var_user_test)(adlogon=*exp*))" cn | grep cn | grep -vE "#|search|result|^$" | cut -d" " -f2-`
#               echo -e "User $var_user_test \t désactivé : $var_cn \t depuis le $var_EndValidateDate"
                echo -e "User $var_user_test \tdésactivé depuis le $var_EndValidateDate : $var_cn"
        fi
done


# faire une copie de repertoire via un tar et un ssh sans avoir de doublon d archive
tar cvfp - scripts/ | ssh dorierb@serveur "tar xvpf - -C /tmp/"

# générer le tar directement sur le serveur distant
tar cvfp - scripts/ | ssh dorierb@serveur "cat > /tmp/script.tar.gz"

