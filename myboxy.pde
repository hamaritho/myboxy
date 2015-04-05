/******************************************************************************
 * Game States                                                                *
 ******************************************************************************/
interface State {
	public void draw();
	public void click(int x, int y);
	public void initializeButtons();
}

class TitleState implements State {
	private Game g;
	private Button[] buttons;

	public TitleState(Game g) {
		this.g = g;
		buttons = new Button[4];
	}

	public void initializeButtons() {
		buttons[0] = new MenuButton("New Game", width/2, 150, 300, 50, this.g.getNewGameState());
		buttons[1] = new MenuButton("Load Game", width/2, 250, 300, 50, this.g.getInGameState());
		buttons[2] = new MenuButton("How To Play", width/2, 350, 300, 50, this.g.getHowToPlayState());
		buttons[3] = new MenuButton("Take Survey", width/2, 450, 300, 50, this.g.getSurveyState());
	}

	public void draw() {
		background(255);
		String t = "My Boxy";
		fill(0);

		writeText(t, width/2, 50, 77.7);

		for(Button b : buttons) {
			b.draw();
		}
	}

	public void click(int x, int y) {
		for(Button b : buttons) {
			if (b.clicked(x, y)) {
				g.setState(((MenuButton)b).getNextState());
			}
		}
	}
};

class NewGameState implements State {
	Game g;

	NewGameState(Game g) {
		this.g = g;
	}
};

class InGameState implements State {
	Game g;

	InGameState(Game g) {
		this.g = g;
	}
};

class HowToPlayState implements State {
	Game g;

	HowToPlayState(Game g) {
		this.g = g;
	}
};

class SurveyState implements State {
	Game g;

	SurveyState(Game g) {
		this.g = g;
	}
};

class Game {
	State titleState;
	State newGameState;
	State inGameState;
	State howToPlayState;
	State surveyState;

	State state;

	Game() {
		titleState = new TitleState(this);
		newGameState = new NewGameState(this);
		inGameState = new InGameState(this);
		howToPlayState = new HowToPlayState(this);
		surveyState = new SurveyState(this);

		state = titleState;
	}

	void draw() {
		state.draw();
	}

	void click(int x, int y) {
		state.click(x, y);
	}

	State getTitleState() {
		return titleState;
	}

	State getNewGameState() {
		return newGameState;
	}

	State getInGameState() {
		return inGameState;
	}

	State getHowToPlayState() {
		return howToPlayState;
	}

	State getSurveyState() {
		return surveyState;
	}

	void setState(State s) {
		state = s;
	}
};

class Button {
	String t;
	int x;
	int y;
	int w;
	int h;

	Button(String t, int x, int y, int w, int h) {
		this.t = t;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}

	void draw() {
		fill(255);
		rect(x, y, w, h, 20);
		fill(0);
		textFont(f, 28.9);

		text(t, x, y);
	}

	boolean clicked(int mx, int my) {
		int left = x - (w/2);
		int right = x + (w/2);
		int top = y - (h/2);
		int bottom = y + (h/2);

		return (mx >= left) && (mx <= right) && (my >= top) && (my <= bottom);
	}
};

PFont f;
Game game;

void setup() {
	size(600,600);
	f = createFont("Ubuntu Mono");
	rectMode(CENTER);
	textAlign(CENTER, CENTER);
	game = new Game();
	noLoop();
}

void draw() {
	game.draw();
}

void mouseClicked() {
	game.click(mouseX, mouseY);
}

