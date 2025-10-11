package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/service_demo_list")
public class ServiceListController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int MIN_ID = 1;
    private static final int MAX_ID = 6;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String serviceIdStr = request.getParameter("id");
        String targetJSP = "/WEB-INF/views/error.jsp";

        try {
            int serviceId = Integer.parseInt(serviceIdStr);

            if (serviceId >= MIN_ID && serviceId <= MAX_ID) {
                targetJSP = "/WEB-INF/views/demo_list/demo" + serviceId + ".jsp";
                request.setAttribute("currentServiceId", serviceId);
            } else {
                request.setAttribute("errorMessage", "ID dịch vụ không hợp lệ. Vui lòng chọn dịch vụ từ 1 đến 6.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID không chính xác.");
        }

        request.getRequestDispatcher(targetJSP).forward(request, response);
    }
}