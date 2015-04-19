/******************************************************************************
 * How To Play                                                                *
 ******************************************************************************/
class HowToPlayState implements State {
	private Game g;
	private PImage img; 
	private Button backButton;

	public HowToPlayState(Game g) {
		this.g = g;
		img = loadImage("howtoplay.png");
	}

	public void initializeItems() {
		backButton = new MenuButton("Main Menu", width / 2, height-37, 300, 50, g.getTitleState());
	}

	public void draw() {
		image(img, 0, 0);
		backButton.draw();
	}

	public void mouseEvent(MouseEvent event) {
		if (backButton.mouseEvent(event)) {
			g.setState(((MenuButton)backButton).getNextState());
		}
	}
};