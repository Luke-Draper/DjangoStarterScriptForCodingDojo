#!/bin/bash
echo ""
echo "running: source $2"
source "$2"

echo ""
echo "running: django-admin startproject main"
django-admin startproject main

cd main

mkdir apps

cd apps

touch __init__.py

echo ""
echo "running: python ../manage.py startapp $1"
python ../manage.py startapp "$1"

cd ../

echo ""
echo "adding $1 to installed apps"
sed -i.bkp '/INSTALLED_APPS = \[/a     "apps.'"$1"'",' './main/settings.py'

python manage.py makemigrations
python manage.py migrate

mkdir "./apps/$1/templates"
mkdir "./apps/$1/templates/$1"
mkdir "./apps/$1/static"
mkdir "./apps/$1/static/$1"
mkdir "./apps/$1/static/$1/css"
mkdir "./apps/$1/static/$1/js"
touch "./apps/$1/templates/$1/index.html"
touch "./apps/$1/static/$1/css/style.css"
touch "./apps/$1/static/$1/js/script.js"
touch "./apps/$1/urls.py"

echo ""
echo "Implementing starter app"
echo '<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Title</title>
		<meta name="description" content="Description" />
		<link
			rel="stylesheet"
			href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
			integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
			crossorigin="anonymous"
		/>
		<script
			src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
			integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
			crossorigin="anonymous"
		></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
			integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
			crossorigin="anonymous"
		></script>
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
			integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
			crossorigin="anonymous"
		></script>
		{% load static %}
		<link rel="stylesheet" href="{% static '"'"''"$1"'/css/style.css'"'"' %}">
		<script src="{% static '"'"''"$1"'/js/script.css'"'"' %}"></script>
	</head>
	<body class="bg-dark text-light">
		<div class="container">
			<div class="row p-4 justify-content-center"><h1>Survey Form</h1></div>
			<div class="row justify-content-center">
				<form
					class="col-sm-6 bg-secondary p-4 rounded"
					action="/post"
					method="post"
				>
					{% csrf_token %}
					<div class="form-row p-2 justify-content-center">
						<label class="col-sm-4 col-form-label" for="name">Your Name:</label>
						<input
							class="col-sm-8 form-control"
							type="text"
							name="name"
							id="name"
						/>
					</div>
					<div class="form-group p-2 justify-content-center">
						<label class="form-label" for="comment">Comment (Optional):</label>
						<textarea
							class="form-control"
							name="comment"
							id="comment"
							rows="4"
						></textarea>
					</div>
					<div class="form-row justify-content-end">
						<input
							class="col-auto p-2 mr-3 btn btn-dark"
							type="submit"
							value="Submit"
						/>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>' > "./apps/$1/templates/$1/index.html"

echo 'from django.conf.urls import url,include
urlpatterns = [
	url(r'"'"'^'"'"', include('"'"'apps.'"$1"'.urls'"'"'))
]
' > './main/urls.py'


echo 'from django.conf.urls import url
from . import views
urlpatterns = [
	url(r'"'"'^$'"'"',views.index),
	url(r'"'"'^redirect$'"'"',views.redirect),
	url(r'"'"'^post$'"'"',views.post)
]
' > "./apps/$1/urls.py"


echo 'from django.shortcuts import render, HttpResponse, redirect
def index(request):
	context = {
		"dummy": "dummy"
	}
	request.session["dummy"] = "dummy"
	return render(request,"'"$1"'/index.html",context)

def redirect(request):
	del request.session["dummy"]
	return redirect("/")

def post(request):
	if request.method == "POST":
		request.session["name"] = request.POST["name"]
		print("")
		print(request.POST)
		print(request.POST["name"])
		print(request.POST["desc"])
		print("")
		return redirect("/")
	else:
		return redirect("/")

' > "./apps/$1/views.py"

echo 'from __future__ import unicode_literals
from django.db import models

class Blog(models.Model):
	name = models.CharField(max_length=255)
	desc = models.TextField()
	created_at = models.DateTimeField(auto_now_add = True)
	updated_at = models.DateTimeField(auto_now = True)

class Comment(models.Model):
	comment = models.CharField(max_length=255)
	created_at = models.DateTimeField(auto_now_add = True)
	updated_at = models.DateTimeField(auto_now = True)
	blog = models.ForeignKey(Blog, related_name = "comments")

class Admin(models.Model):
	first_name = models.CharField(max_length=255)
	last_name = models.CharField(max_length=255)
	email = models.CharField(max_length=255)
	blogs = models.ManyToManyField(Blog, related_name = "admins")
	created_at = models.DateTimeField(auto_now_add = True)
	updated_at = models.DateTimeField(auto_now = True)
' > "./apps/$1/models.py"

echo ""
echo 'To start django run:'
echo 'cd main'
echo 'python manage.py runserver'
echo ""
