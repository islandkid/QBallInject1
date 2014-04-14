<cfparam name="rc.authenticated" default="false">
<cfparam name="rc.questions" default="#structNew()#">

<h1>Welcome to QBall</h1>
<p>
QBall is an question and answer application. Users can write questions or respond to others. Users can also rate answers up and down.
</p>

<cfif rc.authenticated>
	<cfoutput>
	<p>
	<a href="#buildUrl('question.new')#">Ask a Question!</a>
	</p>
	</cfoutput>
<cfelse>
	<cfoutput>
	<p>
	To ask your own question (or respond to others), please <a href="#buildUrl('user.login')#">login or register</a>.
	</p>
	</cfoutput>
</cfif>

<h2>Recent Questions</h2>

<cfif rc.questions.count gt 0>
	<cfloop index="q" array="#rc.questions.data#">
		<p>
		<cfoutput>
		<a href="?#framework.action#=question.view&questionid=#q.getId()#">#q.getTitle()#</a> <cfif q.getAnswered()><b>Answered</b></cfif><br/>
		Asked by #q.getUser().getUsername()# on #dateFormat(q.getCreated(), "mmmm d, yyyy")# at #timeFormat(q.getCreated(), "h:mm tt")#
		</cfoutput>
		</p>
	</cfloop>
<cfelse>
	<p>
	There are no questions currently.
	</p>
</cfif>