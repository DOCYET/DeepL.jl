# Constants
# ---------
const HEADERS = Dict("Authorization" => "DeepL-Auth-Key " * DEEPL_API_KEY, "Content-Type" => "application/json")

"""
    post_request(endpoint::String, body::Dict)

Make a POST request to the DeepL API.
# Arguments
- `endpoint::String`: The endpoint to request.
- `body::Dict`: The body of the request.
# Returns
- `HTTP.Response`: The HTTP response from the API.
"""
function post_request(endpoint::String, body::Dict)
    url = DEEPL_API_URL * endpoint
    response = HTTP.post(url, HEADERS, JSON.json(body))
    return response
end

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
