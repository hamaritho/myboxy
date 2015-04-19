/******************************************************************************
 * Boxy                                                                       *
 ******************************************************************************/
class Boxy {

	//Interaction Values--------------------------------------------------------
	private int responsiveness;
	private final int MIN_RESPONSIVENESS = 1;
	private final int MAX_RESPONSIVENESS = 10;

	private int closeness;
	private final int MIN_CLOSENESS = 1;
	private final int MAX_CLOSENESS = 10;

	private int fullness;
	private final int MIN_FULLNESS = 0;
	private final int MAX_FULLNESS = 100;
	private final int FULLNESS_INCREASE_DELTA = 10;
	private final int FULLNESS_DECREASE_DELTA = 1;

	private int happiness;
	private final int MIN_HAPPINESS = 0;
	private final int MAX_HAPPINESS = 100;
	private final int HAPPINESS_DELTA = 10;

	private int reactionValue;

	private int sadTime;
	private int MAX_SADTIME = 1000;
	private int happyTime;
	private int MAX_HAPPYTIME = 1000;

	private final int DELTA = 1;

	private boolean likesPetting;

	//Properties----------------------------------------------------------------
	private String name;
	private color c;

	private final int LENGTH = 100;

	private int x;
	private final int MIN_X = LENGTH / 2;
	private final int MAX_X = width-LENGTH;
	
	private int y;
	private final int MIN_Y = LENGTH / 2;
	private final int MAX_Y = height-LENGTH;

	//Animation-----------------------------------------------------------------
	private int dragTime;
	private final int MAX_DRAGTIME = 50;

	private int stillTime;
	private final int MAX_STILLTIME = 150;

	private int noInteractionTime;
	private final int MAX_NOINTERACTIONTIME = 500;

	private BoxyState jumpState;
	private BoxyState slideState;
	private BoxyState bounceState;
	private BoxyState shakeState;
	private BoxyState idleState;
	private BoxyState currentState;

	//Constructor---------------------------------------------------------------
	public Boxy() {
		//Interaction Values
		responsiveness = int(random(MIN_RESPONSIVENESS,MAX_RESPONSIVENESS));
		closeness = int(random(MIN_CLOSENESS, MAX_CLOSENESS));
		fullness = int(random(MIN_FULLNESS, MAX_FULLNESS));
		happiness = int(random(MIN_HAPPINESS, MAX_HAPPINESS));

		reactionValue = responsiveness * closeness;
		sadTime = 0;
		happyTime = 0;

		likesPetting = random(100) > 50;

		//Properties
		name = "Boxy";
		c = color(int(random(255)), int(random(255)), int(random(255)));
		x = width / 2;
		y = MAX_Y;

		//Animation
		jumpState = new JumpState(this);
		slideState = new SlideState(this);
		bounceState = new BounceState(this);
		shakeState = new ShakeState(this);
		idleState = new IdleState(this);
		currentState = idleState;

		dragTime = 0;

		stillTime = 0;
	}

	//Draw----------------------------------------------------------------------
	public void draw() {
		fill(c);		
		rect(x, y, LENGTH, LENGTH);

		tick();
	}

	//Tick----------------------------------------------------------------------
	public void tick() {
		decreaseFullness();
		increaseNoInteractionTime();
		updateHappiness();
		updateCloseness();
		updateReactionValue();
		updateAction();
		currentState.update();
 	}

 	//Getters, Setters, and Modifiers
 	public boolean getLikesPetting() {
 		return likesPetting;
 	}

 	public void setLikesPetting(boolean likes) {
 		likesPetting = likes;
 	}

	public String getName() {
		return name;
	}

	public void setName(char[] letters) {
		name = "";
		for (char letter : letters) {

			if (letter != '_') {
				name += letter;
			}

		}
	}

	public void setName(String name) {
		this.name = name;
	}

	public color getColor() {
		return c;
	}

	public void setColor(color c) {
		this.c = c;
	}

	public int getResponsiveness() {
		return responsiveness;
	}

	public void setResponsiveness(int r) {
		responsiveness = r;
	}

	public int getCloseness() {
		return closeness;
	}

	public void setCloseness(int c) {
		closeness = c;
	}

	public void decreaseCloseness() {
		if (closeness > MIN_CLOSENESS) {
			closeness -= DELTA;
		}
	}

	public void increaseCloseness() {
		if (closeness < MAX_CLOSENESS) {
			closeness += DELTA;
		}
	}

	public void updateCloseness() {
		if (sadTime > MAX_SADTIME && closeness > MIN_CLOSENESS) {

			zeroSadTime();
			decreaseCloseness();

		}
		else if (happyTime > MAX_HAPPYTIME && closeness < MAX_CLOSENESS) {

			zeroHappyTime();
			increaseCloseness();

		}
	}

	public int getFullness() {
		return fullness;
	}

	public void setFullness(int f) {
		fullness = f;
	}

