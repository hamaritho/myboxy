class JumpState implements BoxyState {

	private Boxy boxy;
	private int jumpHeight;
	private int stride;
	private int direction;

	public JumpState(Boxy boxy) {
		this.boxy = boxy;
		jumpHeight = boxy.getMaxY() - boxy.getReactionValue();
		stride = boxy.getReactionValue() / 10;
		direction = -1;
	}

	public void update() {
		boxy.changeY(stride * direction);

		if (boxy.getY() < jumpHeight) {
			direction *= -1;
			boxy.setPosition(boxy.getX(), jumpHeight);
		}
		else if (boxy.getY() > boxy.getMaxY()) {
			direction *= -1;
			boxy.setPosition(boxy.getX(), boxy.getMaxY());
			boxy.setState(boxy.getIdleState());
		}

		jumpHeight = boxy.getMaxY() - boxy.getReactionValue();
		stride = boxy.getReactionValue() / 10;
	}

	public boolean isIdle() {
		return false;
	}
}