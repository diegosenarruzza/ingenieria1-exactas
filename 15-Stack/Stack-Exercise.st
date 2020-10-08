!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack emptyPrefix spacePrefix winterPrefix sentence1 sentence2 sentenceCaseSentitive'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Federico 10/7/2020 08:30:24'!
test01AddNothingFindNothing

	| sentenceFinder |

	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: winterPrefix) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:57:33'!
test02CannotFindWhenPrefixIsEmpty

	| sentenceFinder |

	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder find: emptyPrefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:57:38'!
test03CannotFindWhenPrefixHasSpaces

	| sentenceFinder |

	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder find: spacePrefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:16:42'!
test04FindWithPrefixAsSentenceContainsItself

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix with: winterPrefix.
	
	self assert: (sentenceFinder find: winterPrefix) = (OrderedCollection with: winterPrefix)! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Federico 10/7/2020 08:26:06'!
test05FindPrefixOfSentenceIsCorrect

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix with: sentence1.
	
	self assert: (sentenceFinder find: winterPrefix) = (OrderedCollection with: sentence1).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Federico 10/7/2020 08:26:28'!
test06AddRepeatedSentenceFindItRepeated

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentenceFinder
		add: sentence1;
		add: sentence1;
		add: sentence1.
	
	self assert: (sentenceFinder find: winterPrefix) = (OrderedCollection with: sentence1 with: sentence1 with: sentence1).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Federico 10/7/2020 08:27:36'!
test07FindIsCorrectWhenHasDifferentSentences

	| sentenceFinder expectedCollection |
	
	sentenceFinder := SentenceFinderByPrefix with: sentence1.
	sentenceFinder
		add: 'the north remember';
		add: 'the king in the north';
		add: sentence2.

	expectedCollection  := OrderedCollection with: sentence1 with: sentence2.

	self assert: (sentenceFinder find: winterPrefix) sort = expectedCollection sort.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Federico 10/7/2020 08:28:02'!
test08FindIsKeySensitive

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix with: sentence1.
	sentenceFinder 		add: sentenceCaseSentitive.

	self assert: (sentenceFinder find: winterPrefix) sort = (OrderedCollection with: sentence1).! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'Federico 10/7/2020 08:29:42'!
setUp
	stack := OOStack new.
	emptyPrefix := ''.
	spacePrefix := ' '.
	winterPrefix := 'winter'.
	sentence1 := 'winter is coming'.
	sentence2 := 'winter is here'.
	sentenceCaseSentitive := 'Winter is here'.
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head hight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'DS 10/5/2020 21:48:36'!
initialize

	head := BaseElement new.
	hight := 0.! !


!OOStack methodsFor: 'accesing' stamp: 'DS 10/7/2020 23:58:23'!
pop

	| oldHead |
	
	oldHead := self top.
	head := head unstack.
	hight := hight - 1.

	^oldHead.! !

!OOStack methodsFor: 'accesing' stamp: 'DS 10/4/2020 16:00:23'!
push: aValue

	| newHead |
	
	newHead := Element with: aValue on: head.

	head := newHead.
	hight := hight + 1.! !

!OOStack methodsFor: 'accesing' stamp: 'DS 10/4/2020 16:00:46'!
size

	^hight.! !

!OOStack methodsFor: 'accesing' stamp: 'DS 10/4/2020 14:49:14'!
top

	^head value.! !


!OOStack methodsFor: 'testing' stamp: 'DS 10/5/2020 21:49:09'!
isEmpty

	^head isBase.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accesing' stamp: 'DS 10/4/2020 15:21:44'!
stackOn: anElement

	self subclassResponsibility.! !

!OOStackElement methodsFor: 'accesing' stamp: 'DS 10/4/2020 16:10:42'!
unstack

	self subclassResponsibility.! !

!OOStackElement methodsFor: 'accesing' stamp: 'DS 10/4/2020 16:11:48'!
value

	self subclassResponsibility.! !


!OOStackElement methodsFor: 'testing' stamp: 'DS 10/7/2020 23:52:20'!
isBase

	self subclassResponsibility.! !


