# porfolio-login - Sample Login App
Functionality-wise I've tried to keep this as simple as possible so I can focus on the architecture of the app which I really want to show-case.

If you want to see a swift-version of this, click here. Right now it's more and less simply a copy but I plan to diverge the two projects eventually.


<b>Functionality</b>

In terms of functionality this app is REALLY simple. All it does is mimick a login functionality <b>W/O</b> a real api. No matter which email/password combination you put it'll allow you to login

<b>Architecture</b>

Why need an architecture? What's my inspiration?
<a href="http://doing-it-wrong.mikeweller.com/2013/06/ios-app-architecture-and-tdd-1.html">A super-awesome article</a>

So, I agree with the author in that everything shouldn't be in VC. But how do you do that exactly? And then you'll need separate classes for each small functionality. I've tried to take a sort-of hybrid approach, separating the big chunks of the app into layers.

On a high-level, here are the layers I've separated things into:

<ul>
<li>View-Controller - Deals with interaction with the view </li>
<li>Service - Business Logic mainly</li>
<li>Gateway - Controls access to APIs</li>
<ul>


