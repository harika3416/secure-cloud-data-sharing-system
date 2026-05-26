<!DOCTYPE html>
<html>
<head>
    <title>Generate UPI QR Code</title>
</head>
<body>
    <h2>Enter UPI Details</h2>
    <form id="qrForm" action="generateQR" method="get">
        <label>UPI ID:</label>
        <input type="text" name="upiID" required><br><br>

        <label>Transaction Note:</label>
        <input type="text" name="note" required><br><br>

        <button type="submit">Generate QR Code</button>
    </form>

    <h3>Scan QR Code to Pay</h3>
    <img id="qrImage" src="" alt="QR Code will appear here" width="300" height="300">

    <script>
    document.getElementById("qrForm").addEventListener("submit", function(event) {
        event.preventDefault();
        const form = event.target;
        const params = new URLSearchParams(new FormData(form)).toString();
        document.getElementById("qrImage").src = "generateQR?" + params;
    });
</script>

    <a href="Download.jsp"> <button><b> DonePayment </b></button></a>

</body>
</html>
