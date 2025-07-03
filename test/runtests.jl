using Test
using DeepL

@testset "DeepL Module Tests" begin

    @testset "translate_text" begin
        @testset "single text" begin
            @test translate_text("Hallo", "DE", "EN") == "Hello"
            @test translate_text(["Hallo", "Welt"], "DE", "EN") == ["Hello", "World"]
        end

        @testset "multiple texts" begin
            @test translate_text(["Hallo", "Welt"], "DE", "EN") == ["Hello", "World"]
        end
    end
end
