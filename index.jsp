<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Random" %>

<%! // Helper methods as declarations
public int[] generateArray(int size) {
    int[] array = new int[size];
    Random rand = new Random();
    for (int i = 0; i < size; i++) {
        array[i] = rand.nextInt(100) + 1;
    }
    return array;
}


public String getLinearSearchSteps(int[] array, int target) {
    StringBuilder json = new StringBuilder();
    json.append("[");
    for (int i = 0; i < array.length; i++) {
        json.append("{");
        json.append("\"index\":").append(i).append(",");
        json.append("\"value\":").append(array[i]).append(",");
        json.append("\"status\":\"Checking index ").append(i).append(" : Value ").append(array[i]).append("\",");
        if (array[i] == target) {
            json.append("\"type\":\"found\"}");
            json.append("]");
            return json.toString();
        } else {
            json.append("\"type\":\"check\"}");
        }
        if (i < array.length - 1) {
            json.append(",");
        }
    }
    json.append(",{\"index\":-1,\"status\":\"Target ").append(target)
        .append(" not found.\",\"type\":\"not_found\"}");
    json.append("]");
    return json.toString();
}

public String getBinarySearchSteps(int[] array, int target) {
    int[] sortedArray = Arrays.copyOf(array, array.length);
    Arrays.sort(sortedArray);
    StringBuilder json = new StringBuilder();
    json.append("[{");
    json.append("\"type\":\"sort\",");
    json.append("\"sortedArray\":").append(arrayToJson(sortedArray)).append(",");
    json.append("\"status\":\"Array sorted for Binary Search.\"");
    json.append("},");
    int left = 0, right = sortedArray.length - 1;
    boolean found = false;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        json.append("{");
        json.append("\"index\":").append(mid).append(",");
        json.append("\"left\":").append(left).append(",");
        json.append("\"right\":").append(right).append(",");
        json.append("\"value\":").append(sortedArray[mid]).append(",");
        json.append("\"status\":\"Checking middle index ").append(mid)
            .append(" : Value ").append(sortedArray[mid]).append("\",");
        if (sortedArray[mid] == target) {
            json.append("\"type\":\"found\"}");
            found = true;
            break;
        } else {
            json.append("\"type\":\"check\"}");
        }
        if (sortedArray[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
        json.append(",");
    }
    if (!found) {
        json.append("{\"index\":-1,\"status\":\"Target ").append(target)
            .append(" not found.\",\"type\":\"not_found\"}");
    }
    json.append("]");
    return json.toString();
}

public String getJumpSearchSteps(int[] array, int target) {
    int[] sortedArray = Arrays.copyOf(array, array.length);
    Arrays.sort(sortedArray);
    StringBuilder json = new StringBuilder();
    json.append("[{");
    json.append("\"type\":\"sort\",");
    json.append("\"sortedArray\":").append(arrayToJson(sortedArray)).append(",");
    json.append("\"status\":\"Array sorted for Jump Search.\"");
    json.append("},");
    
    int n = sortedArray.length;
    int step = (int) Math.floor(Math.sqrt(n));
    int prev = 0;
    
    // Jump loop
    while (sortedArray[Math.min(step, n) - 1] < target) {
        json.append("{");
        json.append("\"index\":").append(Math.min(step, n) - 1).append(",");
        json.append("\"value\":").append(sortedArray[Math.min(step, n) - 1]).append(",");
        json.append("\"status\":\"Jumping to index ").append(Math.min(step, n) - 1)
            .append(" : Value ").append(sortedArray[Math.min(step, n) - 1]).append("\",");
        json.append("\"type\":\"check\"},");
        
        prev = step;
        step += (int) Math.floor(Math.sqrt(n));
        if (prev >= n) {
            json.append("{\"index\":-1,\"status\":\"Target ").append(target)
                .append(" not found.\",\"type\":\"not_found\"}");
            json.append("]");
            return json.toString();
        }
    }
    
    // Linear search loop
    while (sortedArray[prev] < target) {
        json.append("{");
        json.append("\"index\":").append(prev).append(",");
        json.append("\"value\":").append(sortedArray[prev]).append(",");
        json.append("\"status\":\"Linear searching at index ").append(prev)
            .append(" : Value ").append(sortedArray[prev]).append("\",");
        json.append("\"type\":\"check\"},");
        
        prev++;
        if (prev == Math.min(step, n)) {
            json.append("{\"index\":-1,\"status\":\"Target ").append(target)
                .append(" not found.\",\"type\":\"not_found\"}");
            json.append("]");
            return json.toString();
        }
    }
    
    // Check if found
    json.append("{");
    json.append("\"index\":").append(prev).append(",");
    json.append("\"value\":").append(sortedArray[prev]).append(",");
    json.append("\"status\":\"Checking index ").append(prev)
        .append(" : Value ").append(sortedArray[prev]).append("\",");
        
    if (sortedArray[prev] == target) {
        json.append("\"type\":\"found\"}");
    } else {
        json.append("\"type\":\"check\"},");
        json.append("{\"index\":-1,\"status\":\"Target ").append(target)
            .append(" not found.\",\"type\":\"not_found\"}");
    }
    json.append("]");
    return json.toString();
}

public String getInterpolationSearchSteps(int[] array, int target) {
    int[] sortedArray = Arrays.copyOf(array, array.length);
    Arrays.sort(sortedArray);
    StringBuilder json = new StringBuilder();
    json.append("[{");
    json.append("\"type\":\"sort\",");
    json.append("\"sortedArray\":").append(arrayToJson(sortedArray)).append(",");
    json.append("\"status\":\"Array sorted for Interpolation Search.\"");
    json.append("},");
    
    int lo = 0, hi = (sortedArray.length - 1);
    boolean found = false;
    
    while (lo <= hi && target >= sortedArray[lo] && target <= sortedArray[hi]) {
        if (lo == hi) {
            json.append("{");
            json.append("\"index\":").append(lo).append(",");
            json.append("\"left\":").append(lo).append(",");
            json.append("\"right\":").append(hi).append(",");
            json.append("\"value\":").append(sortedArray[lo]).append(",");
            json.append("\"status\":\"Checking index ").append(lo).append("\",");
             if (sortedArray[lo] == target) {
                 json.append("\"type\":\"found\"}");
                 found = true;
             } else {
                 json.append("\"type\":\"check\"}");
             }
             break;
        }
        
        // Probe position formula
        int pos = lo + (((hi - lo) / (sortedArray[hi] - sortedArray[lo])) * (target - sortedArray[lo]));
        
        json.append("{");
        json.append("\"index\":").append(pos).append(",");
        json.append("\"left\":").append(lo).append(",");
        json.append("\"right\":").append(hi).append(",");
        json.append("\"value\":").append(sortedArray[pos]).append(",");
        json.append("\"status\":\"Probing index ").append(pos)
            .append(" : Value ").append(sortedArray[pos]).append("\",");
            
        if (sortedArray[pos] == target) {
            json.append("\"type\":\"found\"}");
            found = true;
            break;
        } else {
             json.append("\"type\":\"check\"}");
        }
        json.append(",");
        
        if (sortedArray[pos] < target) {
            lo = pos + 1;
        } else {
            hi = pos - 1;
        }
    }
    
    if (!found) {
        if (json.charAt(json.length()-1) != '}') json.append("}"); 
        if (json.charAt(json.length()-1) == ',') json.deleteCharAt(json.length()-1); 
        
        json.append(",{\"index\":-1,\"status\":\"Target ").append(target)
            .append(" not found.\",\"type\":\"not_found\"}");
    }
    json.append("]");
    return json.toString();
}

public String getExponentialSearchSteps(int[] array, int target) {
    int[] sortedArray = Arrays.copyOf(array, array.length);
    Arrays.sort(sortedArray);
    StringBuilder json = new StringBuilder();
    json.append("[{");
    json.append("\"type\":\"sort\",");
    json.append("\"sortedArray\":").append(arrayToJson(sortedArray)).append(",");
    json.append("\"status\":\"Array sorted for Exponential Search.\"");
    json.append("},");
    
    if (sortedArray[0] == target) {
        json.append("{\"index\":0,\"value\":").append(sortedArray[0])
            .append(",\"status\":\"Found at index 0\",\"type\":\"found\"}]");
        return json.toString();
    }
    
    int i = 1;
    while (i < sortedArray.length && sortedArray[i] <= target) {
        json.append("{");
        json.append("\"index\":").append(i).append(",");
        json.append("\"value\":").append(sortedArray[i]).append(",");
        json.append("\"status\":\"Checking range boundary at index ").append(i)
            .append(" : Value ").append(sortedArray[i]).append("\",");
        
        if (sortedArray[i] == target) {
             json.append("\"type\":\"found\"}");
             json.append("]");
             return json.toString();
        }
        json.append("\"type\":\"check\"},");
        i = i * 2;
    }
    
    // Binary search part
    int left = i / 2;
    int right = Math.min(i, sortedArray.length - 1);
    
    json.append("{\"index\":-1,\"status\":\"Binary searching in range [")
        .append(left).append(", ").append(right).append("]\",\"type\":\"info\"},");

    boolean found = false;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        json.append("{");
        json.append("\"index\":").append(mid).append(",");
        json.append("\"left\":").append(left).append(",");
        json.append("\"right\":").append(right).append(",");
        json.append("\"value\":").append(sortedArray[mid]).append(",");
        json.append("\"status\":\"Binary Search: Checking index ").append(mid)
            .append(" : Value ").append(sortedArray[mid]).append("\",");
        if (sortedArray[mid] == target) {
            json.append("\"type\":\"found\"}");
            found = true;
            break;
        } else {
            json.append("\"type\":\"check\"}");
        }
        if (sortedArray[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
        json.append(",");
    }
    if (!found) {
        json.append("{\"index\":-1,\"status\":\"Target ").append(target)
            .append(" not found.\",\"type\":\"not_found\"}");
    }
    json.append("]");
    return json.toString();
}


public String getFibonacciSearchSteps(int[] array, int target) {
    int[] sortedArray = Arrays.copyOf(array, array.length);
    Arrays.sort(sortedArray);
    StringBuilder json = new StringBuilder();
    json.append("[{");
    json.append("\"type\":\"sort\",");
    json.append("\"sortedArray\":").append(arrayToJson(sortedArray)).append(",");
    json.append("\"status\":\"Array sorted for Fibonacci Search.\"");
    json.append("},");

    int n = sortedArray.length;
    int fibMMm2 = 0; // (m-2)'th Fibonacci No.
    int fibMMm1 = 1; // (m-1)'th Fibonacci No.
    int fibM = fibMMm2 + fibMMm1; // m'th Fibonacci

    while (fibM < n) {
        fibMMm2 = fibMMm1;
        fibMMm1 = fibM;
        fibM = fibMMm2 + fibMMm1;
    }

    int offset = -1;
    boolean found = false;

    while (fibM > 1) {
        int i = Math.min(offset + fibMMm2, n - 1);
        
        json.append("{");
        json.append("\"index\":").append(i).append(",");
        json.append("\"left\":").append(offset + 1).append(","); 
        json.append("\"right\":").append(Math.min(offset + fibM, n - 1)).append(",");
        json.append("\"value\":").append(sortedArray[i]).append(",");
        json.append("\"status\":\"Checking index ").append(i)
            .append(" : Value ").append(sortedArray[i]).append("\",");

        if (sortedArray[i] < target) {
            json.append("\"type\":\"check\"}");
            fibM = fibMMm1;
            fibMMm1 = fibMMm2;
            fibMMm2 = fibM - fibMMm1;
            offset = i;
        } else if (sortedArray[i] > target) {
            json.append("\"type\":\"check\"}");
            fibM = fibMMm2;
            fibMMm1 = fibMMm1 - fibMMm2;
            fibMMm2 = fibM - fibMMm1;
        } else {
            json.append("\"type\":\"found\"}");
            found = true;
            break;
        }
        json.append(",");
    }

    if (found) {
         json.append("]");
         return json.toString();
    }

    // Check the last element if fibMMm1 is 1
    if (fibMMm1 == 1 && offset + 1 < n && sortedArray[offset + 1] == target) {
        if (json.charAt(json.length()-1) == ',') json.deleteCharAt(json.length()-1);
        
        json.append(",{");
        json.append("\"index\":").append(offset + 1).append(",");
        json.append("\"value\":").append(sortedArray[offset + 1]).append(",");
        json.append("\"status\":\"Checking index ").append(offset + 1)
            .append(" : Value ").append(sortedArray[offset + 1]).append("\",");
        json.append("\"type\":\"found\"}]");
        return json.toString();
    }

    if (json.charAt(json.length()-1) == ',') json.deleteCharAt(json.length()-1);
    json.append(",{\"index\":-1,\"status\":\"Target ").append(target)
        .append(" not found.\",\"type\":\"not_found\"}]");
    return json.toString();
}

private String arrayToJson(int[] array) {
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    for (int i = 0; i < array.length; i++) {
        sb.append(array[i]);
        if (i < array.length - 1) sb.append(",");
    }
    sb.append("]");
    return sb.toString();
}
%>

<%
int[] array = (int[]) session.getAttribute("array");
String stepsJson = "null";
String currentAlgorithm = request.getParameter("algorithm");
String targetStr = request.getParameter("target");
String action = request.getParameter("action");
String errorMsg = null;

try {
    if (array == null || "generate".equals(action)) {
        array = generateArray(20);
        session.setAttribute("array", array);
        stepsJson = "null";
    }

    if ("search".equals(action) && array != null && targetStr != null && !targetStr.isEmpty()) {
        try {
            
            int target = Integer.parseInt(targetStr);
            if ("binary".equals(currentAlgorithm)) {
                stepsJson = getBinarySearchSteps(array, target);
            } else if ("jump".equals(currentAlgorithm)) {
                stepsJson = getJumpSearchSteps(array, target);
            } else if ("interpolation".equals(currentAlgorithm)) {
                stepsJson = getInterpolationSearchSteps(array, target);
            } else if ("exponential".equals(currentAlgorithm)) {
                stepsJson = getExponentialSearchSteps(array, target);
            } else if ("fibonacci".equals(currentAlgorithm)) {
                stepsJson = getFibonacciSearchSteps(array, target);
            } else {
                stepsJson = getLinearSearchSteps(array, target);
            }
        } catch (NumberFormatException e) {
            errorMsg = "Invalid number format: " + e.getMessage();
        }
    }
} catch (Throwable e) {
    errorMsg = "Java Error: " + e.toString();
    e.printStackTrace();
}

// Export array as JSON
StringBuilder arrayJson = new StringBuilder();
arrayJson.append("[");
if (array != null) {
    for (int i = 0; i < array.length; i++) {
        arrayJson.append(array[i]);
        if (i < array.length - 1) arrayJson.append(",");
    }
}
arrayJson.append("]");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aesthetic Search Visualizer (Java Logic)</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>  
    <h1>Search Algorithm Visualizer</h1>
    <% if (errorMsg != null) { %>
        <div style="background: #ef4444; color: white; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1rem;">
            <%= errorMsg %>
        </div>
    <% } %>
<%-- html for stars from here --%>
<b>Author :- Tanmay Gundre And Vijay Jogalekar  </b>
    <form method="post" class="controls">
    <%-- generate new array --%>
        <button type="submit" name="action" value="generate">Generate New Array</button>
        <%-- select new algorithm  --%>
        <select name="algorithm" id="algorithm-select">
            <option value="linear" <%= "linear".equals(currentAlgorithm) ? "selected" : "" %>>Linear Search</option>
            <option value="binary" <%= "binary".equals(currentAlgorithm) ? "selected" : "" %>>Binary Search</option>
            <option value="jump" <%= "jump".equals(currentAlgorithm) ? "selected" : "" %>>Jump Search</option>
            <option value="interpolation" <%= "interpolation".equals(currentAlgorithm) ? "selected" : "" %>>Interpolation Search</option>
            <option value="exponential" <%= "exponential".equals(currentAlgorithm) ? "selected" : "" %>>Exponential Search</option>
            <option value="fibonacci" <%= "fibonacci".equals(currentAlgorithm) ? "selected" : "" %>>Fibonacci Search</option>
        </select>
        <%-- enter target no. --%>
        <input type="number" name="target" id="search-target" placeholder="Target" min="1" max="100" value="<%= targetStr != null ? targetStr : "" %>">
        <%-- start search --%>
        <button type="submit" name="action" value="search" id="search-btn">Start Search</button>
    </form>

    <div class="visualizer-container" id="array-container"></div>
    <div class="status-panel" id="status-text">Ready. Logic powered by Java.</div>
<%-- additional information --%>
    <div class="complexity-info" style="margin-top: 1rem; text-align: center; color: var(--text-color);">
        <% if ("binary".equals(currentAlgorithm)) { %>
            <p><strong>Time Complexity:</strong> O(log n)</p>
            <p style="font-size: 0.9rem; color: var(--secondary-color);">Binary search halves the search space at each step.</p>
        <% } else if ("linear".equals(currentAlgorithm)) { %>
            <p><strong>Time Complexity:</strong> O(n)</p>
            <p style="font-size: 0.9rem; color: var(--secondary-color);">Linear search checks each element sequentially.</p>
        <% } else if ("jump".equals(currentAlgorithm)) { %>
            <p><strong>Time Complexity:</strong> O(√n)</p>
            <p style="font-size: 0.9rem; color: var(--secondary-color);">Jump search jumps ahead by fixed steps and then performs a linear search.</p>
        <% } else if ("interpolation".equals(currentAlgorithm)) { %>
            <p><strong>Time Complexity:</strong> O(log(log n))</p>
            <p style="font-size: 0.9rem; color: var(--secondary-color);">Interpolation search estimates the position based on the value distribution.</p>
        <% } else if ("exponential".equals(currentAlgorithm)) { %>
            <p><strong>Time Complexity:</strong> O(log n)</p>
            <p style="font-size: 0.9rem; color: var(--secondary-color);">Exponential search finds the range where the element is present and then performs binary search.</p>
        <% } else if ("fibonacci".equals(currentAlgorithm)) { %>
            <p><strong>Time Complexity:</strong> O(log n)</p>
            <p style="font-size: 0.9rem; color: var(--secondary-color);">Fibonacci search uses Fibonacci numbers to divide the array into smaller subarrays.</p>
        <% } %>
        
    </div>

    <footer style="margin-top: 2rem; color: var(--secondary-color); font-size: 0.9rem;">
        <p>Server Time: <%= new java.util.Date() %></p>
        <p>Powered by JSP & Java</p>
    </footer>

    <script>
    const initialArray = <%= arrayJson.toString() %>;
    const searchSteps = <%= (stepsJson == null || "null".equals(stepsJson)) ? "null" : stepsJson %>;
    </script>
    <script src="js/script.js"></script>
</body>
</html>
