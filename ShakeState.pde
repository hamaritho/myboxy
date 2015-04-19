class ShakeState implements BoxyState {

	private Boxy boxy;
	private int left;
	private int right;
	private int stride;
	private int direction;
	private int hitSides;

	public ShakeState(Boxy boxy) {
		this.boxy = boxy;
		stride = -1;
		direction = -1;
		left = (width / 2) - 5;
		right = (width / 2) + 5;
	}

	public void update() {
		boxy.changeX(direction * stride);

		if (boxy.getX() < left) {
			direction *= -1;
			boxy.setPosition(left, boxy.getY());
			hitSides += 1;
		} else if (boxy.getX() > right) {
			direction *= -1;
			boxy.setPosition(right, boxy.getY());
			hitSides += 1;
		} else if (hitSides >= 2 && boxy.getX() <= (width/2)) {
			hitSides = 0;
			boxy.setPosition(width / 2, boxy.getY());
			boxy.setState(boxy.getIdleState());
		}
	}

	public boolean isIdle() {
		return false;
	}
}