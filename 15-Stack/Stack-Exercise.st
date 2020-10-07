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
	instanceVariableNames: 'emptyPrefix spacePrefix winterPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:05:24'!
test01AddNothingFindNothing

	| sentenceFinder  prefix |

	prefix := 'winter'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: prefix) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/6/2020 23:37:19'!
test02CannotFindWhenPrefixIsEmpty

	| sentenceFinder |

	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder find: emptyPrefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/6/2020 23:37:26'!
test03CannotFindWhenPrefixHasSpaces

	| sentenceFinder |

	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder find: spacePrefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixSpacesErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:16:42'!
test04FindWithPrefixAsSentenceContainsItself

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix with: winterPrefix.
	
	self assert: (sentenceFinder find: winterPrefix) = (OrderedCollection with: winterPrefix)! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:17:46'!
test05FindPrefixOfSentenceIsCorrect

	| sentenceFinder sentence |
	
	sentence := 'winter is coming'.
	sentenceFinder := SentenceFinderByPrefix with: sentence.
	
	self assert: (sentenceFinder find: winterPrefix) = (OrderedCollection with: sentence).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:23:43'!
test06AddRepeatedSentenceFindItRepeated

	| sentenceFinder sentence |
	
	sentence := 'winter is coming'.
	sentenceFinder := SentenceFinderByPrefix new.
	sentenceFinder
		add: sentence;
		add: sentence;
		add: sentence.
	
	self assert: (sentenceFinder find: winterPrefix) = (OrderedCollection with: sentence with: sentence with: sentence).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:39:15'!
test07FindIsCorrectWhenHasDifferentSentences

	| sentenceFinder sentenceToFind1 sentenceToFind2 expectedCollection |
	
	sentenceToFind1 := 'winter is coming'.
	sentenceToFind2 := 'winter is here'.
	sentenceFinder := SentenceFinderByPrefix with: sentenceToFind1.
	sentenceFinder
		add: 'the north remember';
		add: 'the king in the north';
		add: sentenceToFind2.

	expectedCollection  := OrderedCollection with: sentenceToFind1 with: sentenceToFind2.

	self assert: (sentenceFinder find: winterPrefix) sort = expectedCollection sort.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'DS 10/7/2020 00:41:44'!
test08FindIsKeySensitive

	| sentenceFinder sentenceToFind |
	
	sentenceToFind := 'winter is coming'.
	sentenceFinder := SentenceFinderByPrefix with: sentenceToFind.
	sentenceFinder 		add: 'Winter is here'.

	self assert: (sentenceFinder find: winterPrefix) sort = (OrderedCollection with: sentenceToFind).! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'DS 10/6/2020 23:36:50'!
setUp

	emptyPrefix := ''.
	spacePrefix := ' '.
	winterPrefix := 'winter'.
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


!OOStack methodsFor: 'accesing' stamp: 'DS 10/4/2020 16:00:39'!
pop

	| oldTop |
	
	oldTop := self top.
	head := head unstack.
	hight := hight - 1.

	^oldTop.! !

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


!OOStackElement methodsFor: 'testing' stamp: 'DS 10/4/2020 15:58:07'!
isAnElement

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

!BaseElement class methodsFor: 'error descriptions' stamp: 'DS 10/4/2020 15:24:45'!
stackOnErrorDescription

	^'a Non Element cannot stack on anyone element'! !


!classDefinition: #Element category: #'Stack-Exercise'!
OOStackElement subclass: #Element
	instanceVariableNames: 'value lower'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'initialization' stamp: 'DS 10/5/2020 17:26:44'!
initializeWith: aValue on: stack

	value := aValue.
	lower := stack.! !


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

!Element class methodsFor: 'initialization' stamp: 'DS 10/5/2020 17:26:35'!
with: aValue on: stack

	^self new initializeWith: aValue on: stack.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'DS 10/7/2020 00:11:10'!
add: aSentence

	stack push: aSentence.! !

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'Federico 10/5/2020 21:20:24'!
find: prefix

	| collection top |
	
	prefix isEmpty ifTrue: [^self error: self class prefixEmptyErrorDescription].
	(prefix includesSubString: ' ') ifTrue: [^self error: self class prefixSpacesErrorDescription].

	collection := OrderedCollection new.
	
	stack isEmpty ifTrue: [^collection].

	top := stack pop.
	(top 	includesSubString: prefix) ifTrue: [collection add: top].
	
	collection addAllLast: (self find: prefix).
	stack push: top.
	

	^collection.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'DS 10/6/2020 23:36:32'!
initialize

	stack := OOStack new.! !

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'DS 10/6/2020 23:40:23'!
initializeWIth: aSentence

	stack push: aSentence.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'DS 10/6/2020 23:40:35'!
with: aSentence

	^self new initializeWIth: aSentence.! !


!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'DS 10/5/2020 18:35:57'!
prefixEmptyErrorDescription

	^'prefix cannot be empty'.! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'DS 10/5/2020 20:56:00'!
prefixSpacesErrorDescription

	^'prefix cannot has spaces'.! !
