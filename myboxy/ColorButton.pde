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