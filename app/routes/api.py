from flask import render_template, request, url_for, jsonify
from urllib.parse import urlencode

from ..app import app
from ..constantes import LIVRES_PAR_PAGE, API_ROUTE
from ..modeles.donnees import Book


def Json_404():
    response = jsonify({"erreur": "Unable to perform the query"})
    response.status_code = 404
    return response


@app.route(API_ROUTE+"/books/<book_id>")
def api_books_single(book_id):
    try:
        query = Book.query.get(book_id)
        return jsonify(query.to_jsonapi_dict())
    except:
        return Json_404()


@app.route(API_ROUTE+"/books")
def api_books_browse():
    """ Route permettant la recherche plein-texte dans les noms de livres

    On s'inspirera de http://jsonapi.org/ faute de pouvoir trouver temps d'y coller à 100%
    """
    # q est très souvent utilisé pour indiquer une capacité de recherche
    motclef = request.args.get("q", None)
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    if motclef:
        query = Book.query.filter(
            Book.book_nom.like("%{}%".format(motclef))
        )
    else:
        query = Book.query

    try:
        resultats = query.paginate(page=page, per_page=LIVRES_PAR_PAGE)
    except Exception:
        return Json_404()

    dict_resultats = {
        "links": {
            "self": request.url
        },
        "data": [
            place.to_jsonapi_dict()
            for place in resultats.items
        ]
    }

    if resultats.has_next:
        arguments = {
            "page": resultats.next_num
        }
        if motclef:
            arguments["q"] = motclef
        dict_resultats["links"]["next"] = url_for("api_books_browse", _external=True)+"?"+urlencode(arguments)

    if resultats.has_prev:
        arguments = {
            "page": resultats.prev_num
        }
        if motclef:
            arguments["q"] = motclef
        dict_resultats["links"]["prev"] = url_for("api_books_browse", _external=True)+"?"+urlencode(arguments)

    response = jsonify(dict_resultats)
    return response

@app.route(API_ROUTE+"/description")
def api_description_browse():
    """ Route permettant la recherche plein-texte dans les descriptions de livres

    On s'inspirera de http://jsonapi.org/ faute de pouvoir trouver temps d'y coller à 100%
    """
    # q est très souvent utilisé pour indiquer une capacité de recherche
    motclef = request.args.get("q", None)
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    if motclef:
        query = Book.query.filter(
            Book.book_description.like("%{}%".format(motclef))
        )
    else:
        query = Book.query

    try:
        resultats = query.paginate(page=page, per_page=LIVRES_PAR_PAGE)
    except Exception:
        return Json_404()

    dict_resultats = {
        "links": {
            "self": request.url
        },
        "data": [
            place.to_jsonapi_dict()
            for place in resultats.items
        ]
    }

    if resultats.has_next:
        arguments = {
            "page": resultats.next_num
        }
        if motclef:
            arguments["q"] = motclef
        dict_resultats["links"]["next"] = url_for("api_description_browse", _external=True)+"?"+urlencode(arguments)

    if resultats.has_prev:
        arguments = {
            "page": resultats.prev_num
        }
        if motclef:
            arguments["q"] = motclef
        dict_resultats["links"]["prev"] = url_for("api_description_browse", _external=True)+"?"+urlencode(arguments)

    response = jsonify(dict_resultats)
    return response