!classDefinition: #TerniLapilliTest category: 'TerniLapippiSolution'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!TerniLapilliTest methodsFor: 'ilegal movement' stamp: 'DS 10/29/2020 19:46:46'!
test06OPlayerCanNotPutOnOccupiedPosition
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.

	self
		should: [ aTerniLapilli putOAt: 0@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.! !

!TerniLapilliTest methodsFor: 'ilegal movement' stamp: 'DS 10/29/2020 19:46:52'!
test07XPlayerCanNotPutOnOccupiedPosition
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.
	aTerniLapilli putOAt: 0@1.

	self
		should: [ aTerniLapilli putXAt: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.! !

!TerniLapilliTest methodsFor: 'ilegal movement' stamp: 'DS 10/31/2020 17:30:43'!
test13XPlayerCanNotMoveFromNotOwnPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveXFrom: 0@0 to: -1@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.! !

!TerniLapilliTest methodsFor: 'ilegal movement' stamp: 'DS 10/31/2020 17:31:04'!
test14OPlayerCanNotMoveFromNotOwnPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.
	
	aTerniLapilli moveXFrom: -1@1 to: -1@0.

	self
		should: [ aTerniLapilli moveOFrom: -1@0 to: -1@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.! !


!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 10/29/2020 21:06:21'!
test08PlayerWonWithHorizontalPlay
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.
	aTerniLapilli putOAt: 0@1.
	
	aTerniLapilli putXAt: -1@0.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: 1@0.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 10/29/2020 21:06:15'!
test09PlayerWonWithVerticalPlay
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.
	aTerniLapilli putOAt: -1@1.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: 0@-1.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 10/29/2020 21:06:44'!
test10PlayerWonWithInvertedDiagonalPlay
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.
	aTerniLapilli putOAt: 0@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: 1@-1.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 10/29/2020 21:06:56'!
test11PlayerWonWithDiagonalPlay

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.
	aTerniLapilli putOAt: 0@1.
	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: -1@1.
	
	aTerniLapilli putXAt: -1@-1.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 10/31/2020 17:58:31'!
test12GameIsOverWhenAPlayerWins

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: -1@-1.

	self
		should: [ aTerniLapilli moveXFrom: -1@1 to: -1@1 ]
		raise: Error
		withMessageText: TerniLapilli gameOverErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 10/31/2020 17:33:05'!
test15DoAWinnerMovementOverTheGame

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.
	
	aTerniLapilli moveXFrom: -1@1 to: -1@0.
	aTerniLapilli moveOFrom: 0@0 to: 1@0.
	
	self assert: aTerniLapilli isOver.! !


!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:23:32'!
test27XPlayerCanNotMoveLeftDownFromCenterUpPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftDownXFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:24:35'!
test28XPlayerCanNotMoveLeftDownFromRightCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: 1@0.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftDownXFrom: 1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:26:16'!
test29XPlayerCanNotMoveRIghtDownFromCenterUpPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightDownXFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:28:03'!
test30XPlayerCanNotMoveRightDownFromLeftCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@0.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightDownXFrom: -1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:32:47'!
test31XPlayerCanNotMoveLeftUpFromCenterDownPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftUpXFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:33:11'!
test32XPlayerCanNotMoveLeftUpFromRightCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftUpXFrom: 1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:34:26'!
test33XPlayerCanNotMoveRightUpFromLeftCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@0.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightUpXFrom: -1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 10/31/2020 23:34:47'!
test34XPlayerCanNotMoveLeftDownFromDownCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@0.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightUpXFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !


!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 22:56:33'!
test19XPlayerCanNotMoveUpToNotEmptyPosition

	| aTerniLapilli |

	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveUpXFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 22:56:40'!
test20XPlayerCanNotMoveRightToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightXFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 22:56:47'!
test21XPlayerCanNotMoveDownToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveDownXFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 22:57:08'!
test22XPlayerCanNotMoveLeftToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftXFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 23:00:56'!
test23XPlayerCanNotMoveLeftDownToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: -1@-1.
	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftDownXFrom: 1@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 23:02:29'!
test24XPlayerCanNotMoveRightDownToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightDownXFrom: -1@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 23:04:31'!
test25XPlayerCanNotMoveLeftUpToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: 1@-1.
	aTerniLapilli putOAt: -1@0.

	self
		should: [ aTerniLapilli moveLeftUpXFrom: 1@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 10/31/2020 23:19:35'!
test26XPlayerCanNotMoveRightUpToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@0.
	aTerniLapilli putOAt: 1@0.

	self
		should: [ aTerniLapilli moveRightUpXFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 00:15:51'!
test35OPlayerCanNotMoveUpToNotEmptyPosition

	| aTerniLapilli |

	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.
	
	aTerniLapilli moveLeftXFrom: 0@-1.

	self
		should: [ aTerniLapilli moveUpOFrom: 0@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !


!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DS 10/31/2020 18:00:33'!
test16XPlayerCanNotPutWhenHasNotTokenRemained

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: -1@-1.

	self
		should: [ aTerniLapilli putXAt: -1@0. ]
		raise: Error
		withMessageText: TerniLapilli noRemainedTokensErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DS 10/31/2020 18:03:19'!
test17OPlayerCanNotPutWhenHasNotTokenRemained

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@-1.
	aTerniLapilli putOAt: 0@0.
	
	aTerniLapilli putXAt: 0@1.
	aTerniLapilli putOAt: 1@1.
	
	aTerniLapilli putXAt: -1@1.
	aTerniLapilli putOAt: 1@-1.
	
	aTerniLapilli moveXFrom: -1@1 to: -1@0.

	self
		should: [ aTerniLapilli putOAt: -1@-1. ]
		raise: Error
		withMessageText: TerniLapilli noRemainedTokensErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DS 10/31/2020 18:17:44'!
test18PlayerCanNotPutOutOfBoard

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.

	self
		should: [ aTerniLapilli putXAt: 0@2. ]
		raise: Error
		withMessageText: TerniLapilli positionOutOfBoardErrorDescription.
	! !


!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 10/29/2020 18:14:20'!
test01GameStartWithXPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	
	self assert: aTerniLapilli isPlayingX.! !

!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 10/29/2020 18:14:47'!
test02AfterFirstTurnIsOPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.
	
	self deny: aTerniLapilli isPlayingX.
	self assert: aTerniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 10/29/2020 18:17:03'!
test03AfterOPlayerTurnIsXPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.
	aTerniLapilli putOAt: 0@1.
	
	self assert: aTerniLapilli isPlayingX.
	self deny: aTerniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 10/29/2020 18:24:55'!
test04XPlayerCanNotPlayOnOPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 0@0.

	self 
		should: [ aTerniLapilli putXAt: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli attemptToPlayTwiceInARowErrorDescription.! !

!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 10/29/2020 18:41:54'!
test05OPlayerCanNotPlayOnXPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.

	self 
		should: [ aTerniLapilli putOAt: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli attemptToPlayTwiceInARowErrorDescription.! !


!classDefinition: #TerniLapilli category: 'TerniLapippiSolution'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentPlayer tokensXRemained positionsOccupied'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!TerniLapilli methodsFor: 'initialization' stamp: 'DS 10/29/2020 20:20:18'!
initialize

	currentPlayer := #X.
	positionsOccupied := OrderedCollection new.! !


!TerniLapilli methodsFor: 'testing' stamp: 'DS 11/1/2020 00:06:42'!
hasPlayerOWon

	^self hasWonPlayer: #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 11/1/2020 00:06:54'!
hasPlayerXWon

	^self hasWonPlayer: #X.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 11/1/2020 00:07:31'!
hasWonPlayer: aPlayer

	| positionsOccupiedByPlayer i isHorizontalWinner isVerticalWinner isInvertedDiagonalWinner isDiagonalWinner |

	positionsOccupiedByPlayer := ( ( positionsOccupied select: [ :aOccupiedPosition | aOccupiedPosition first = aPlayer ] ) 
							  	collect: [ :aOccupiedPositionByPlayer | aOccupiedPositionByPlayer second] ) sort.
	
	i := 1.
	isHorizontalWinner := true.
	[i < (positionsOccupiedByPlayer size) ]	 whileTrue: [
		isHorizontalWinner := isHorizontalWinner and: [ ((positionsOccupiedByPlayer at: i)	 + (1@	0)) = (positionsOccupiedByPlayer at: i+1)	 ].
		i := i+1.
	].

	i := 1.
	isVerticalWinner := true.
	[i < (positionsOccupiedByPlayer size) ]	 whileTrue: [
		isVerticalWinner := isVerticalWinner and: [ ((positionsOccupiedByPlayer  at: i)	 + (0@	1)) = (positionsOccupiedByPlayer  at: i+1)	 ].
		i := i+1.
	].

	isInvertedDiagonalWinner := positionsOccupiedByPlayer includesAllOf: {-1@1. 0@0. 1@-1}.
	isDiagonalWinner := positionsOccupiedByPlayer includesAllOf: {-1@-1. 0@0. 1@1}.

	^(positionsOccupiedByPlayer size = 3) and: [isHorizontalWinner or: isVerticalWinner or: isInvertedDiagonalWinner or: isDiagonalWinner].! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 10/29/2020 21:16:07'!
isOver

	^(self hasPlayerXWon) or: (self hasPlayerOWon).! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 10/29/2020 17:43:02'!
isPlayingO

	^currentPlayer = #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 10/29/2020 17:44:47'!
isPlayingX

	^currentPlayer  = #X.! !


!TerniLapilli methodsFor: 'player actions' stamp: 'DS 10/31/2020 17:47:27'!
move: aPlayer from: aFromPosition to: aToPosition

	(positionsOccupied includes: {aPlayer. aFromPosition} ) ifFalse: [ self error: self class ilegalMovementErrorDescription ].	

	self put: aPlayer at: aToPosition.
	positionsOccupied remove: {aPlayer. aFromPosition}.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'DS 10/31/2020 17:27:02'!
moveOFrom: aFromPosition to: aToPosition

	self move: #O from: aFromPosition to: aToPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'DS 10/31/2020 17:26:39'!
moveXFrom: aFromPosition to: aToPosition

	self move: #X from: aFromPosition to: aToPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'DS 10/31/2020 18:17:20'!
put: aPlayer at: aPosition

	(aPosition between: (-1@-1) and: (1@1)) ifFalse: [ self error: self class positionOutOfBoardErrorDescription ].
	(self isOver) ifTrue: [ self error: self class gameOverErrorDescription ].
	(currentPlayer = aPlayer) ifFalse: [ self error: (self class attemptToPlayTwiceInARowErrorDescription) ].
	((positionsOccupied collect: [ :aOccupiedPosition | aOccupiedPosition second] ) includes: aPosition) 		ifTrue: [ self error: self class ilegalMovementErrorDescription ].

	positionsOccupied add: {aPlayer. aPosition}.
	currentPlayer := (aPlayer = #X) ifTrue: [#O] ifFalse: [#X].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'DS 10/31/2020 18:03:39'!
putOAt: aPosition

	((positionsOccupied select: [ :aOccupiedPosition | aOccupiedPosition first = #O ] ) size = 3 ) 
		ifTrue: [ self error: self class noRemainedTokensErrorDescription].

	self put: #O at: aPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'DS 10/31/2020 17:53:32'!
putXAt: aPosition

	((positionsOccupied select: [ :aOccupiedPosition | aOccupiedPosition first = #X ] ) size = 3 ) 
		ifTrue: [ self error: self class noRemainedTokensErrorDescription].

	self put: #X at: aPosition.! !


!TerniLapilli methodsFor: 'movements' stamp: 'DS 10/31/2020 22:16:53'!
moveDownXFrom: aPosition

	| direction |
	direction := 0@-1.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 10/31/2020 22:37:42'!
moveLeftDownXFrom: aPosition

	| direction |

	({0@1. 1@0} includes: aPosition) ifTrue: [ self error: self class ilegalMovementErrorDescription ].

	direction := -1@-1.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 00:08:55'!
moveLeftUpXFrom: aPosition

	| direction |

	(0@-1 = aPosition) ifTrue: [ self error: self class ilegalMovementErrorDescription ].

	direction := -1@1.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 10/31/2020 22:17:29'!
moveLeftXFrom: aPosition

	| direction |
	direction := -1@0.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 10/31/2020 23:03:26'!
moveRightDownXFrom: aPosition

	| direction |

	({0@1. -1@0} includes: aPosition) ifTrue: [ self error: self class ilegalMovementErrorDescription ].

	direction := 1@-1.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 10/31/2020 22:49:47'!
moveRightUpXFrom: aPosition

	| direction |

	({-1@0. 0@-1} includes: aPosition) ifTrue: [ self error: self class ilegalMovementErrorDescription ].

	direction := -1@-1.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 10/31/2020 22:16:14'!
moveRightXFrom: aPosition

	| direction |
	direction := 1@0.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 00:17:51'!
moveUpOFrom: aPosition
	
	| direction |
	direction := 0@1.

	self put: #O at: aPosition + direction.
	positionsOccupied remove: {#O. aPosition}.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 10/31/2020 22:13:03'!
moveUpXFrom: aPosition

	| direction |
	direction := 0@1.

	self put: #X at: aPosition + direction.
	positionsOccupied remove: {#X. aPosition}.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapippiSolution'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/29/2020 18:26:56'!
attemptToPlayTwiceInARowErrorDescription

	^'Can not play twice in a row'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/29/2020 19:01:36'!
ilegalMovementErrorDescription

	^'Ilegal Movement'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/29/2020 18:54:32'!
noRemainedTokensErrorDescription

	^'No Remained Tokens'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/31/2020 18:13:13'!
positionOutOfBoardErrorDescription

	^'Position out of board'.! !


!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DS 10/29/2020 21:11:33'!
gameOverErrorDescription

	^'Game Over'.! !
