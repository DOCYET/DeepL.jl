module DeepLSDK

# External dependencies
# ---------------------
using HTTP: HTTP
using JSON: JSON

# Constants
# ---------
const DEFAULT_DEEPL_API_URL = "https://api.deepl.com/v2"
const DEEPL_API_URL = get(ENV, "DEEPL_API_URL", DEFAULT_DEEPL_API_URL)
const DEEPL_API_KEY = get(ENV, "DEEPL_API_KEY", "")


# File inclusions
# ---------------
include("utils.jl")
include("translate.jl")
export translate_text

"""
	__init__()

Initialize the DeepL module, warning if the API key is not set.
# Returns
- `Nothing`: Nothing.
"""
function __init__()
    if isempty(DEEPL_API_KEY)
        @warn "DEEPL_API_KEY is not set. Please set the environment variable to use the DeepL API."
    end
end



"""
	get_account_usage()

Get account usage information from the DeepL API.
# Returns
- `String`: The account usage information or an error message if an error occurred.
"""
function get_account_usage()
    url = DEEPL_API_URL * "/usage"
    headers = Dict("Authorization" => "DeepL-Auth-Key " * DEEPL_API_KEY)
    response = HTTP.get(url, headers)
    error_message = handle_api_error(response)
    if !isempty(error_message)
        return error_message
    end
    usage_info = JSON.parse(String(response.body))
    return "Character usage: " *
           string(usage_info["character_count"]) *
           "/" *
           string(usage_info["character_limit"])
end

"""
	use_glossary_and_context()

Placeholder for glossary and context features.
# Returns
- `String`: A message indicating that this feature is not implemented.
"""
function use_glossary_and_context()
    # Placeholder for glossary and context functionality
    return "Glossary and context features are not implemented in this SDK."
end

end # module DeepL
