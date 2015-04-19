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