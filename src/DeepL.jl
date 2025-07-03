module DeepL

# External dependencies
# ---------------------
using HTTP: HTTP
using JSON: JSON

# Constants
# ---------
const DEFAULT_DEEPL_API_URL = "https://api.deepl.com/v2"
const DEEPL_API_URL = get(ENV, "DEEPL_API_URL", DEFAULT_DEEPL_API_URL)
const DEEPL_API_KEY = get(ENV, "DEEPL_API_KEY", "")
const Optional{T} = Union{T, Nothing}

# File inclusions
# ---------------
include("client.jl")
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

end # module DeepL
