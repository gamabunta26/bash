# Recherche un parametre dans des fichiers de configuration
find . -type f -name "*.xml" -exec grep -Hin stash {} --color=auto \; -o -name "*.sh" -exec grep -Hin stash {} --color=auto \; 

# lister et trier tous les fichiers de plus de 100 M dans une arborescence
for i in `find . -type f -size +100000000c -exec du -m {} \; 2>/dev/null | sort -rn  | cut -f2`; do du -h $i; done