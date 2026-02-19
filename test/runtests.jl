using Test
using DeepL

@testset "DeepL Module Tests" begin

    @testset "translate_text" begin
        @testset "single text" begin
            @test translate_text("Hallo", "DE", "EN") == "Hello"
            @test translate_text("Hallo Welt", "DE" => "EN") == "Hello world"
            @test translate_text("Hallo, wie geht's dir?",  "ES") == "Hola, ¿cómo estás?"
        end

        @testset "multiple texts" begin
            @test translate_text(["Hallo", "Welt"], "DE", "EN") == ["Hello", "World"]
            @test translate_text(["Hallo", "Welt"], "DE" => "EN") == ["Hello", "World"]
            @test translate_text(["Hallo", "Welt"], "ES") == ["Hola", "Mundo"]
        end
    end

    @testset "detect_language" begin
        @testset "single text" begin
            @test detect_language("Hallo Welt") == "DE"
            @test detect_language("Hello world") == "EN"
            @test detect_language("Bonjour le monde") == "FR"
        end

        @testset "multiple texts" begin
            @test detect_language(["Hallo Welt", "Hello world"]) == ["DE", "EN"]
            @test detect_language(["Bonjour madame", "Hola señorita", "Buongiorno, come stai oggi?"]) == ["FR", "ES", "IT"]
        end

        @testset "empty text" begin
            @test_throws ArgumentError detect_language("")
            @test_throws ArgumentError detect_language(String[])
        end
    end

    @testset "get_languages" begin
        @testset "source languages" begin
            langs = get_languages()
            @test langs isa Vector
            @test length(langs) > 0
            @test all(haskey(lang, "language") && haskey(lang, "name") for lang in langs)
            # German should be in the source languages
            @test any(lang["language"] == "DE" for lang in langs)
        end

        @testset "target languages" begin
            langs = get_languages("target")
            @test langs isa Vector
            @test length(langs) > 0
            @test all(haskey(lang, "language") && haskey(lang, "name") for lang in langs)
            # Target languages include regional variants
            @test any(lang["language"] == "EN-GB" for lang in langs)
            @test all(haskey(lang, "supports_formality") for lang in langs)
        end

        @testset "invalid type" begin
            @test_throws ArgumentError get_languages("invalid")
        end
    end
end
