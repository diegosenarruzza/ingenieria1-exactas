!classDefinition: #TerniLapilliTest category: 'TerniLapippiSolution'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!TerniLapilliTest methodsFor: 'ilegal movement' stamp: 'DS 11/1/2020 13:57:55'!
test06PlayerCanNotPutOnOccupiedPosition
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@0.

	self
		should: [ aTerniLapilli putAt: 0@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.! !

!TerniLapilliTest methodsFor: 'ilegal movement' stamp: 'DS 11/1/2020 13:25:19'!
test13PlayerCanNotMoveFromNotOwnPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftDownFrom: 0@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.! !

!TerniLapilliTest methodsFor: 'ilegal movement' stamp: 'DS 11/1/2020 13:25:22'!
test14PlayerCanNotMoveWhenHasTokenRemained

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.

	self
		should: [ aTerniLapilli moveLeftDownFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli remainedTokensErrorDescription.! !


!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 11/1/2020 13:22:35'!
test08PlayerWonWithHorizontalPlay
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@0.
	aTerniLapilli putAt: 0@1.
	
	aTerniLapilli putAt: -1@0.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: 1@0.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 11/1/2020 13:22:45'!
test09PlayerWonWithVerticalPlay
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@0.
	aTerniLapilli putAt: -1@1.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: 0@-1.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 11/1/2020 13:25:38'!
test10PlayerWonWithInvertedDiagonalPlay
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@0.
	aTerniLapilli putAt: 0@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: 1@-1.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 11/1/2020 13:25:47'!
test11PlayerWonWithDiagonalPlay

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@0.
	aTerniLapilli putAt: 0@1.
	
	aTerniLapilli putAt: 1@1.
	aTerniLapilli putAt: -1@1.
	
	aTerniLapilli putAt: -1@-1.

	self assert: aTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 11/1/2020 13:26:34'!
test12GameIsOverWhenAPlayerWins

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: -1@-1.

	self
		should: [ aTerniLapilli moveDownFrom: -1@1 ]
		raise: Error
		withMessageText: TerniLapilli gameOverErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'kinds of win' stamp: 'DS 11/1/2020 13:26:43'!
test15DoAWinnerMovementOverTheGame

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.
	
	aTerniLapilli moveDownFrom: -1@1.
	aTerniLapilli moveRightFrom: 0@0.
	
	self assert: aTerniLapilli isOver.! !


!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:27:04'!
test27PlayerCanNotMoveLeftDownFromCenterUpPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftDownFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:27:23'!
test28PlayerCanNotMoveLeftDownFromRightCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: 1@0.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftDownFrom: 1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:27:32'!
test29PlayerCanNotMoveRIghtDownFromCenterUpPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightDownFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:27:42'!
test30PlayerCanNotMoveRightDownFromLeftCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@0.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightDownFrom: -1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:27:54'!
test31PlayerCanNotMoveLeftUpFromCenterDownPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftUpFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:28:08'!
test32PlayerCanNotMoveLeftUpFromRightCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.

	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftUpFrom: 1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:28:23'!
test33PlayerCanNotMoveRightUpFromLeftCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.

	aTerniLapilli putAt: -1@0.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightUpFrom: -1@0. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'ilegal diagonal movements' stamp: 'DS 11/1/2020 13:28:32'!
test34PlayerCanNotMoveLeftDownFromDownCenterPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@0.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightUpFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalDiagonalMovementErrorDescription.	! !


!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:28:52'!
test19PlayerCanNotMoveUpToNotEmptyPosition

	| aTerniLapilli |

	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.

	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.

	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveUpFrom: 0@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:29:12'!
test20PlayerCanNotMoveRightToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.

	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.

	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:29:24'!
test21PlayerCanNotMoveDownToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.

	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.

	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.
	self
		should: [ aTerniLapilli moveDownFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:29:37'!
test22PlayerCanNotMoveLeftToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.

	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.

	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftFrom: 0@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:29:59'!
test23PlayerCanNotMoveLeftDownToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: -1@-1.
	
	aTerniLapilli putAt: 1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveLeftDownFrom: 1@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:30:27'!
test24PlayerCanNotMoveRightDownToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.

	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.

	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli moveRightDownFrom: -1@1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:30:47'!
test25PlayerCanNotMoveLeftUpToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: 1@-1.
	aTerniLapilli putAt: -1@0.

	self
		should: [ aTerniLapilli moveLeftUpFrom: 1@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !

!TerniLapilliTest methodsFor: 'movements' stamp: 'DS 11/1/2020 13:30:58'!
test26PlayerCanNotMoveRightUpToNotEmptyPosition

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@-1.
	aTerniLapilli putAt: 1@0.

	self
		should: [ aTerniLapilli moveRightUpFrom: -1@-1. ]
		raise: Error
		withMessageText: TerniLapilli ilegalMovementErrorDescription.	! !


!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DS 11/1/2020 13:58:43'!
test16PlayerCanNotPutWhenHasNotTokenRemained

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@-1.
	aTerniLapilli putAt: 0@0.
	
	aTerniLapilli putAt: 0@1.
	aTerniLapilli putAt: 1@1.
	
	aTerniLapilli putAt: -1@1.
	aTerniLapilli putAt: 1@-1.

	self
		should: [ aTerniLapilli putAt: -1@0. ]
		raise: Error
		withMessageText: TerniLapilli noRemainedTokensErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DS 11/1/2020 13:31:28'!
test18PlayerCanNotPutOutOfBoard

	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.

	self
		should: [ aTerniLapilli putAt: 0@2. ]
		raise: Error
		withMessageText: TerniLapilli positionOutOfBoardErrorDescription.
	! !


!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 10/29/2020 18:14:20'!
test01GameStartWithXPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	
	self assert: aTerniLapilli isPlayingX.! !

!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 11/1/2020 13:24:08'!
test02AfterFirstTurnIsOPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@0.
	
	self deny: aTerniLapilli isPlayingX.
	self assert: aTerniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'turns' stamp: 'DS 11/1/2020 13:22:06'!
test03AfterOPlayerTurnIsXPlayerTurn
	
	| aTerniLapilli |
	
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putAt: 0@0.
	aTerniLapilli putAt: 0@1.
	
	self assert: aTerniLapilli isPlayingX.
	self deny: aTerniLapilli isPlayingO.! !


!classDefinition: #TerniLapilli category: 'TerniLapippiSolution'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentPlayer board putTokensRules moveOnRules'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!TerniLapilli methodsFor: 'initialization' stamp: 'DS 11/1/2020 16:06:54'!
initialize

	putTokensRules := self class putTokenRulesFor: self.
	moveOnRules := self class moveOnRulesFor: self.
	currentPlayer := #X.
	board := OrderedCollection new.! !


!TerniLapilli methodsFor: 'board testing' stamp: 'DS 11/1/2020 15:37:13'!
boardIncludesCurrentPlayerWith: aPosition

	^ board includes: {currentPlayer. aPosition }! !

!TerniLapilli methodsFor: 'board testing' stamp: 'DS 11/1/2020 16:25:08'!
currentPlayerHasTokensRemaind

	^ ( board select: [ :aOccupiedPosition | aOccupiedPosition first = currentPlayer ] ) size = 3.! !

!TerniLapilli methodsFor: 'board testing' stamp: 'DS 11/1/2020 16:27:45'!
hasOccupiedPosition: aPosition

	^ ( board collect: [ :aOccupiedPosition | aOccupiedPosition second ] ) includes: aPosition.! !


!TerniLapilli methodsFor: 'private accesing' stamp: 'DS 11/1/2020 16:44:18'!
occupiedPositionsBy: aPlayer

	^board select: [ :aOccupiedPosition | aOccupiedPosition first = aPlayer ].! !


!TerniLapilli methodsFor: 'winner testing' stamp: 'DS 11/1/2020 16:53:11'!
hasDiagonalWonOn: anOccupiedPositionsByPlayer

	^anOccupiedPositionsByPlayer includesAllOf: {-1@1. 0@0. 1@-1}.! !

!TerniLapilli methodsFor: 'winner testing' stamp: 'DS 11/1/2020 16:51:41'!
hasHorizontalWonOn: anOccupiedPositionsByPlayer

	| i isWinner |
	
	i := 1.
	isWinner := true.
	[i < (anOccupiedPositionsByPlayer size) ]	 whileTrue: [
		isWinner := isWinner and: [ ((anOccupiedPositionsByPlayer at: i)	 + (1@	0)) = (anOccupiedPositionsByPlayer at: i+1)	 ].
		i := i+1.
	].

	^ isWinner.! !

!TerniLapilli methodsFor: 'winner testing' stamp: 'DS 11/1/2020 16:53:40'!
hasInvertedDiagonalWonOn: anOccupiedPositionsByPlayer

	^anOccupiedPositionsByPlayer includesAllOf: {-1@-1. 0@0. 1@1}.! !

!TerniLapilli methodsFor: 'winner testing' stamp: 'DS 11/1/2020 16:52:17'!
hasVerticalWonOn: anOccupiedPositionsByPlayer

	| i isWinner |
	
	i := 1.
	isWinner := true.
	[i < (anOccupiedPositionsByPlayer size) ]	 whileTrue: [
		isWinner := isWinner and: [ ((anOccupiedPositionsByPlayer  at: i)	 + (0@	1)) = (anOccupiedPositionsByPlayer at: i+1)	 ].
		i := i+1.
	].

	^ isWinner.! !

!TerniLapilli methodsFor: 'winner testing' stamp: 'DS 11/1/2020 16:55:37'!
hasWonPlayer: aPlayer

	| occupiedPositionsBypPlayer |

	occupiedPositionsBypPlayer := ( ( board select: [ :aOccupiedPosition | aOccupiedPosition first = aPlayer ] ) 
							  	collect: [ :aOccupiedPositionByPlayer | aOccupiedPositionByPlayer second] ) sort.

	^(occupiedPositionsBypPlayer size = 3) and: [
		(self hasHorizontalWonOn: occupiedPositionsBypPlayer) or:
		(self hasVerticalWonOn: occupiedPositionsBypPlayer) or:
		(self hasDiagonalWonOn: occupiedPositionsBypPlayer) or:
		(self hasInvertedDiagonalWonOn: occupiedPositionsBypPlayer)
	].! !


!TerniLapilli methodsFor: 'testing' stamp: 'DS 11/1/2020 00:06:42'!
hasPlayerOWon

	^self hasWonPlayer: #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 11/1/2020 00:06:54'!
hasPlayerXWon

	^self hasWonPlayer: #X.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 10/29/2020 21:16:07'!
isOver

	^(self hasPlayerXWon) or: (self hasPlayerOWon).! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 10/29/2020 17:43:02'!
isPlayingO

	^currentPlayer = #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DS 11/1/2020 16:40:45'!
isPlayingX

	^currentPlayer = #X.! !


!TerniLapilli methodsFor: 'board adding' stamp: 'DS 11/1/2020 16:40:16'!
add: aPosition

	board add: {currentPlayer. aPosition}.
	currentPlayer := self isPlayingX ifTrue: [#O] ifFalse: [#X].! !

!TerniLapilli methodsFor: 'board adding' stamp: 'DS 11/1/2020 14:09:05'!
addMoveOn: aDirection from: aPosition

	| occupiedPosition |

	occupiedPosition := {currentPlayer. aPosition}.
	self add: aPosition + aDirection.
	board remove: occupiedPosition.

	! !


!TerniLapilli methodsFor: 'player actions' stamp: 'DS 11/1/2020 13:45:14'!
putAt: aPosition

	putTokensRules putAt: aPosition.! !


!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 01:03:31'!
moveDownFrom: aPosition

	self moveOn: (0@-1) from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 16:57:21'!
moveLeftDownFrom: aPosition

	({0@1. 1@0} includes: aPosition) ifTrue: [ self signalIlegalDiagonalMovement ].

	self moveOn: (-1@-1) from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 01:04:33'!
moveLeftFrom: aPosition

	self moveOn: (-1@0) from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 16:57:12'!
moveLeftUpFrom: aPosition

	({0@-1. 1@0} includes: aPosition) ifTrue: [ self signalIlegalDiagonalMovement ].

	self moveOn: (-1@1) from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 16:10:06'!
moveOn: aDirection from: aPosition

	 moveOnRules moveOn: aDirection from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 16:58:26'!
moveRightDownFrom: aPosition

	({0@1. -1@0} includes: aPosition) ifTrue: [ self signalIlegalDiagonalMovement ].

	self moveOn: (1@-1) from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 01:05:51'!
moveRightFrom: aPosition

	self moveOn: (1@0) from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 16:58:36'!
moveRightUpFrom: aPosition

	({-1@0. 0@-1} includes: aPosition) ifTrue: [ self signalIlegalDiagonalMovement ].

	self moveOn: (1@1) from: aPosition.! !

!TerniLapilli methodsFor: 'movements' stamp: 'DS 11/1/2020 01:06:47'!
moveUpFrom: aPosition

	self moveOn: (0@1) from: aPosition.! !


!TerniLapilli methodsFor: 'exceptions' stamp: 'DS 11/1/2020 12:27:11'!
signalGameOver

	^ self error: self class gameOverErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'DS 11/1/2020 16:57:12'!
signalIlegalDiagonalMovement

	^ self error: self class ilegalDiagonalMovementErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'DS 11/1/2020 12:27:22'!
signalIlegalMovement

	^ self error: self class ilegalMovementErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'DS 11/1/2020 12:25:05'!
signalNoRemainedTokens

	^ self error: self class noRemainedTokensErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'DS 11/1/2020 12:25:37'!
signalPositionOutOfBoard

	^ self error: self class positionOutOfBoardErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'DS 11/1/2020 15:39:09'!
signalRemainedTokens

	^ self error: self class remainedTokensErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapippiSolution'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/29/2020 18:26:56'!
attemptToPlayTwiceInARowErrorDescription

	^'Can not play twice in a row'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/29/2020 21:11:33'!
gameOverErrorDescription

	^'Game Over'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 11/1/2020 01:19:03'!
ilegalDiagonalMovementErrorDescription

	^'Can not move on this diagonal'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 11/1/2020 01:19:34'!
ilegalMovementErrorDescription

	^'Can not do this movement'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/29/2020 18:54:32'!
noRemainedTokensErrorDescription

	^'No Remained Tokens'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 10/31/2020 18:13:13'!
positionOutOfBoardErrorDescription

	^'Position out of board'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'DS 11/1/2020 02:04:54'!
remainedTokensErrorDescription

	^'Can not move when has Remained Tokens'.! !


!TerniLapilli class methodsFor: 'rules' stamp: 'DS 11/1/2020 16:59:38'!
buildRules: aKindOfRule for: aTerniLapilliGame

	^RemainedTokensRuleDecorator for: aTerniLapilliGame decorating: (
		GameOverRuleDecorator for: aTerniLapilliGame decorating: (
			PlayingInBoardRuleDecorator for: aTerniLapilliGame decorating: (
				OccupiedPositionRuleDecorator for: aTerniLapilliGame decorating: (			aKindOfRule for: aTerniLapilliGame 	)
			)
		)
	).! !

!TerniLapilli class methodsFor: 'rules' stamp: 'DS 11/1/2020 17:00:07'!
moveOnRulesFor: aTerniLapilliGame

	^self buildRules: MoveOnRule for: aTerniLapilliGame.! !

!TerniLapilli class methodsFor: 'rules' stamp: 'DS 11/1/2020 16:59:57'!
putTokenRulesFor: aTerniLapilliGame

	^self buildRules: PutTokensRule for: aTerniLapilliGame.! !


!classDefinition: #TerniLapilliRules category: 'TerniLapippiSolution'!
Object subclass: #TerniLapilliRules
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!TerniLapilliRules methodsFor: 'initialization' stamp: 'DS 11/1/2020 12:21:43'!
initializateFor: aGame

	game := aGame.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliRules class' category: 'TerniLapippiSolution'!
TerniLapilliRules class
	instanceVariableNames: ''!

!TerniLapilliRules class methodsFor: 'class initialization' stamp: 'DS 11/1/2020 12:21:59'!
for: aGame

	^self new initializateFor: aGame.! !


!classDefinition: #MoveOnRule category: 'TerniLapippiSolution'!
TerniLapilliRules subclass: #MoveOnRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!MoveOnRule methodsFor: 'game plays' stamp: 'DS 11/1/2020 16:07:48'!
moveOn: aDirection from: aPosition

	game addMoveOn: aDirection from: aPosition.! !


!classDefinition: #PutTokensRule category: 'TerniLapippiSolution'!
TerniLapilliRules subclass: #PutTokensRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!PutTokensRule methodsFor: 'game plays' stamp: 'DS 11/1/2020 12:23:12'!
putAt: aPosition

	game add: aPosition.! !


!classDefinition: #TerniLapilliRulesDecorator category: 'TerniLapippiSolution'!
TerniLapilliRules subclass: #TerniLapilliRulesDecorator
	instanceVariableNames: 'decoratee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!TerniLapilliRulesDecorator methodsFor: 'initialization' stamp: 'DS 11/1/2020 12:31:42'!
initializateFor: aGame decorating: aTerniLapilliRule

	game := aGame.
	decoratee := aTerniLapilliRule.! !


!TerniLapilliRulesDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 16:16:53'!
moveOn: aDirection from: aPosition

	self subclassResponsibility.! !

!TerniLapilliRulesDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 12:29:07'!
putAt: aPosition

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliRulesDecorator class' category: 'TerniLapippiSolution'!
TerniLapilliRulesDecorator class
	instanceVariableNames: ''!

!TerniLapilliRulesDecorator class methodsFor: 'instance creation' stamp: 'DS 11/1/2020 12:30:18'!
for: aGame decorating: aTerniLapilliRule

	^self new initializateFor: aGame decorating: aTerniLapilliRule.! !


!classDefinition: #GameOverRuleDecorator category: 'TerniLapippiSolution'!
TerniLapilliRulesDecorator subclass: #GameOverRuleDecorator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!GameOverRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 15:45:30'!
moveOn: aDirection from: aPosition

	(game isOver) ifTrue: [ game signalGameOver ].

	decoratee moveOn: aDirection from: aPosition.! !

!GameOverRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 12:47:50'!
putAt: aPosition

	(game isOver) ifTrue: [ game signalGameOver ].

	decoratee putAt: aPosition.! !


!classDefinition: #OccupiedPositionRuleDecorator category: 'TerniLapippiSolution'!
TerniLapilliRulesDecorator subclass: #OccupiedPositionRuleDecorator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!OccupiedPositionRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 16:28:04'!
moveOn: aDirection from: aPosition

	(game hasOccupiedPosition: aPosition + aDirection) 				ifTrue: [ game signalIlegalMovement ].
	(game boardIncludesCurrentPlayerWith: aPosition ) ifFalse: [ game signalIlegalMovement ].	

	decoratee moveOn: aDirection from: aPosition.! !

!OccupiedPositionRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 16:28:16'!
putAt: aPosition

	(game hasOccupiedPosition: aPosition) 		ifTrue: [ game signalIlegalMovement ].

	decoratee putAt: aPosition.! !


!classDefinition: #PlayingInBoardRuleDecorator category: 'TerniLapippiSolution'!
TerniLapilliRulesDecorator subclass: #PlayingInBoardRuleDecorator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!PlayingInBoardRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 15:48:04'!
moveOn: aDirection from: aPosition

	(aPosition between: (-1@-1) and: (1@1)) ifFalse: [ game signalPositionOutOfBoard ].

	decoratee moveOn: aDirection from: aPosition.! !

!PlayingInBoardRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 12:46:35'!
putAt: aPosition

	(aPosition between: (-1@-1) and: (1@1)) ifFalse: [ game signalPositionOutOfBoard ].

	decoratee putAt: aPosition.! !


!classDefinition: #RemainedTokensRuleDecorator category: 'TerniLapippiSolution'!
TerniLapilliRulesDecorator subclass: #RemainedTokensRuleDecorator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapippiSolution'!

!RemainedTokensRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 16:23:18'!
moveOn: aDirection from: aPosition

	( game currentPlayerHasTokensRemaind ) 	ifFalse: [ game signalRemainedTokens ].

	^decoratee moveOn: aDirection from: aPosition.! !

!RemainedTokensRuleDecorator methodsFor: 'game plays' stamp: 'DS 11/1/2020 16:23:12'!
putAt: aPosition

	( game currentPlayerHasTokensRemaind ) 	ifTrue: [ game signalNoRemainedTokens ].

	^decoratee putAt: aPosition.! !
