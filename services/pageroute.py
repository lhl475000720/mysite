from flask import render_template
from flask import Blueprint

page = Blueprint('router', __name__, template_folder='templates')


@page.route('/', methods=['GET', 'POST'])
def index():
    return render_template("pages/index.html")