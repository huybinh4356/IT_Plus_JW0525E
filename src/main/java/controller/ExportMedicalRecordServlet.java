package controller;

import Dao.MedicalRecordDao;
import model.MedicalRecords;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

// Đặt đường dẫn URL để gọi Servlet này
@WebServlet("/export-medical-records")
public class ExportMedicalRecordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. Lấy dữ liệu từ Database thông qua DAO
        MedicalRecordDao dao = MedicalRecordDao.getInstance();
        List<MedicalRecords> list = dao.findAllForExport();

        // 2. Thiết lập Header phản hồi để trình duyệt hiểu đây là file Excel tải về
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        // Tên file khi tải về sẽ là DanhSach_BenhAn.xlsx
        response.setHeader("Content-Disposition", "attachment; filename=DanhSach_BenhAn.xlsx");

        // 3. Khởi tạo Workbook (File Excel)
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Bệnh Án");

            // --- A. TẠO DÒNG TIÊU ĐỀ (HEADER) ---
            Row headerRow = sheet.createRow(0);

            // Danh sách các cột (Đã bỏ cột Bác sĩ)
            String[] columns = {"Mã BA", "Tên Bệnh Nhân", "Chẩn Đoán", "Điều Trị", "Ngày Tạo", "Ghi Chú"};

            // Tạo Style cho Header (In đậm, nền xám, có khung viền)
            CellStyle headerStyle = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            font.setFontHeightInPoints((short) 12);
            headerStyle.setFont(font);
            headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            // Gán giá trị và Style cho các ô tiêu đề
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);
            }

            // --- B. ĐỔ DỮ LIỆU VÀO CÁC DÒNG (DATA) ---
            int rowNum = 1;

            // Định dạng ngày tháng
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            // Style cho các ô dữ liệu (Có khung viền)
            CellStyle dataStyle = workbook.createCellStyle();
            dataStyle.setBorderBottom(BorderStyle.THIN);
            dataStyle.setBorderTop(BorderStyle.THIN);
            dataStyle.setBorderLeft(BorderStyle.THIN);
            dataStyle.setBorderRight(BorderStyle.THIN);

            for (MedicalRecords rec : list) {
                Row row = sheet.createRow(rowNum++);

                // Cột 0: Mã Bệnh Án
                createCell(row, 0, String.valueOf(rec.getRecord_id()), dataStyle);

                // Cột 1: Tên Bệnh Nhân (Check null cẩn thận)
                String patientName = "N/A";
                if (rec.getPatient_id() != null && rec.getPatient_id().getFull_name() != null) {
                    patientName = rec.getPatient_id().getFull_name();
                }
                createCell(row, 1, patientName, dataStyle);

                // Cột 2: Chẩn đoán
                createCell(row, 2, rec.getDiagnosis(), dataStyle);

                // Cột 3: Điều trị
                createCell(row, 3, rec.getTreatment(), dataStyle);

                // Cột 4: Ngày tạo
                String dateStr = "";
                if (rec.getCreated_at() != null) {
                    dateStr = rec.getCreated_at().format(formatter);
                }
                createCell(row, 4, dateStr, dataStyle);

                // Cột 5: Ghi chú
                createCell(row, 5, rec.getNotes(), dataStyle);
            }

            // --- C. TỰ ĐỘNG CĂN CHỈNH ĐỘ RỘNG CỘT ---
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // 4. Ghi Workbook ra luồng Output của Response
            OutputStream out = response.getOutputStream();
            workbook.write(out);

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi, in ra trình duyệt để biết
            response.getWriter().println("<h1>Lỗi khi xuất file Excel: " + e.getMessage() + "</h1>");
        }
    }

    // Hàm phụ để tạo ô dữ liệu nhanh gọn, tránh lặp code
    private void createCell(Row row, int column, String value, CellStyle style) {
        Cell cell = row.createCell(column);
        cell.setCellValue(value != null ? value : ""); // Nếu null thì để trống
        cell.setCellStyle(style);
    }
}