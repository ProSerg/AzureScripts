git clone https://github.com/pallets/flask-website.git ./Website/flask-website
pip install Flask
Set-Location ./Website/flask-website
$env:FLASK_APP=run.py
flask run

