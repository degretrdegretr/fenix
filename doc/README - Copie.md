Installation :
--------------

Lancer la commande suivante pour s'assurer que Scala est correctement installé:

scala -version    
Scala code runner version 2.11.6 -- Copyright 2002-2013, LAMP/EPFL

Au cas où le copyright n'apparaitrait, télécharger le nécessaire d'installation 
à l'adresse suivante: http://www.scala-lang.org/

Au besoin, mettre à jour la version de Java.




Compilation de l'application :
------------------------------

Se placer dans le répertoire où se trouvent le fichier de transaction,
les fichiers de référentiels et lancer la commande:

scalac phenix.scala




Exécution :
-----------

scala -cp . Phenix transaction_20150114.data

Les fichiers d'indicateurs seront produits dans le
même répertoire.



