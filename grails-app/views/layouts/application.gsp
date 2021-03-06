<%@ page
	import="org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="${meta(name: 'app.name')}" /></title>
<meta name="description"
	content="Please remember, don't forget. A website for to-do lists.">
<meta name="author" content="The Koala Computer Company Limited">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<r:require modules="application" />
<g:layoutHead />
<r:layoutResources />
</head>

<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<sec:ifNotLoggedIn>
					<a class="navbar-brand" href="${createLink(uri: '/')}">
						${meta(name: 'app.name')}
					</a>
				</sec:ifNotLoggedIn>
				<sec:ifLoggedIn>
					<g:link controller="reminder" action="list" class="navbar-brand" >${meta(name: 'app.name')}</g:link>
				</sec:ifLoggedIn>

			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav"><%--
					<sec:ifLoggedIn>
						<li><g:link controller="reminder" action="list">Reminder</g:link></li>
					</sec:ifLoggedIn>
					--%><li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">Menu <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><g:link controller="info" action="about">About Koala</g:link></li>
							<li><g:link controller="info" action="learn">About dontforget</g:link></li>
							<li><g:link controller="info" action="contact">Contact</g:link></li>
							<sec:ifLoggedIn>
								<li class="divider"></li>
								<li><g:link controller="logout">Sign out <sec:username /></g:link></li>
							</sec:ifLoggedIn>
						</ul></li>
				</ul>
				<sec:ifNotLoggedIn>
					<g:form uri="/j_spring_security_check"
						class="navbar-form navbar-right">
						<div class="form-group">
							<input type="text" placeholder="Username" class="form-control"
								name='j_username' id='username' />
						</div>
						<div class="form-group">
							<input type="password" placeholder="Password"
								class="form-control" name='j_password' id='password' />
						</div>
						<button type="submit" class="btn btn-success">Sign in</button>
					</g:form>
				</sec:ifNotLoggedIn>
				<sec:ifLoggedIn>
					<g:form uri="/j_spring_security_logout" method="POST"
						class="navbar-form navbar-right">
						<button type="submit" class="btn btn-success">Sign out <sec:username /></button>
					</g:form>
				</sec:ifLoggedIn>
			</div>
			<!--/.navbar-collapse -->
		</div>
	</div>
	<g:layoutBody />
	<div class="container">
		<div class="row">
			<hr>
			<footer>
				<p>Copyright &copy; 2013 The Koala Computer Company Limited</p>
			</footer>
		</div>
	</div>
	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-44752619-3' ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl'
					: 'http://www')
					+ '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>
	<r:layoutResources />
</body>
</html>