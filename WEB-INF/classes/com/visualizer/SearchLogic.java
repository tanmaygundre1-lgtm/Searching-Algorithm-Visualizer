package com.visualizer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class SearchLogic {

    public static int[] generateArray(int size) {
        int[] array = new int[size];
        Random rand = new Random();
        for (int i = 0; i < size; i++) {
            array[i] = rand.nextInt(100) + 1;
        }
        return array;
    }

    public static String getLinearSearchSteps(int[] array, int target) {
        StringBuilder json = new StringBuilder();
        json.append("[");

        for (int i = 0; i < array.length; i++) {
            json.append("{");
            json.append("\"index\":").append(i).append(",");
            json.append("\"value\":").append(array[i]).append(",");
            json.append("\"status\":\"Checking index " + i + ": Value " + array[i] + "\",");

            if (array[i] == target) {
                json.append("\"type\":\"found\"");
                json.append("}");
                return json.append("]").toString();
            } else {
                json.append("\"type\":\"check\"");
            }
            json.append("}");
            if (i < array.length - 1)
                json.append(",");
        }

        // Not found
        json.append(",{");
        json.append("\"index\":-1,");
        json.append("\"status\":\"Target " + target + " not found.\",");
        json.append("\"type\":\"not_found\"");
        json.append("}");

        json.append("]");
        return json.toString();
    }

    public static String getBinarySearchSteps(int[] array, int target) {
        // For binary search, we need a sorted array.
        // We will return the sorted array as part of the first step if needed,
        // but to keep it simple, we assume the UI will update the array to the sorted
        // version first.
        // Actually, let's sort a copy and work on that.
        int[] sortedArray = Arrays.copyOf(array, array.length);
        Arrays.sort(sortedArray);

        StringBuilder json = new StringBuilder();
        json.append("[");

        // Step 0: Announce sorting
        json.append("{");
        json.append("\"type\":\"sort\",");
        json.append("\"sortedArray\":").append(arrayToJson(sortedArray)).append(",");
        json.append("\"status\":\"Array sorted for Binary Search.\"");
        json.append("},");

        int left = 0;
        int right = sortedArray.length - 1;
        boolean found = false;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            json.append("{");
            json.append("\"index\":").append(mid).append(",");
            json.append("\"left\":").append(left).append(",");
            json.append("\"right\":").append(right).append(",");
            json.append("\"value\":").append(sortedArray[mid]).append(",");
            json.append("\"status\":\"Checking middle index " + mid + ": Value " + sortedArray[mid] + "\",");

            if (sortedArray[mid] == target) {
                json.append("\"type\":\"found\"");
                json.append("}");
                found = true;
                break;
            } else if (sortedArray[mid] < target) {
                json.append("\"type\":\"check\"");
                json.append("},");
                left = mid + 1;
            } else {
                json.append("\"type\":\"check\"");
                json.append("},");
                right = mid - 1;
            }
        }

        if (!found) {
            json.append(",{");
            json.append("\"index\":-1,");
            json.append("\"status\":\"Target " + target + " not found.\",");
            json.append("\"type\":\"not_found\"");
            json.append("}");
        }

        json.append("]");
        return json.toString();
    }

    private static String arrayToJson(int[] array) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < array.length; i++) {
            sb.append(array[i]);
            if (i < array.length - 1)
                sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}
