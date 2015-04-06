/******************************************************************************
 * Helper Functions                                                           *
 ******************************************************************************/
void writeText(String t, int x, int y, float fontsize) {
	textFont(f, fontsize);
	text(t, x, y);
}

void writeText(char[] t, int x, int y, float fontsize) {
	textFont(f, fontsize);

	for (char letter : t) {
		text(letter, x, y);
		x += 50;
	}
}

/******************************************************************************
 * Button Classes                                                             *
 ******************************************************************************/
class Button {
	String t;
	int x;
	int y;
	int w;
	int h;

	public Button(String t, int x, int y, int w, int h) {
		this.t = t;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}

	public void draw() {
		fill(255);
		rect(x, y, w, h, 20);
		fill(0);
		writeText(t, x, y, 28.9);
	}

	public boolean clicked(int mx, int my) {
		int left = x - (w/2);
		int right = x + (w/2);
		int top = y - (h/2);
		int bottom = y + (h/2);

		return (mx >= left) && (mx <= right) && (my >= top) && (my <= bottom);
	}
};

class MenuButton extends Button {
	
	private State nextState;

	public MenuButton(String t, int x, int y, int w, int h, State nextState) {
		super(t, x, y, w, h);
		this.nextState = nextState;
	}

	public State getNextState() {
		return nextState;
	}
};

class ColorButton extends Button {
	private color c;

	public ColorButton(int x, int y, int w, int h, color c) {
		super("", x, y, w, h);
		this.c = c;
	}

	public color getColor() {
		return c;
	}

	public void draw() {
		fill(c);
		rect(x, y, w, h);
	}
};

class Key extends Button {
	private char letter;

	public Key(String t, int x, int y, int w, int h, char letter) {
		super(t, x, y, w, h);
		this.letter = letter;
	}

	public char getLetter() {
		return letter;
	}
};

/******************************************************************************
 * Keyboard Class                                                             *
 ******************************************************************************/
class Keyboard {
	private int startX;
	private int startY;
	private Key[] keys;
	private Key backspace;

	public Keyboard(int startX, int startY) {
		this.startX = startX;
		this.startY = startY;
		keys = new Key[26];

		keys[0] = new Key("Q", startX + 0, startY + 0, 50, 50, 'Q');
		keys[1] = new Key("W", startX + 50, startY + 0, 50, 50, 'W');
		keys[2] = new Key("E", startX + 100, startY + 0, 50, 50, 'E');
		keys[3] = new Key("R", startX + 150, startY + 0, 50, 50, 'R');
		keys[4] = new Key("T", startX + 200, startY + 0, 50, 50, 'T');
		keys[5] = new Key("Y", startX + 250, startY + 0, 50, 50, 'Y');
		keys[6] = new Key("U", startX + 300, startY + 0, 50, 50, 'U');
		keys[7] = new Key("I", startX + 350, startY + 0, 50, 50, 'I');
		keys[8] = new Key("O", startX + 400, startY + 0, 50, 50, 'O');
		keys[9] = new Key("P", startX + 450, startY + 0, 50, 50, 'P');

		keys[10] = new Key("A", startX + 25, startY + 55, 50, 50, 'A');
		keys[11] = new Key("S", startX + 75, startY + 55, 50, 50, 'S');
		keys[12] = new Key("D", startX + 125, startY + 55, 50, 50, 'D');
		keys[13] = new Key("F", startX + 175, startY + 55, 50, 50, 'F');
		keys[14] = new Key("G", startX + 225, startY + 55, 50, 50, 'G');
		keys[15] = new Key("H", startX + 275, startY + 55, 50, 50, 'H');
		keys[16] = new Key("J", startX + 325, startY + 55, 50, 50, 'J');
		keys[17] = new Key("K", startX + 375, startY + 55, 50, 50, 'K');
		keys[18] = new Key("L", startX + 425, startY + 55, 50, 50, 'L');

		keys[19] = new Key("Z", startX + 75, startY + 110, 50, 50, 'Z');
		keys[20] = new Key("X", startX + 125, startY + 110, 50, 50, 'X');
		keys[21] = new Key("C", startX + 175, startY + 110, 50, 50, 'C');
		keys[22] = new Key("V", startX + 225, startY + 110, 50, 50, 'V');
		keys[23] = new Key("B", startX + 275, startY + 110, 50, 50, 'B');
		keys[24] = new Key("N", startX + 325, startY + 110, 50, 50, 'N');
		keys[25] = new Key("M", startX + 375, startY + 110, 50, 50, 'M');

		backspace = new Key("Backspace", startX + 225, startY + 170, 200, 50, '.');
	}

