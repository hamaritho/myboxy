/******************************************************************************
 * Game States                                                                *
 ******************************************************************************/
interface State {
	public void draw();
	public void initializeItems();
	public void mouseEvent(MouseEvent event);
}