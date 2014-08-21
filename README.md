#Makers Chitter

##Table of Contents

* [Screenshots](#screenshots)
* [General Description](#general-description)
* [See it Live on Heroku](#see-it-live-on-heroku)
* [Browsers](#browsers)
* [Testing](#testing)
* [License](#license)


##Screenshots

<table>
	<tr>
		<td align="center" width=25% >
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/app/public/images/chitter_1.jpg">
				<img src="app/public/images/chitter_1.jpg" height="105px" />
				Visit
			</a>
		</td>
		<td align="center" width=25% >
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/app/public/images/chitter_2.jpg">
				<img src="app/public/images/chitter_2.png" height="105px" />
				Sign up
			</a>
		</td>
		<td align="center" width=25% >
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/app/public/images/chitter_3.jpg">
				<img src="app/public/images/chitter_3.png" height="105px" />
				Compose peep
			</a>
		</td>
		<td align="center" width=25% >
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/app/public/images/chitter_4.jpg">
				<img src="app/public/images/chitter_4.png" height="105px" />
				Post Peep
			</a>
		</td>
	</tr>
</table>


##General Description

<strong>Makers Chitter</strong> is an exercise in building an instant messaging web app 
for students at [Makers Mcademy](http://www.makersacademy.com/).

The allows users to visit and view the various 'peeps' perviously posted.

In order to post peeps, however, users must register with the app.

Registered user details and all their peeps are stored in a Postgresql database.

In terms of registration criteria, email addresses and usernames must be unique.

The was written in [Ruby](https://www.ruby-lang.org/en/) according 
to [TDD](http://en.wikipedia.org/wiki/Test-driven_development)

Tests were generated with [Rspec](http://rspec.info) 
& [Capybara](https://github.com/jnicklas/capybara).

It was built within the [Sinatra](http://www.sinatrarb.com/) framework and 
utilizes [Datamapper](http://datamapper.org/) to access the database.

It also implements [bcrypt](https://github.com/codahale/bcrypt-ruby) to securly store only 
the digests of users' passwords.


##See it Live on Heroku

A live version of the app can be found at:

http://makers-chitter.herokuapp.com

As I'm using Heroku's free hosting service, the app may take a bit of time to upload<br/>
(Heroku's giros take time to wake up...), so please be patient.


##Browsers

 This app has been tested with and supports the following browsers:

* __Google Chrome__ (36.0)
* __Apple Safari__ (7.0.5)
* __Mozilla Firefox__ (31.0)

However, it should (hopefully) look decent in other browsers as well.


##  Testing

Tests were written with Rspec (2.14.8) & Capybara (2.3.0)

The tests cover both back-end logic and front-end functionality.

To run the tests in terminal: 

```bash
$ rspec
```

##  License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>

