package beans;

public class PointRow {

    private double x,y;
    private int r;
    private Boolean res;

    public PointRow(){}

    public PointRow(double x, double y, int r, boolean res){
        this.x = x;
        this.y = y;
        this.r = r;
        this.res = res;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public int getR() {
        return r;
    }

    public void setR(int r) {
        this.r = r;
    }

    public Boolean getRes() {
        return res;
    }

    public void setRes(Boolean res) {
        this.res = res;
    }
}
