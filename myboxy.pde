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

void mouseClicked(MouseEvent event) {
	game.mousePressed(event);
}

void mouseDragged(MouseEvent event) {
	game.mousePressed(event);
}

void keyPressed() {
	if (key == ESC) {
		println("Exiting");
		exit();
	}
}