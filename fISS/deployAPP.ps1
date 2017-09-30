git clone https://github.com/pallets/flask-website.git ./Website/flask-website
pip install Flask
pip install Flask-OpenID
pip install Flask-SQLAlchemy
pip install whoosh
pip install python-creole
Set-Location ./Website/flask-website
$env:FLASK_APP=C:\Website\flask-website\run.py
flask run

