package controller;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/doctor_list")
public class DoctorListController extends HttpServlet {
    private static final long serialVersionUID = 1L;


    private static final int MIN_ID = 1;
    private static final int MAX_ID = 6;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String serviceIdStr = request.getParameter("id");
        String targetJSP = "/WEB-INF/views/error.jsp";

        try {
            int doctorID = Integer.parseInt(serviceIdStr);

            if (doctorID >= MIN_ID && doctorID <= MAX_ID) {
                targetJSP = "/WEB-INF/views/demo_list/demo_list_doctor/doctor" + doctorID + ".jsp";
                request.setAttribute("currentDoctorId", doctorID);
            } else {
                request.setAttribute("errorMessage", "ID dịch vụ không hợp lệ. Vui lòng chọn dịch vụ từ 1 đến 6.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID không chính xác.");
        }

        request.getRequestDispatcher(targetJSP).forward(request, response);
    }
}

