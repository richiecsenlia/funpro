# Management App
    A simple web application to help you manage daily activity. This app supports taking notes, writing expenses, and writing schedules. Just make an account and start using the app.

# How to Run
## Backend
prerequisite :
- stack

Build the application 
<pre>
stack build
</pre>

run the executable :
<pre>
stack exec todo-exe
</pre>

## Front end:
prerequisite :
- nodejs
- npm

install dependency :
<pre>
npm install
</pre>

run app :
<pre>
npm start
</pre>

## Faas
prerequisite :
- netlify-cli
- netlify account

how to install netlify-cli
<pre>
npm install -g netlify-cli
</pre>
further info regarding netlify-cli : [link](https://cli.netlify.com/netlify-dev/)
<pre>
netlify dev
</pre>

# Deployment :
## Backend and Frontend
Both backend and frontend is deployed in railway with dockerfile setting.

How to deploy :
- create Dockerfile for each application
- connect each app to railway 
- set $Port environment variable
- get link / domain from railway

complete railway deployment guide [link](https://docs.railway.app/deploy/deployments)

## Faas
Faas is deployed at netlify.com

How to deploy :
- connect folder to netlify

# Database
Database uses postgresql hosted at https://app.supabase.com/project/gnvlenttjmyipsadlofe

# Deployment links:
- Backend1 (servant) : https://funpro-production.up.railway.app/
- Backend2 (scotty): https://funpro-production-28fa.up.railway.app/
- frontend (react) : https://funpro-production-dbc4.up.railway.app/
- faas (typescript) : https://funpro.netlify.app/.netlify/functions/
- database(postgresql) : https://app.supabase.com/project/gnvlenttjmyipsadlofe