	public void decreaseFullness() {
		if (fullness > MIN_FULLNESS && frameCount % 420 == 0) {
			fullness -= FULLNESS_DECREASE_DELTA;
		}
		if (fullness < MIN_FULLNESS) {
			fullness = MIN_FULLNESS;
		}
	}

	public void increaseFullness() {
		if (fullness < MAX_FULLNESS) {
			fullness += FULLNESS_INCREASE_DELTA;
		}
		if (fullness > MAX_FULLNESS) {
			fullness = MAX_FULLNESS;
		}
	}

	public int getHappiness() {
		return happiness;
	}

	public void setHappiness(int h) {
		happiness = h;
	}

	public void zeroHappiness() {
		happiness = 0;
	}

	public void halfHappiness() {
		happiness = MAX_HAPPINESS / 2;
	}

	public void decreaseHappiness() {
		if (happiness > MIN_HAPPINESS) {
			happiness -= HAPPINESS_DELTA;			
		}
	}

	public void increaseHappiness() {
		if (happiness < MAX_HAPPINESS) {
			happiness += HAPPINESS_DELTA;
		}
	}

	public void updateHappiness() {
		if (fullness < MAX_FULLNESS / 4) {
			zeroHappiness();

		} else if (fullness < MAX_FULLNESS / 2) {

			if (happiness > MAX_HAPPINESS / 2) {
				halfHappiness();
			} else {
				decreaseHappiness();
			}
		} else if (noInteractionTime > MAX_NOINTERACTIONTIME) {
			zeroNoInteractionTime();
			decreaseHappiness();
		}

		if (happiness < MAX_HAPPINESS / 2) {
			increaseSadTime();

		}
		else {
			increaseHappyTime();

		}
	}

	public void zeroSadTime() {
		sadTime = 0;
	}

	public void increaseSadTime() {
		sadTime += DELTA;
	}

	public void zeroHappyTime() {
		happyTime = 0;
	}

	public void increaseHappyTime() {
		happyTime += DELTA;
	}

	 public int getX() {
		return x;
	}

	public void changeX(int delta) {
		x += delta;
	}

	public int getY() {
		return y;
	}

	public void changeY(int delta) {
		y += delta;
	}

	public void setPosition(int x, int y) {
		this.x = x;
		this.y = y;
	}

	public int getLength() {
		return LENGTH;
	}

	public int getReactionValue() {
		return reactionValue;
	}

	public void updateReactionValue() {
		reactionValue = responsiveness * closeness;
	}

	public void zeroNoInteractionTime() {
		noInteractionTime = 0;
	}

	public void increaseNoInteractionTime() {
		noInteractionTime += DELTA;
	}

	public boolean theMostHappy() {
		return happiness >= MAX_HAPPINESS * 0.9;
	}

	public boolean theSaddest() {
		return happiness <= MAX_HAPPINESS * 0.1;
	}

	public void mouseEvent(MouseEvent event) {
		int mx = event.getX();
		int my = event.getY();
		int left = x - (LENGTH / 2);
		int right = x + (LENGTH / 2);
		int top = y - (LENGTH / 2);
		int bottom = y + (LENGTH / 2);

		if (mx >= left && mx <= right && my >= top && my <= bottom) {
			switch(event.getAction()) {
				case MouseEvent.CLICK:
					if (likesPetting) {
						decreaseHappiness();
						
						if (currentState.isIdle()) {
							currentState = slideState;
						}
					} else {
						increaseHappiness();

						if (currentState.isIdle()) {
							currentState = jumpState;
						}
					}
					break;
				case MouseEvent.DRAG:
					dragTime += DELTA;

					if (dragTime > MAX_DRAGTIME) {
						if (likesPetting) {
							increaseHappiness();

							dragTime = 0;
							if (currentState.isIdle()) {
								currentState = jumpState;
							}
						} else {
							decreaseHappiness();

							dragTime = 0;
							if (currentState.isIdle()) {
								currentState = slideState;
							}
						}
					}
					break;
				default:
					break;
			}
			zeroNoInteractionTime();
		}
	}

	public void feed() {
		if (fullness >= MAX_FULLNESS) {
			decreaseHappiness();

			if (currentState.isIdle()) {
				currentState = slideState;
			}
		} else {
			increaseHappiness();

			if (currentState.isIdle()) {
				currentState = jumpState;
			}
		}
		increaseFullness();
		
	}

	public void updateAction() {
		if (currentState.isIdle()) {
			stillTime += DELTA;
			if(stillTime > MAX_STILLTIME) {
				if (happiness > MAX_HAPPINESS / 2) {
					currentState = bounceState;
				} else {
					currentState = shakeState;
				}
			}
		} else {
			stillTime = 0;
		}
	}

	public BoxyState getJumpState() {
		return jumpState;
	}

	public BoxyState getSlideState() {
		return slideState;
	}

	public BoxyState getBounceState() {
		return bounceState;
	}

	public BoxyState getShakeState() {
		return shakeState;
	}

	public BoxyState getIdleState() {
		return idleState;
	}

	public void setState(BoxyState state) {
		currentState = state;
	}

	public int getMaxY() {
		return MAX_Y;
	}
};