# CLAUDE.md

## Project Overview

DeepL.jl is a Julia SDK for the DeepL translation API. It provides functions to translate text, detect languages, and list supported languages.

## Quick Reference

```bash
# Install dependencies
julia --project=. -e 'using Pkg; Pkg.instantiate()'

# Run tests (requires DEEPL_API_KEY env var)
julia --project=. -e 'using Pkg; Pkg.test()'
```

## Project Structure

```
src/
  DeepL.jl       # Main module — exports, constants, includes
  client.jl      # HTTP helpers (post_request, get_request)
  translate.jl   # translate_text + language constant lists
  detect.jl      # detect_language
  languages.jl   # get_languages
test/
  runtests.jl    # Full test suite using @testset
```

## Environment Variables

- `DEEPL_API_KEY` — required for all API calls and tests
- `DEEPL_API_URL` — optional override (defaults to `https://api.deepl.com/v2`)

## Code Conventions

- **Multiple dispatch:** define the same function for `String` and `Vector{String}` signatures
- **Pair syntax:** support `source => target` as a language pair argument (e.g., `"EN" => "DE"`)
- **Nullable types:** use `Optional{T} = Union{T, Nothing}`
- **Input validation:** guard clauses at the top of public functions; throw `ArgumentError` for invalid inputs
- **Errors:** `handle_api_error()` in `client.jl` checks HTTP status codes
- **Exports:** only public API functions are exported from the module (`translate_text`, `detect_language`, `get_languages`)
- **Imports:** use qualified imports (`using HTTP: HTTP`, `using JSON: JSON`)
- **Docstrings:** all public functions have Julia-style docstrings

## CI

GitHub Actions runs on push/PR to `main` with Julia 1.11. The `main` environment provides the `DEEPL_API_KEY` secret.

## Commit Style

Conventional commits: `feat:`, `fix:`, `chore:`, `test:`, `docs:`
