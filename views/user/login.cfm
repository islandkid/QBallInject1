<cfset rc.pagetitle = "Login/Register">
<cfparam name="rc.username" default="">
<cfparam name="rc.email" default="">
<cfparam name="rc.username" default="">

<h2>Login</h2>
<p>
Existing users can login using the form below:
</p>
<cfif structKeyExists(rc, "loginerrors")>
	<p>
	<b>Your login could not be completed due to the following error(s):</b><br/>
	<ul>
	<cfloop index="e" array="#rc.loginerrors#">
		<cfoutput><li>#e#</li></cfoutput>
	</cfloop>
	</ul>
</cfif>

<cfoutput>
<form action="#buildUrl('user.authenticate')#" method="post">
<b>username:</b> <input type="text" name="username" value="#rc.username#"><br/>
<b>password:</b> <input type="password" name="password"><br/>
<input type="submit" value="Login">
</form>
</cfoutput>

<h2>Register</h2>
<p>
New users can register using the form below. All fields are required.
</p>
<cfif structKeyExists(rc, "registererrors")>
	<p>
	<b>Your registration could not be completed due to the following error(s):</b><br/>
	<ul>
	<cfloop index="e" array="#rc.registererrors#">
		<cfoutput><li>#e#</li></cfoutput>
	</cfloop>
	</ul>
</cfif>

<cfoutput>
<form action="#buildUrl('user.register')#" method="post">
<b>username:</b> <input type="text" name="username" value="#rc.username#"><br/>
<b>password:</b> <input type="password" name="password"><br/>
<b>confirm password:</b> <input type="password" name="password2"><br/>
<b>email:</b> <input type="text" name="email" value="#rc.email#"><br/>
<input type="submit" value="Register">
</form>
</cfoutput>
