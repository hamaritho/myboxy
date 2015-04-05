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
	private Game g;
	private int screen = 0;
	private Button submit;

	//Color Suff
	private Button[] colors;
	private color chosenColor;

	//Name stuff
	private Keyboard keyboard;
	private char[] name;
	private int currentIndex;
	private int maxIndex;
	
	

	public NewGameState(Game g) {
		this.g = g;
		colors = new Button[7];
		keyboard = new Keyboard(75, 100);

		colors[0] = new ColorButton(200, 150, 100, 100, color(255,0,0));
		colors[1] = new ColorButton(300, 150, 100, 100, color(255, 127, 0));
		colors[2] = new ColorButton(400, 150, 100, 100, color(255, 255, 0));
		colors[3] = new ColorButton(150, 250, 100, 100, color(0, 255, 0));
		colors[4] = new ColorButton(250, 250, 100, 100, color(0, 0, 255));
		colors[5] = new ColorButton(350, 250, 100, 100, color(75, 0, 130));
		colors[6] = new ColorButton(450, 250, 100, 100, color(143, 0, 255));

		submit = new  Button("Submit", 300, 550, 100, 50);

		chosenColor = color(255,255,255);

		name = new char[8];

		for (int i = 0; i < 8; i++) {
			name[i] = '_';
		}

		maxIndex = 8;
		currentIndex = 0;
	}

	public void initializeButtons() {

	}

	public void draw() {
		background(255);

		switch(screen)
		{
			case 0:
				fill(0);
				writeText("Choose a Color:", width/2, 50, 28.9);
				
				for (Button b : colors) {
					b.draw();
				}

				fill(chosenColor);
				rect(width/2, 400, 100, 100);

				break;

			case 1:
				fill(0);
				writeText("Name your Boxy:", width/2, 50, 28.9);
				keyboard.draw();

				fill(0);
				writeText(name, 125, 350, 77.7);

				break;

			default:
				break;
		}
		submit.draw();		
	}

	public void click(int x, int y) {
		switch(screen) {
			case 0:
				
				for (Button b : colors) {
					if (b.clicked(x, y)) {
						chosenColor = ((ColorButton)b).getColor();
					}
				}

				if (submit.clicked(x, y)) {
					if (chosenColor != color(255,255,255)) {
						screen += 1;
					}
				}

				break;

			case 1:
				char k = keyboard.click(x, y);
				print(k);
				if (k == '.') {
					currentIndex -= 1;
					name[currentIndex] = '_';
				}
				else {
					if (currentIndex < maxIndex) {
						name[currentIndex] = k;
						currentIndex += 1;
					}
				}

				if (submit.clicked(x, y)) {
					if (name[0] != '_') {
						g.setState(g.getInGameState());
					}
				}
				
				break;

			default:
				break;
		}
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

