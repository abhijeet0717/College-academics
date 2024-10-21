import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

  class UDPClient {

    public static void main(String[] args) {
        try {
            // Create a DatagramSocket
            DatagramSocket clientSocket = new DatagramSocket();

            // Get the server's IP address and port
            InetAddress serverAddress = InetAddress.getByName("localhost");
            int serverPort = 9876;

            // Data to send to the server
            String message = "Hello, Server!";
            byte[] sendData = message.getBytes();

            // Create a DatagramPacket to send the data to the server
            DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, serverAddress, serverPort);
            clientSocket.send(sendPacket);

            // Create a buffer to receive the server's response
            byte[] receiveData = new byte[1024];

            // Receive response from the server
            DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
            clientSocket.receive(receivePacket);

            // Extract response data
            String responseMessage = new String(receivePacket.getData(), 0, receivePacket.getLength());
            System.out.println("Received from server: " + responseMessage);

            // Close the socket
            clientSocket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