	public void draw() {
		for(Key k : keys) {
			k.draw();
		}
		backspace.draw();
	}

	public char click(int x, int y) {
		for(Key k : keys) {
			if(k.clicked(x, y)) {
				return k.getLetter();
			}
		}
		if(backspace.clicked(x,y)) {
			return backspace.getLetter();
		}
		return '_';
	}
};

/******************************************************************************
 * Game States                                                                *
 ******************************************************************************/
interface State {
	public void draw();
	public void click(int x, int y);
	public void initializeButtons();
	public void drag(int x, int y);
}

/******************************************************************************
 * Title State                                                                *
 ******************************************************************************/
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

	public void drag(int x, int y) {
		//Nothing to do.
	}
};

/******************************************************************************
 * New Game                                                                   *
 ******************************************************************************/
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

	public void drag(int x, int y) {
		//Nothing to do.
	}
};

/******************************************************************************
 * In Game State                                                              *
 ******************************************************************************/
class InGameState implements State {
	private Game g;

	public InGameState(Game g) {
		this.g = g;
	}

	public void initializeButtons() {

	}

	public void draw() {

	}

	public void click(int x, int y) {

	public void drag(int x, int y) {
		b.drag(x, y);
	}
};

/******************************************************************************
 * How To Play                                                                *
 ******************************************************************************/
class HowToPlayState implements State {
	private Game g;

	public HowToPlayState(Game g) {
		this.g = g;
	}

	public void initializeButtons() {

	}

	public void draw() {

	}

	public void click(int x, int y) {

	}

	public void drag(int x, int y) {

	}
};

/******************************************************************************
 * Survey                                                                     *
 ******************************************************************************/
class SurveyState implements State {
	private Game g;

	public SurveyState(Game g) {
		this.g = g;
	}

	public void initializeButtons() {

	}

	public void draw() {

	}

	public void click(int x, int y) {

	}

	public void drag(int x, int y) {

	}
};

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

	public Game() {
		titleState = new TitleState(this);
		newGameState = new NewGameState(this);
		inGameState = new InGameState(this);
		howToPlayState = new HowToPlayState(this);
		surveyState = new SurveyState(this);

		titleState.initializeButtons();
		newGameState.initializeButtons();
		inGameState.initializeButtons();
		howToPlayState.initializeButtons();
		surveyState.initializeButtons();

		state = titleState;
	}

	public void draw() {
		state.draw();
	}

	public void click(int x, int y) {
		state.click(x, y);
	}

	public void drag(int x, int y) {
		if (state == inGameState) {
			state.drag(x, y);
		}
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
};

	}
};

/******************************************************************************
 * Keyboard Class                                                             *
 ******************************************************************************/
};

/******************************************************************************
 * Running the Game                                                           *
 ******************************************************************************/
PFont f;
Game game;

void setup() {
	size(600,600);
	f = createFont("Ubuntu Mono", 77);
	rectMode(CENTER);
	textAlign(CENTER, CENTER);
	game = new Game();
}

void draw() {
	game.draw();
}

void mouseClicked() {
	game.click(mouseX, mouseY);
}

void mouseDragged() {
	game.drag(mouseX, mouseY);
}