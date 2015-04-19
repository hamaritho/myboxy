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

	public void initializeItems() {

	}

	public void draw() {
		background(255);

		switch(screen)
		{
			case 0:
				fill(0);
				writeText("Choose a Color:", width / 2, 50, 28.9);
				
				for (Button b : colors) {
					b.draw();
				}

				fill(chosenColor);
				rect(width / 2, 400, 100, 100);

				break;

			case 1:
				fill(0);
				writeText("Name your Boxy:", width / 2, 50, 28.9);
				keyboard.draw();

				fill(0);
				writeText(name, 125, 350, 77.7);

				break;

			default:
				break;
		}
		submit.draw();		
	}

	public void mouseEvent(MouseEvent event) {
		switch(screen) {
			case 0:
				
				for (Button b : colors) {
					if (b.mouseEvent(event)) {
						chosenColor = ((ColorButton)b).getColor();
					}
				}

				if (submit.mouseEvent(event)) {
					if (chosenColor != color(255,255,255)) {
						g.getBoxy().setColor(chosenColor);
						screen += 1;
					}
				}

				break;

			case 1:
				char k = keyboard.mouseEvent(event);
				if (k == '.') {
					if (currentIndex > 0) {
						currentIndex -= 1;
					}
					name[currentIndex] = '_';
				}
				else if (k != '_') {
					if (currentIndex < maxIndex) {
						name[currentIndex] = k;
						currentIndex += 1;
					}
				}

				if (submit.mouseEvent(event)) {
					if (name[0] != '_') {
						g.getBoxy().setName(name);
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