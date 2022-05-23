# AngelicoBlog
Yes, just another ordinary personal blog.

Preview: <br/>
![alt text](https://github.com/JovinIsMe/AngelicoBlog/blob/master/preview.png?raw=true)

# Running via docker compose
1. Start the container with the DB <br/>
`docker-compose up`
1. Access the blog from <br/>
`http://localhost:3000`
1. Create dummy author <br/>
`docker-compose run web rails db:seed`
1. Sign in from <br/>
`http://localhost:3000/authors/sign_in`


# Running in Termux
* Initialize Database <br/>
`initdb ~/pg/`

* Accessing PostgreSQL Database <br/>
`psql postgres`

* Activate PostgreSQL Database <br/>
`postgres -D ~/pg/`

* Run Rails Server <br/>
`bin/rails server`
