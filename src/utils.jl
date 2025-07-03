
"""
	handle_api_error(response::HTTP.Response)

Handle errors from the DeepL API response.
# Arguments
- `response::HTTP.Response`: The HTTP response from the API.

# Returns
- `String`: An error message if an error occurred, otherwise an empty string.
"""
function handle_api_error(response::HTTP.Response)
    if response.status != 200
        error_info = JSON.parse(String(response.body))
        return "Error: " * get(error_info, "message", "Unknown error")
    end
    return ""
end
