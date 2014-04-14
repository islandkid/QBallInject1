component {

	public any function get(numeric questionid) {
		return entityLoadByPk("question", arguments.questionid);
	}

	public any function list(numeric start=1, numeric perpage=10) {
		var result = {};
		var hql = "from question order by created desc";
		var result.data = ormExecuteQuery(hql, false, { maxResults=arguments.perpage, offset=arguments.start-1});
		var totalhql = "select count(id) as total from question";
		var result.count = ormExecuteQuery(totalhql, true);
		return result;
	}

	public any function post(string title, string text, any user) {
		var q = entityNew("question");
		q.setTitle(arguments.title);
		q.setText(arguments.text);
		q.setUser(arguments.user);
		entitySave(q);
		return q;
	}

	public void function postAnswer(any question, string answer, any user) {
		var answerOb = entityNew("answer");
		answerOb.setText(arguments.answer);
		answerOb.setUser(arguments.user);
		answerOb.setSelectedAnswer(false);
		entitySave(answerOb);
		question.addAnswer(answerOb);
		entitySave(question);
	}

	public void function selectAnswer(any question, numeric answerid) {
		//loop over answers, mark ALL as NOT the answer, except the chosen one
		var answers = arguments.question.getAnswers();
		for(var i=1; i <= arrayLen(answers); i++) {
			if(answers[i].getId() != arguments.answerid) answers[i].setSelectedAnswer(false);
			else answers[i].setSelectedAnswer(true);
			entitySave(answers[i]);
		}
	}

	public void function voteAnswerDown(any question, numeric answerid, any user) {
		//First, if we exist in the list of folks who voted up, kill me
		var answer = entityLoadByPk("answer", arguments.answerid);
		answer.removeApprover(user);
		if(!answer.hasDisapprover(user)) answer.addDisapprover(user);
		entitySave(answer);
	}

	public void function voteAnswerUp(any question, numeric answerid, any user) {
		//First, if we exist in the list of folks who voted up, kill me
		var answer = entityLoadByPk("answer", arguments.answerid);
		answer.removeDisapprover(user);
		if(!answer.hasApprover(user)) answer.addApprover(user);
		entitySave(answer);
	}

}