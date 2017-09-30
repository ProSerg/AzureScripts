git clone https://github.com/pallets/flask-website.git ./Website/flask-website
pip install Flask
pip install Flask-OpenID
pip install Flask-SQLAlchemy
pip install whoosh
Set-Location ./Website/flask-website
Get-Location .
Get-ChildItem .
$env:FLASK_APP=C:\Website\flask-website\run.py
flask run

