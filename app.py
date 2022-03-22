from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy

app = Flask("Application")
# On configure la base de données
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite'
# On initie l'extension
db = SQLAlchemy(app)

# On crée notre modèle
class Book(db.Model):
    book_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    book_nom = db.Column(db.Text, nullable=False)
    book_date = db.Column(db.Integer, nullable=False)
    book_type = db.Column(db.String(45), nullable=False)
    book_description = db.Column(db.Text)

class User(db.Model):
    user_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    user_nom = db.Column(db.Text)
    user_login = db.Column(db.String(45), unique=True)
    user_email = db.Column(db.Text, unique=True)
    user_password = db.Column(db.String(64))

@app.route("/")
def accueil():
    livres = Book.query.order_by(Book.book_date.asc()).all()
    return render_template("pages/accueil.html", nom="Base Beauvoir", livres=livres)

@app.route("/book/<int:book_id>")
def livre(book_id):
    unique_livre = Book.query.get(book_id)
    return render_template("pages/book.html", nom="Base Beauvoir", livre=unique_livre)

# Ce if permet de vérifier que ce fichier est celui qui est courrament exécuté. Cela permet par exemple d'éviter
# de lancer une fonction quand on importe ce fichier depuis un autre fichier.
# En python, lorsque l'on exécute un script avec la commande `python script.py`
# Le fichier `script.py` a en __name__ la valeur __main__.
if __name__ == "__main__":
    app.run()