!classDefinition: #BaseElement category: #'Stack-Exercise'!
OOStackElement subclass: #BaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseElement methodsFor: 'accesing' stamp: 'DS 10/4/2020 15:24:40'!
stackOn: anElement

	self error: self class stackOnErrorDescription.! !

!BaseElement methodsFor: 'accesing' stamp: 'DS 10/4/2020 15:54:14'!
unstack

	self error: OOStack stackEmptyErrorDescription.! !

!BaseElement methodsFor: 'accesing' stamp: 'DS 10/4/2020 14:42:21'!
value

	self error: OOStack stackEmptyErrorDescription.! !


!BaseElement methodsFor: 'testing' stamp: 'DS 10/5/2020 21:48:51'!
isBase

	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BaseElement class' category: #'Stack-Exercise'!
BaseElement class
	instanceVariableNames: ''!

!BaseElement class methodsFor: 'error descriptions' stamp: 'DS 10/7/2020 23:54:13'!
stackOnErrorDescription

	^'a Base Element cannot stack on anyone element'! !


!classDefinition: #Element category: #'Stack-Exercise'!
OOStackElement subclass: #Element
	instanceVariableNames: 'value lower'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'initialization' stamp: 'DS 10/7/2020 23:56:31'!
initializeWith: aValue on: anElement

	value := aValue.
	lower := anElement.! !


!Element methodsFor: 'accesing' stamp: 'DS 10/4/2020 15:48:01'!
stackOn: anElement

	lower := anElement.! !

!Element methodsFor: 'accesing' stamp: 'DS 10/4/2020 15:53:48'!
unstack

	^lower.! !

!Element methodsFor: 'accesing' stamp: 'DS 10/3/2020 23:55:37'!
value

	^value.! !


!Element methodsFor: 'testing' stamp: 'DS 10/5/2020 21:49:02'!
isBase

	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Element class' category: #'Stack-Exercise'!
Element class
	instanceVariableNames: ''!

!Element class methodsFor: 'initialization' stamp: 'DS 10/7/2020 23:56:44'!
with: aValue on: anElement

	^self new initializeWith: aValue on: anElement.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'DS 10/7/2020 23:47:03'!
saveSentencesIn: collection ifContains: aValidPrefix

	| top |

	top := stack pop.

	(top 	includesSubString: aValidPrefix) ifTrue: [collection add: top].
	collection addAllLast: (self selectSentencesWithValidPrefix: aValidPrefix).

	stack push: top.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'DS 10/7/2020 23:46:58'!
selectSentencesWithValidPrefix: aValidPrefix

	| collection |

	collection := OrderedCollection new.

	stack isEmpty ifFalse: [self saveSentencesIn: collection ifContains: aValidPrefix].

	^collection.! !


!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'DS 10/7/2020 00:11:10'!
add: aSentence

	stack push: aSentence.! !

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'DS 10/7/2020 23:37:33'!
find: aPrefix

	(self isInvalidPrefix: aPrefix) ifTrue: [^self invalidPrefixError].

	^self selectSentencesWithValidPrefix: aPrefix.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'DS 10/6/2020 23:36:32'!
initialize

	stack := OOStack new.! !

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'DS 10/7/2020 00:45:16'!
initializeWIth: aSentence

	self add: aSentence.! !


!SentenceFinderByPrefix methodsFor: 'comparing' stamp: 'DS 10/7/2020 00:58:56'!
isInvalidPrefix: aPrefix

	^(aPrefix isEmpty) or: (aPrefix includesSubString: ' ').! !


!SentenceFinderByPrefix methodsFor: 'errors' stamp: 'DS 10/7/2020 00:56:58'!
invalidPrefixError

	^self error: self class invalidPrefixErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'DS 10/6/2020 23:40:35'!
with: aSentence

	^self new initializeWIth: aSentence.! !


!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'DS 10/7/2020 00:54:31'!
invalidPrefixErrorDescription

	^'prefix is invalid!!'.! !
