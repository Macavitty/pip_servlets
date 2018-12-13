import beans.PointsBean;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String x = request.getParameter("x_input");
        String y = request.getParameter("y_input");
        String r = request.getParameter("r_input");
        if (x == null || y == null || r == null) {

            request.getRequestDispatcher("").forward(request, response);
            return;
        }
        if (request.getSession().getAttribute("results") == null)
            request.getSession().setAttribute("results", new PointsBean());
        request.getRequestDispatcher("check").forward(request,response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

