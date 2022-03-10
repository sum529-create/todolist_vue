#!/usr/bin/env sh

# abort on errors
set -e
# build
npm run build
# navigate into the build output directory
cd dist
# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME
git init
git add -A
git commit -m 'deploy'
# if you are deploying to https://sum529-create.github.io
# git push -f git@github.com:sum529-create/sum529-create.github.io.git master
# if you are deploying to https://sum529-create.github.io/todolist_vue
# git push -f git@github.com:sum529-create/todolist_vue.git master:gh-pages