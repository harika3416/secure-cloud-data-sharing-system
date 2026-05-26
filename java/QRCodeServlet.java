//import java.awt.image.BufferedImage;
//import java.io.IOException;
//import javax.imageio.ImageIO;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import com.google.zxing.BarcodeFormat;
//import com.google.zxing.WriterException;
//import com.google.zxing.client.j2se.MatrixToImageWriter;
//import com.google.zxing.common.BitMatrix;
//import com.google.zxing.qrcode.QRCodeWriter;
//
//@WebServlet("/generateQR")
//public class QRCodeServlet extends HttpServlet {
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        try {
//            
//            String upiID = "9247413126@ybl"; 
//            String name = "Narra Raju";
//            String amount = "1.00"; 
//            String transactionNote = "Payment for Service";
//            
//            
//            String upiURL = "upi://pay?pa=" + upiID + "&pn=" + name + "&am=" + amount + "&cu=INR&tn=" + transactionNote;
//
//            QRCodeWriter qrCodeWriter = new QRCodeWriter();
//            BitMatrix bitMatrix = qrCodeWriter.encode(upiURL, BarcodeFormat.QR_CODE, 300, 300);
//            BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(bitMatrix);
//
//            response.setContentType("image/png");
//            ImageIO.write(qrImage, "PNG", response.getOutputStream());
//        } catch (WriterException e) {
//            e.printStackTrace();
//        }
//    }
//}


import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@WebServlet("/generateQR")
public class QRCodeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String upiID = request.getParameter("upiID");
            String note = request.getParameter("note");

            if (upiID == null || note == null || upiID.isEmpty() || note.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input parameters.");
                return;
            }

            // Construct UPI URL
            String upiURL = "upi://pay?pa=" + upiID + "&cu=INR&tn=" + note;

            // Generate QR Code
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(upiURL, BarcodeFormat.QR_CODE, 300, 300);
            BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(bitMatrix);

            // Set content type and write image
            response.setContentType("image/png");
            ImageIO.write(qrImage, "PNG", response.getOutputStream());

        } catch (WriterException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "QR Code generation failed.");
        }
    }
}
     
