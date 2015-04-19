class IdleState implements BoxyState {

	private Boxy boxy;

	public IdleState(Boxy boxy) {
		this.boxy = boxy;
	}

	public void update() {
	}

	public boolean isIdle() {
		return true;
	}
}