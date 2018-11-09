# DjangoStarterScriptForCodingDojo
A WIP Django starter script to initialize a Django project and app with a given input name

# How to use

Note: Use at yoour own risk. I'd highly reccomend you look through and understand all the commands in the script before running it.
Note: I'm using Bash on Linux Ubuntu 18.04. I am not sure how it will act on a system other than my own as I just use Bash to help my other tasks.


Copy startapp.sh into the folder oyu want to create a Django project in and run:

```bash
./startapp.sh 'name_of_your_django_app' 'absolute_path_to_your_virtual_environment_activate_script'
```

And that's it! You can now run to start it up:

```bash
cd main
python manage.py runserver
```

# Questions? Comments? Concerns?

Submit a pull request or bug report and I'll take a look. I probably won't be maintaining this script for very long but it's under the MIT License so you can do whatever you like with it.
