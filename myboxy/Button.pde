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

	public boolean mouseEvent(MouseEvent event) {
		int mx = event.getX();
		int my = event.getY();
		int left = x - (w / 2);
		int right = x + (w / 2);
		int top = y - (h / 2);
		int bottom = y + (h / 2);

		switch(event.getAction()) {
			case MouseEvent.CLICK:
				return (mx >= left) && (mx <= right) && (my >= top) && (my <= bottom);
			default:
				return false;
		}
	}
};