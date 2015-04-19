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