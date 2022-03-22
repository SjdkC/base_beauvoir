from flask import render_template

from .app import app
from .modeles.donnees import Book

@app.route("/")
def accueil():
    livres = Book.query.order_by(Book.book_date.asc()).all()
    return render_template("pages/accueil.html", nom="Base Beauvoir", livres=livres)

@app.route("/book/<int:book_id>")
def livre(book_id):
    unique_livre = Book.query.get(book_id)
    return render_template("pages/book.html", nom="Base Beauvoir", livre=unique_livre)