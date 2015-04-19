/******************************************************************************
 * FoodPellet                                                                 *
 ******************************************************************************/
 class FoodPellet {
 	private int y;
 	private int length = 5;
 	private int deg = 0;

 	public FoodPellet(int y) {
 		this.y = y;
 	}

 	public void draw(int x) {
 		fill(139,69,19);
 		pushMatrix();
 		translate(x, y);
 		rotate(radians(deg));
 		rect(0, 0, length, length);
 		popMatrix();

 		y += 3;
 		deg += 5;
 		deg %= 360;
 	}

 	public boolean isEaten(int by) {
 		return y >= by;
 	}
 };