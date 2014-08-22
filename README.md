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
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/public/images/chitter_1.jpg">
				<img src="public/images/chitter_1.jpg" height="105px" />
				Visit
			</a>
		</td>
		<td align="center" width=25% >
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/public/images/chitter_2.jpg">
				<img src="public/images/chitter_2.jpg" height="105px" />
				Sign up
			</a>
		</td>
		<td align="center" width=25% >
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/public/images/chitter_3.jpg">
				<img src="public/images/chitter_3.jpg" height="105px" />
				Compose a peep
			</a>
		</td>
		<td align="center" width=25% >
			<a href="https://raw.githubusercontent.com/nadavmatalon/chitter/master/public/images/chitter_4.jpg">
				<img src="public/images/chitter_4.jpg" height="105px" />
				And post it
			</a>
		</td>
	</tr>
</table>


##General Description
 
The core of <strong>Makers Chitter</strong> was written over a weekend as an exercise 
in building an instant messaging web app for students 
at [Makers Mcademy](http://www.makersacademy.com/).

Later on parts of the app were re-written (mainly the front-side) to give it
a nicer look and a toggle button was added which enables to display peep list 
either according to the date of posting or the author's name.

In a nutshell, the guidlines for building the app were:

* The app allows users who visit the website to view the various 'peeps' which were 
perviously posted.

* In order to post peeps, however, users must register with the app.

* Details of registered users and all their peeps are stored in a Postgresql database.

* In terms of registration criteria, email addresses and usernames must be unique.


The app was written in [Ruby](https://www.ruby-lang.org/en/) according 
to [TDD](http://en.wikipedia.org/wiki/Test-driven_development).

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

 This app has been tested with and supports the following browsers (though it should hopefully
 look ok in other browsers as well):

* __Google Chrome__ (36.0)
* __Mozilla Firefox__ (31.0)
* __Apple Safari__ (7.0.5)

In case the app doesn't look right in __Safari__ (content is showing but without any css styling), 
this may be due to the security settings. To solve this, under 'Perferences > privacy settings', 
check if 'Block cookies' is set to 'Always' and if it does change it to 'from third parties 
and advertisers' (that's the default). In addition, click the 'Remove all website data' 
to clear the session cookies. After that, it should work as it intended.


##  Testing

Tests were written with [Rspec](http://rspec.info) (2.14.8) & 
[Capybara](https://github.com/jnicklas/capybara) (2.3.0).

The tests cover both back-end logic and front-end functionality.

To run the tests in terminal: 

```bash
$ rspec
```

##  License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>

