package writeAction;


import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.io.InputStream;
import java.net.InetSocketAddress;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class WriteActionServer {
    public static void main(String[] args) throws IOException {
        // HTTP 서버 생성
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        server.createContext("/write", new WriteHandler());

        server.setExecutor(null);
        System.out.println("서버가 시작되었습니다: http://localhost:8080/write");
        server.start();
    }

    static class WriteHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            if ("POST".equalsIgnoreCase(exchange.getRequestMethod())) {
                // 폼 데이터 처리
                InputStream inputStream = exchange.getRequestBody();
                String body = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
                Map<String, String> formData = parseFormData(body);

                // 사용자 ID와 익명 여부 처리
                String userID = formData.get("userID");
                String isAnonymous = formData.get("isAnonymous");
                String content = formData.get("content");

                // 유효성 검사
                if (content == null || content.isEmpty()) {
                    sendResponse(exchange, 400, "입력된 내용이 없습니다. 다시 시도해 주세요.");
                    return;
                }

                if (userID == null || userID.isEmpty()) {
                    userID = "익명";
                }

                // DB에 저장 (간단히 예시로 처리, 실제 DB 처리 코드 포함 필요)
                System.out.println("게시글 작성자: " + userID);
                System.out.println("게시글 내용: " + content);
                // 실제 DB 저장 로직을 여기에 추가

                sendResponse(exchange, 200, "게시글이 성공적으로 등록되었습니다.");
            } else {
                sendResponse(exchange, 405, "허용되지 않는 메소드입니다. POST만 지원합니다.");
            }
        }

        private void sendResponse(HttpExchange exchange, int statusCode, String response) throws IOException {
            exchange.sendResponseHeaders(statusCode, response.getBytes().length);
            OutputStream outputStream = exchange.getResponseBody();
            outputStream.write(response.getBytes());
            outputStream.close();
        }

        private Map<String, String> parseFormData(String body) throws IOException {
            Map<String, String> formData = new HashMap<>();
            String[] pairs = body.split("&");
            for (String pair : pairs) {
                String[] keyValue = pair.split("=");
                if (keyValue.length == 2) {
                    String key = URLDecoder.decode(keyValue[0], StandardCharsets.UTF_8);
                    String value = URLDecoder.decode(keyValue[1], StandardCharsets.UTF_8);
                    formData.put(key, value);
                }
            }
            return formData;
        }
    }
}