# README


This is an application that simulates the Enade platform.

To run this application locally, you must have Rails at version 4.2.1 and Ruby at version 2.2.1.

Then you need to clone the repository:
> git clone https://github.com/kennedybg/enade.git
CD into the folder
> cd enade
Run the migrations
> rake db:migrate
And then run the server
> rails s

When the server loads, you'll be able to access the application by typing the following adress on your browser:
>http://localhost:3000

To create new records, you need to authenticate your account, by typing the following adress on your browser:
>http://localhost:3000/users/sign_in

The Devise module "Registerable" is disabled, so you can't register a new account, but you can access with the following credencials:

>email: admin@enade.com
>password: admin123

With the Postgree SQL database the application crashs when you try to search by grade or average grade. This bug is caused by the Gem Ransack, 
that tries to search using text on a decimal field. This bug doesn't occurs when using SQLite. At this time, I don't know how to fix it, because I'm new at Rails, but soon I'll find a solution.
