import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

  class UDPServer {

    public static void main(String[] args) {
        try {
            // Create a DatagramSocket that listens on port 9876
            DatagramSocket serverSocket = new DatagramSocket(9876);
            byte[] receiveData = new byte[1024];

            System.out.println("Server is running and waiting for messages...");

            while (true) {
                // Create a DatagramPacket to receive data from the client
                DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
                serverSocket.receive(receivePacket);

                // Extract data from the received packet
                String message = new String(receivePacket.getData(), 0, receivePacket.getLength());
                System.out.println("Received from client: " + message);

                // Respond to the client
                String responseMessage = "Acknowledged: " + message;
                byte[] responseData = responseMessage.getBytes();

                InetAddress clientAddress = receivePacket.getAddress();
                int clientPort = receivePacket.getPort();

                // Send response back to client
                DatagramPacket sendPacket = new DatagramPacket(responseData, responseData.length, clientAddress, clientPort);
                serverSocket.send(sendPacket);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
