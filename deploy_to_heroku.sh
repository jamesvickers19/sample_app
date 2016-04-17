#!/bin/bash

git push
git push heroku
heroku run rake db:migrate
