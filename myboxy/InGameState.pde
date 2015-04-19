import java.util.Iterator;

/******************************************************************************
 * In Game State                                                              *
 ******************************************************************************/
class InGameState implements State {
	private Game g;
	private Boxy b;
	private ArrayList<FoodPellet> foodPellets;
	private Button feedButton;
	private Button saveButton;
	private Button surveyButton;
	private boolean saved;

	public InGameState(Game g) {
		this.g = g;
		foodPellets = new ArrayList<FoodPellet>();
		feedButton = new Button("Feed", width-75, height / 2 + 100, 100, 50);
		saveButton = new Button("Save", width-75, height/2 - 100 , 100, 50);
		surveyButton = new Button("Take\nSurvey", width-75, height/2, 100, 100);
		saved = false;
		b = g.getBoxy();
	}

	public void initializeItems() {
	}

	public void draw() {
		background(255);
		fill(0);
		writeText(b.getName(), width / 2, 45, 77.7);

		feedButton.draw();
		saveButton.draw();
		surveyButton.draw();

		if(!foodPellets.isEmpty()) {
			for (Iterator<FoodPellet> iterator = foodPellets.iterator(); iterator.hasNext();) {
			    FoodPellet pellet = iterator.next();
			    pellet.draw(b.getX());
			    if (pellet.isEaten(b.getY() - (b.getLength() / 2))) {
			    	b.feed();
			        // Remove the current element from the iterator and the list.
			        iterator.remove();
			    }
			}
		}

		if (b.theMostHappy()) {
			color c = b.getColor();
			fill(255-red(c), 255-blue(c), 255 - green(c));
			pushMatrix();
			translate(b.getX(), b.getY());
			rotate(frameCount / 40.0);
			star(0, 0, 80, 100, 20);
			popMatrix();
			b.draw();
		}
		else if (b.theSaddest()) {
			b.draw();
			filter(GRAY);
		}
		else {
			b.draw();
		}

		fill(200);
		rect(width / 2, 575, width, 50);

		if (saved) {
			fill(255);
			rect(width/2, height/2, width-10, height-10);
			fill(0);
			writeText("Your game has been saved.\n You may now leave the game.", width/2, height/2, 28);
		}
	}

	public void mouseEvent(MouseEvent event) {
		b.mouseEvent(event);
		if (feedButton.mouseEvent(event)) {
			foodPellets.add(new FoodPellet(b.getY() - (height / 2)));
		}
		if (saveButton.mouseEvent(event)) {
			save();
			saved = true;
		}
		if (surveyButton.mouseEvent(event)) {
			link("http://goo.gl/forms/ZhJ8HLMxw4");
		}
	}

	public void star(float x, float y, float radius1, float radius2, int npoints) {
	  float angle = TWO_PI / npoints;
	  float halfAngle = angle/2.0;
	  beginShape();
	  for (float a = 0; a < TWO_PI; a += angle) {
	    float sx = x + cos(a) * radius2;
	    float sy = y + sin(a) * radius2;
	    vertex(sx, sy);
	    sx = x + cos(a+halfAngle) * radius1;
	    sy = y + sin(a+halfAngle) * radius1;
	    vertex(sx, sy);
	  }
	  endShape(CLOSE);
	}

	public void save() {
		String[] data = {
			b.getName(),
			"" + b.getColor(),
			"" + b.getResponsiveness(),
			"" + b.getCloseness(),
			"" + b.getFullness(),
			"" + b.getHappiness(),
			"" + b.getLikesPetting()
		};

		saveStrings(dataFile("savegame.txt"), data);
	}
};