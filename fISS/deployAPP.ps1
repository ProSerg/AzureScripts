git clone https://github.com/pallets/flask-website.git ./Website/
pip install Flask
Set-Location ./Website
$env:FLASK_APP=run.py
flask run

