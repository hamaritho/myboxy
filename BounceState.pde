class BounceState implements BoxyState {

	private Boxy boxy;
	private int bounceHeight;
	private int stride;
	private int direction;

	public BounceState(Boxy boxy) {
		this.boxy = boxy;
		direction = -1;
		stride = 1;
		bounceHeight = boxy.getMaxY() - 5;
	}

	public void update() {
		boxy.changeY(direction * stride);

		if (boxy.getY() < bounceHeight) {
			direction *= -1;
			boxy.setPosition(boxy.getX(), bounceHeight);
		} else if (boxy.getY() > boxy.getMaxY()) {
			direction *= -1;
			boxy.setPosition(boxy.getX(), boxy.getMaxY());
			boxy.setState(boxy.getIdleState());
		}
	}

	public boolean isIdle() {
		return false;
	}
}