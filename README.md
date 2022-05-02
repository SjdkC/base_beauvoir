# Base Beauvoir

Cette application a été développée par Cécile Sajdak 
dans le cadre du cours de Python du du Master 2 TNAH de l'Ecole nationale des chartes 
([consignes du devoir](https://github.com/PonteIneptique/cours-python/wiki/2021-2022-Devoir)).

Elle s'appuie sur le framework Flask.


## Objectifs
Cette application vise à répertorier les
liens intertextuels présents au sein de 
l'oeuvre de Simone de Beauvoir. 
L'application se concentre en particulier 
sur les liens qui existent entre l'oeuvre autobiographique 
de Simone de Beauvoir et ses autres ouvrages.

Le but est ainsi de répertorier et
de faciliter l'accès aux explications fournies par
l'autrice elle-même concernant ses processus
créatifs et intellectuels, la réception de ses
oeuvres, mais aussi de permettre une mise en
contexte de sa production littéraire.

## Fonctionalités

- Fonctions CRUD : creation, consultation, 
modification, suppression.
- Recherche rapide.
- Gestion des utilisateurs : inscription, connexion, déconnexion.
- API permettant de récupérer une partie des 
données au format JSON.

## Installation et lancement
### Ubuntu
- Pré-requis : avoir installé Python3
- Ouvrir un terminal et cloner le dépôt : `git clone https://github.com/SjdkC/base_beauvoir.git`
- Se déplacer dans le dossier du dépôt : `cd base_beauvoir`
- Créer un environnement virtuel : `virtualenv -p python3 env`
- Activer l'environnement virtuel : `source env/bin/activate`
- Installer les librairies requises : `pip install -r requirements.txt`
- Lancer l'application : `python3 run.py` puis se rendre à l'adresse http://127.0.0.1:5000/ depuis un navigateur (Firefox recommandé))

