component accessors="true"{

    property name="questionHelperService";

	function default(any rc) {
		rc.questions = getQuestionHelperService().list(perpage=5);
	}
 

}