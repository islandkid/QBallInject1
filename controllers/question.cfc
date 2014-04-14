component accessors="true"{

    property name="questionHelperService";

	function init(fw) {
		variables.fw = arguments.fw;
	}

	//Used by a few methods to validate/load a question
	private function loadQuestion(any rc) {
		if(!structKeyExists(rc, "questionid") || !isNumeric(rc.questionid) || rc.questionid <= 0) {
			variables.fw.redirect("main.default");
		}
		rc.question = getQuestionHelperService().get(rc.questionid);
	}
	
	function startList(any rc) {
		if (!structKeyExists(rc, "authenticated")) {
			rc.errors = "You are not logged in";
			variables.fw.redirect("main.default", "errors");
		}
		if(structKeyExists(rc, "start") && (!isNumeric(rc.start) || rc.start <= 0 || round(rc.start) != rc.start)) {
			rc.start = 1;
		}
		rc.data = getQuestionHelperService().list();
	}
		
	function startPost(any rc) {		
		rc.errors = [];
		if(!len(trim(rc.title))) arrayAppend(rc.errors, "You must include a title for your question.");
		if(!len(trim(rc.text))) arrayAppend(rc.errors, "You must include text for your question.");
		
		if(arrayLen(rc.errors)) {
			variables.fw.redirect("question.new", "title,text,errors");
		}
		else{
			rc.data = getQuestionHelperService().post(trim(rc.title),trim(rc.text),rc.user);
		}
	}

	function endPost(any rc) {
		//Right now we assume the post just worked
		rc.questionid = rc.data.getId();
		variables.fw.redirect("question.view","none","questionid");
	}

	function startPostAnswer(any rc) {
		try{
			loadQuestion(rc);

			rc.answer = trim(htmlEditFormat(rc.answer));

			getQuestionHelperService().postAnswer(rc.question,rc.answer,rc.user);
		}
		catch(any e){
			writeDump(e);
			abort;
		}

	}
	
	function endPostAnswer(any rc) {
		//Right now we assume the post just worked
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");
	}

	function startSelectAnswer(any rc) {
		loadQuestion(rc);

		if(!structKeyExists(rc, "user") || rc.user.getId() != rc.question.getUser().getID()) variables.fw.redirect("main.default");
		getQuestionHelperService().selectAnswer(rc.question,rc.answerid);
	}

	function endSelectAnswer(any rc) {
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");	
	}
	
	function startView(any rc) {
		loadQuestion(rc);
	}

	function startVoteAnswerDown(any rc) {
		loadQuestion(rc);
		getQuestionHelperService().voteAnswerDown(rc.question,rc.answerid,rc.user);
	}
			
	function endVoteAnswerDown(any rc) {
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");		
	}

	function startVoteAnswerUp(any rc) {
		loadQuestion(rc);
		getQuestionHelperService().voteAnswerUp(rc.question,rc.answerid,rc.user);
	}
			
	function endVoteAnswerUp(any rc) {
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");		
	}

}