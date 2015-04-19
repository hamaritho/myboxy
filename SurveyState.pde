/******************************************************************************
 * Survey                                                                     *
 ******************************************************************************/
class SurveyState implements State {
	private Game g;

	public SurveyState(Game g) {
		this.g = g;
	}

	public void initializeItems() {

	}

	public void draw() {
		link("http://goo.gl/forms/alnysL5lVp");
		g.setState(g.getTitleState());
	}

	public void mouseEvent(MouseEvent event) {
	}
};