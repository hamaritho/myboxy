/******************************************************************************
 * The Game                                                                   *
 ******************************************************************************/
class Game {
	private State titleState;
	private State newGameState;
	private State inGameState;
	private State howToPlayState;
	private State surveyState;

	private State state;

	private Boxy boxy;

	public Game() {
		boxy = new Boxy();
		titleState = new TitleState(this);
		newGameState = new NewGameState(this);
		inGameState = new InGameState(this);
		howToPlayState = new HowToPlayState(this);
		surveyState = new SurveyState(this);
		

		titleState.initializeItems();
		newGameState.initializeItems();
		inGameState.initializeItems();
		howToPlayState.initializeItems();
		surveyState.initializeItems();

		state = titleState;
	}

	public void draw() {
		state.draw();
	}

	public void mousePressed(MouseEvent event) {
		state.mouseEvent(event);
	}

	public State getTitleState() {
		return titleState;
	}

	public State getNewGameState() {
		return newGameState;
	}

	public State getInGameState() {
		return inGameState;
	}

	public State getHowToPlayState() {
		return howToPlayState;
	}

	public State getSurveyState() {
		return surveyState;
	}

	public void setState(State s) {
		state = s;
	}

	public Boxy getBoxy() {
		return boxy;
	}
};