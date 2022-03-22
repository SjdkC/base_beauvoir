from .. app import db

# On crée notre modèle
class Book(db.Model):
    book_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    book_nom = db.Column(db.Text, nullable=False)
    book_date = db.Column(db.Integer, nullable=False)
    book_type = db.Column(db.String(45), nullable=False)
    book_description = db.Column(db.Text)