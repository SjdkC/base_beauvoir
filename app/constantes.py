from warnings import warn

# Stockage des constantes utiles pour l'application

# Sera utilisé pour la pagination
LIVRES_PAR_PAGE = 10

# Par sécurité :
SECRET_KEY = "JE SUIS UN SECRET !"
API_ROUTE = "/api"

if SECRET_KEY == "JE SUIS UN SECRET !":
    warn("Le secret par défaut n'a pas été changé, vous devriez le faire", Warning)