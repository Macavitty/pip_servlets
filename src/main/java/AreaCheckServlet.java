import beans.PointRow;
import beans.PointsBean;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PointRow row = new PointRow();
        try {
            double x, y;
            int r;
            x = Double.parseDouble(request.getParameter("x_input"));
            y = Double.parseDouble(request.getParameter("y_input"));
            r = Integer.parseInt(request.getParameter("r_input"));
            if (!checkRXY(x,y,r)){
                throw new IllegalArgumentException();
            }
            row.setRes(checkArea(x,y,r));
            row.setX(x);
            row.setY(y);
            row.setR(r);
            request.setAttribute("result", checkArea(x,y,r));

        } catch (Exception ignore) {
            row.setRes(null);
            request.setAttribute("isInputCorrect", false);
        }

        ((PointsBean)request.getSession().getAttribute("results")).addRow(row);
        request.getRequestDispatcher("/table.jsp").forward(request, response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    private boolean checkRXY(double x, double y, double r) {
        return (r >= 1 && r <= 5 && x >= -5 && x <= 5 && y > -5 && y < 5);
    }

    private boolean checkArea(double x, double y, double r) {
        if (x <= 0) {
            if (y >= 0 && y <= r && x >= -r) {
                return true;
            } else return y <= 0 && (y >= -2 * x - r);
        } else return Math.sqrt(x * x + y * y) <= r && y >= 0;
    }
}
