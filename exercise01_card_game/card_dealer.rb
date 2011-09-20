#!/usr/bin/env ruby

require 'awesome_print'

class CardGame
    FACES = (2..9).to_a + %w{T J Q K A}
    SUITS = %w{h s c d}

    def initialize(decks = 1)
        @shuffled_deck = create_decks(decks)
    end

    def deal(players = 1, cards_per_player = 5)
        @current_hand = {}

        players.times do |player|
            @current_hand[player+1] = @shuffled_deck.shift(cards_per_player)
        end

        @current_hand[1].size * @current_hand.size
    end

    def display
        card_display = ''
        cards_used   = @current_hand[1].size * @current_hand.size

        @current_hand.each do |player, hand|
            # I would use string interpolation here, see the article I
            # mentioned as suggested reading for this week
            card_display << "Player#{player}: " + hand.join(' | ') + "\n"
        end

        card_display << "Cards used: #{cards_used}\n"
        card_display << "Cards remaining: #{@shuffled_deck.size}\n"

        puts card_display
    end

    private

    def create_decks(decks)
        built_deck = []

        # Enumerable and Array have interesting methods that don't
        # require this nested loop approach
        decks.times do
            FACES.each do |face|
                SUITS.each do |suit|
                    built_deck << face.to_s + suit
                end
            end
        end

        built_deck.shuffle
    end
end
