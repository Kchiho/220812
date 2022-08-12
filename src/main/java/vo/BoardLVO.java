package vo;

public class BoardLVO {
	private int bid;
	private String mid;
	private int checkL;
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getCheckL() {
		return checkL;
	}
	public void setCheckL(int checkL) {
		this.checkL = checkL;
	}
	@Override
	public String toString() {
		return "BoardLVO [bid=" + bid + ", mid=" + mid + ", checkL=" + checkL + "]";
	}

}
