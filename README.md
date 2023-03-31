# Flow

Flow is a simple cashflow tracking application. 

My motivation in building Flow was twofold: 
  1) to make a tool that I could use myself for tracking and visualizing spending, and 
  2) to practice the programming and web development concepts I've learned over the last couple of years.

## Try out Flow on Heroku
You can find the deployed app [here](https://young-sea-87737.herokuapp.com). You'll have to sign up, after which you can create additional expense categories and input your own expense records.

## To run on your local machine
You'll need to have ruby (3.2.1) and Rails (7.0.4.3) installed. 
Clone the repo with `$ git clone https://github.com/chrisaugust/Flow.git flow`.
Hop into the directory with `$ cd flow`, run `$ bundle install`.
Set up the database with `$ rails db:migrate`.

At this point you should check out the 'seeds.rb' file in the 'flow/db' directory. It will create some basic categories and a generic admin user. Leave as is or modify as you see fit.
Also, take note of the 'admin' attribute of User objects. 
This is important because only admin users can edit and delete categories, and only admin users can edit and delete user accounts besides their own. This attribute defaults to false and must be set to true on the console.

Run `$ rake db:seed` to seed the database. 
Now you're ready to fire up the server with `$ rails server` 
and point your browser at localhost:3000 to see the app in action.

## Hope you enjoy!
