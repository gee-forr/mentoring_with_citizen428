#!/usr/bin/env ruby

# Need a newer version of minitest for assert_output, these two lines do that.
require 'rubygems'
gem 'minitest'

require 'minitest/autorun'
require './card_dealer'

class TestCardGame < MiniTest::Unit::TestCase
    def setup
        srand(1) # Seed the randomizer so that deck shuffles are always the same
        @games = {
            std_game:    CardGame.new,
            four_player: CardGame.new,
            six_player:  CardGame.new(2)
        }
    end

    def test_class_loads
        @games.each_value do |value|
            assert_instance_of CardGame, value
        end
    end

    def test_num_of_cards_dealt_and_display # These methods are linked, they need to be run together
        assert_equal 5,  @games[:std_game].deal
        assert_equal 20, @games[:four_player].deal(4)
        assert_equal 60, @games[:six_player].deal(6, 10)

        # if you want indentation in heredocs you can use <<-eod
        std_game = <<eod
Player1: Th | Ah | Td | Qc | Js
Cards used: 5
Cards remaining: 47
eod

        four_player = <<eod
Player1: Qs | 4h | 5d | Ac | 2d
Player2: 2h | 7c | As | Ah | 9h
Player3: Kc | Ks | 5h | Jd | 8c
Player4: 4c | 7d | Td | Qc | 3s
Cards used: 20
Cards remaining: 32
eod

        six_player = <<eod
Player1: 5c | 8s | Jc | Ks | Ad | 8c | 5s | Qd | 9c | Kc
Player2: As | 7d | Td | 9c | 5d | Kd | Th | 3h | Qh | 8s
Player3: Tc | 3s | 7s | Jd | Ac | Qh | 3s | Jc | 9h | 8h
Player4: 4h | 7s | 2h | 6c | 2s | Th | Jh | 5h | 8c | 8h
Player5: 6d | 4d | 6d | 4c | 5d | 9h | 7d | 2c | Qs | Ah
Player6: 9s | 4c | Jd | 4s | Jh | 9d | 2d | 3h | 2h | Ts
Cards used: 60
Cards remaining: 44
eod

        assert_output std_game    do
            @games[:std_game].display
        end

        assert_output four_player do
            @games[:four_player].display
        end

        assert_output six_player  do
            @games[:six_player].display
        end
    end
end
