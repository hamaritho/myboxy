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

	public char mouseEvent(MouseEvent event) {
		for(Key k : keys) {
			if(k.mouseEvent(event)) {
				return k.getLetter();
			}
		}
		if(backspace.mouseEvent(event)) {
			return backspace.getLetter();
		}
		return '_';
	}
};