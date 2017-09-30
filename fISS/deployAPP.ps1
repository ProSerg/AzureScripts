git clone https://github.com/pallets/flask-website.git ./Website/flask-website
Set-Location ./Website/flask-website
pip install -r requirements.txt
$env:FLASK_APP=C:\Website\flask-website\run.py
flask run

