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

	public void initializeItems() {
		buttons[0] = new MenuButton("New Game", width / 2, 150, 300, 50, this.g.getNewGameState());
		buttons[1] = new MenuButton("Load Game", width / 2, 250, 300, 50, this.g.getInGameState());
		buttons[2] = new MenuButton("How To Play", width / 2, 350, 300, 50, this.g.getHowToPlayState());
		buttons[3] = new MenuButton("Take Survey", width / 2, 450, 300, 50, this.g.getSurveyState());
	}

	public void draw() {
		background(255);
		String t = "My Boxy";
		fill(0);

		writeText(t, width / 2, 50, 77.7);

		for(Button b : buttons) {
			b.draw();
		}
	}

	public void mouseEvent(MouseEvent event) {

		if (buttons[0].mouseEvent(event)) {
			if (random(100) > 50) {
				g.setState(((MenuButton)buttons[0]).getNextState());
			} else {
				g.setState(g.getInGameState());
			}
			
		}

		if (buttons[1].mouseEvent(event)) {
			if(load()) {
				g.setState(((MenuButton)buttons[1]).getNextState());
			}			
		}

		if (buttons[2].mouseEvent(event)) {
			g.setState(((MenuButton)buttons[2]).getNextState());
		}

		if (buttons[3].mouseEvent(event)) {
			g.setState(((MenuButton)buttons[3]).getNextState());
		}
	}

	public boolean load() {
		File f = dataFile("savegame.txt");

		if (f.exists()) {
			String[] lines = loadStrings("savegame.txt");
			String name = lines[0];
			color c = color(int(lines[1]));
			int responsiveness = int(lines[2]);
			int closeness = int(lines[3]);
			int fullness = int(lines[4]);
			int happiness = int(lines[5]);

			g.getBoxy().setName(name);
			g.getBoxy().setColor(c);
			g.getBoxy().setResponsiveness(responsiveness);
			g.getBoxy().setCloseness(closeness);
			g.getBoxy().setFullness(fullness);
			g.getBoxy().setHappiness(happiness);

			return true;
		}

		return false;
	}
};