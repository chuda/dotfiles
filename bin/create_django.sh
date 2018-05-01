#!/bin/bash

_exec() {
  "$@"
  if [ $? -ne 0 ]
  then
    echo "\"$*\" failed with exit code $?"
    exit -1
  fi
}

if [ $# -eq 1 ]; then
    step=$1
    echo -n "Enter new project name: "
    read proj_name
elif [ $# -eq 2 ]; then
    step=$1
    proj_name=$2
else
    step=0
    echo -n "Enter new project name: "
    read proj_name
fi


if [ $step -le 1 ]; then
    # 1. Создание django приложения 
    _exec hg clone ssh://hg@bitbucket.org/KickAssLabs/django_project_template tmp
    _exec mv tmp/* .
    _exec rm -rf tmp
 #   _exec mv django_project_template $proj_name
fi

if [ $step -le 2 ]; then
    # 2. Устанавливаем виртуальное окружение
    _exec virtualenv2 --no-site-packages venv
fi

if [ $step -le 3 ]; then
    # 3. Установка пакетов
    _exec venv/bin/pip install -r requirements.txt
fi

if [ $step -le 4 ]; then
    # 4. Создание БД
    #_exec sudo createdb -U postgres -E UTF8 -T template0 --locale=ru_RU.UTF-8 "$proj_name"
    _exec sudo -u postgres psql -c "create database $proj_name;"
fi

if [ $step -le 5 ]; then
    # 5. Создание юзера БД
    _exec sudo -u postgres psql -c "create user \"$proj_name\" with password '$proj_name';"
fi

if [ $step -le 6 ]; then
    _exec sudo -u postgres psql -c "grant all on database \"$proj_name\" to \"$proj_name\";"
fi
