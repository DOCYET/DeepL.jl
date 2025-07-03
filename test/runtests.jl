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
end
