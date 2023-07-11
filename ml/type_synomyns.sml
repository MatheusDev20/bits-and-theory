datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int


type card = suit * rank

fun isQueenOfSpades (c: card) = 
    #1 c = Spade andalso #2 c = Queen