<%@page import="java.math.BigInteger"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat, java.io.*, java.security.*, javax.crypto.*, javax.crypto.spec.SecretKeySpec, org.bouncycastle.util.encoders.Base64" %>
<%@ include file="connect.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Data Provider :: SDS</title>
    <link href="templatemo_style.css" rel="stylesheet" type="text/css" />
    <style>
        .style2 {
            color: #FF0000;
            font-weight: bold;
            font-size: 36px;
        }
    </style>
</head>
<body>
<div id="templatemo_wrapper">
    <div id="templatemo_left_column">
        <div id="site_title">
            <h1><a href="http://www.tmksinfotech.com" target="_parent">Enhanced Key Agreement Protocol Resilient to Randomness Weakness in Cloud Systems</a></h1>
        </div>
        <div id="templatemo_sidebar">
            <div class="service_section">
                <h2>Owner</h2>
                <ul class="service_list">
                    <li><a href="#">Upload Data</a></li>
                    <li><a href="#">View Uploaded Files</a></li>
                    <li><a href="#">View Secret Key Generated</a></li>
                    <li><a href="#">Update Ciphertext</a></li>
                    <li><a href="index.html">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div id="templatemo_right_column">
        <div id="templatemo_menu">
            <ul>
                <li><a href="#">Home</a></li>
                <li><a href="DataProviderMain.jsp" class="current">Owner</a></li>
                <li><a href="#">CSP</a></li>
                <li><a href="#">KGC</a></li>
                <li><a href="#">Users</a></li>
            </ul>
        </div>

        <div id="templatemo_content_wrapper">
            <div id="templatemo_content">
                <h2>Upload Data</h2>
                <% 
                try {
                    String file = request.getParameter("tt");
                    String content = request.getParameter("text");
                    String encryptionKey = "ef50a0ef2c3e3a5f";
                    String filename = System.getProperty("java.io.tmpdir") + "/uploaded_file.txt";
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                    String datetime = sdf.format(new Date());
                    String owner = (String) application.getAttribute("owner");
                    
                    // Save file details to the database
                    connection.createStatement().executeUpdate("INSERT INTO ownerfiles(fname, owner, ct, dt) VALUES ('"+file+"', '"+owner+"', '"+content+"', '"+datetime+"')");
                    connection.createStatement().executeUpdate("INSERT INTO transaction(user, fname, task, dt) VALUES ('"+owner+"', '"+file+"', 'Upload', '"+datetime+"')");
                    
                    // Encrypt the content
                    Key key = new SecretKeySpec(encryptionKey.getBytes(), "AES");
                    Cipher cipher = Cipher.getInstance("AES");
                    cipher.init(Cipher.ENCRYPT_MODE, key);
                    String encryptedContent = new String(Base64.encode(content.getBytes()));
                    String encodedFilename = new String(Base64.encode(file.getBytes()));
                    
                    // Save original content to a file
                    try (PrintWriter writer = new PrintWriter(new FileOutputStream(filename))) {
                        writer.print(content);
                    }
                    
                    // Generate SHA-1 Hash
                    MessageDigest md = MessageDigest.getInstance("SHA-1");
                    try (FileInputStream fis = new FileInputStream(filename); DigestInputStream dis = new DigestInputStream(fis, md)) {
                        while (dis.read() != -1) {} // Read file to compute hash
                    }
                    String hashValue = new BigInteger(1, md.digest()).toString(16);
                %>
                <form action="Upload1.jsp" method="post">
                    <table border="1" align="center">
                        <tr>
                            <td>File Name:</td>
                            <td><input type="text" name="t42" value="<%= encodedFilename %>" readonly /></td>
                        </tr>
                        <tr>
                            <td>Encrypted Content:</td>
                            <td><textarea name="text2" cols="50" rows="15" readonly><%= encryptedContent %></textarea></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="Upload" /></td>
                        </tr>
                    </table>
                </form>
                <% 
                    connection.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } 
                %>
            </div>
        </div>
    </div>
</div>
</body>
</html>
