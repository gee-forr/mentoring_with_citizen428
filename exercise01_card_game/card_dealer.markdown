Card Dealer
---

Write a class `CardGame` which will be used like this:

    game1 = CardGame.new
    game1.deal
    game1.display
    puts
    game1.deal(4)
    game1.display
    puts
    game2 = CardGame.new(2)
    game2.deal(6,10)
    game2.display

The optional parameter to `CardGame#new` specifies the number of used decks.

`CardGame#deal` has two optional parameters, namely number of players
(defaults to 1) and cards per player (defaults to 5).

The method `CardGame#display` should create output like this (that's
from the calls to `display` in the example code above):

    Player 1: Tc | 5s | 3c | 2d | 7s
    Cards used: 5
    Cards remaining: 47
     
    Player 1: Qh | 6c | Ks | 7s | Ts
    Player 2: As | 3s | 9s | Qs | Tc
    Player 3: 5d | Js | 4c | 8s | 9c
    Player 4: Kh | 9d | Kc | 4h | 9h
    Cards used: 20
    Cards remaining: 32
     
    Player 1: Qd | 3d | 7s | Jh | 9h | 5d | 8c | 4c | 3h | 5c
    Player 2: 3h | Qd | 4d | 8s | Js | Jd | 3s | 2s | 3s | Kd
    Player 3: 2c | Jc | 3c | Qh | Ks | Qc | Ts | 9d | 5c | 4s
    Player 4: 9c | Td | 2h | 6s | Ac | 5d | 5h | 9s | 7h | Tc
    Player 5: 6d | 2c | 9c | Ah | Qs | Jc | 3d | 4c | 7h | 7d
    Player 6: Kh | 5h | 2s | 8s | Qh | 9s | 5s | Qs | 4h | As
    Cards used: 60
    Cards remaining: 44

Don't bother too much with error handling, I just want to see some
nice idiomatic Ruby. :-)
