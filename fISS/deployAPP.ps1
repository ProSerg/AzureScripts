git clone https://github.com/pallets/flask-website.git ./Website/flask-website
pip install Flask
Set-Location ./Website/flask-website
$env:FLASK_APP=C:\Website\flask-website\run.py
Get-Location .
Get-ChildItem .
flask run

