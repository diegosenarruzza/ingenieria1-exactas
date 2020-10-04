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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head hight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'DS 10/4/2020 16:00:10'!
initialize

	head := NonElement new.
	hight := 0.! !


!OOStack methodsFor: 'operations' stamp: 'DS 10/4/2020 16:00:39'!
pop

	| oldTop |
	
	oldTop := self top.
	head := head unstack.
	hight := hight - 1.

	^oldTop.! !

!OOStack methodsFor: 'operations' stamp: 'DS 10/4/2020 16:00:23'!
push: aValue

	| newHead |
	
	newHead := Element with: aValue on: head.

	head := newHead.
	hight := hight + 1.! !


!OOStack methodsFor: 'value' stamp: 'DS 10/4/2020 16:00:46'!
size

	^hight.! !

!OOStack methodsFor: 'value' stamp: 'DS 10/4/2020 14:49:14'!
top

	^head value.! !


!OOStack methodsFor: 'testing' stamp: 'DS 10/4/2020 16:06:59'!
isEmpty

	^head isAnElement not.! !

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

!OOStackElement methodsFor: 'operations' stamp: 'DS 10/4/2020 15:21:44'!
stackOn: anElement

	self subclassResponsibility.! !

!OOStackElement methodsFor: 'operations' stamp: 'DS 10/4/2020 16:10:42'!
unstack

	self subclassResponsibility.! !


!OOStackElement methodsFor: 'value' stamp: 'DS 10/4/2020 16:11:48'!
value

	self subclassResponsibility.! !


!OOStackElement methodsFor: 'testing' stamp: 'DS 10/4/2020 15:58:07'!
isAnElement

	self subclassResponsibility.! !


!classDefinition: #Element category: #'Stack-Exercise'!
OOStackElement subclass: #Element
	instanceVariableNames: 'value lower'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'initialization' stamp: 'DS 10/4/2020 15:49:39'!
initializeWith: aValue on: anElement

	value := aValue.
	lower := anElement.! !


!Element methodsFor: 'operations' stamp: 'DS 10/4/2020 15:48:01'!
stackOn: anElement

	lower := anElement.! !

!Element methodsFor: 'operations' stamp: 'DS 10/4/2020 15:53:48'!
unstack

	^lower.! !


!Element methodsFor: 'value' stamp: 'DS 10/3/2020 23:55:37'!
value

	^value.! !


!Element methodsFor: 'testing' stamp: 'DS 10/4/2020 15:58:24'!
isAnElement

	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Element class' category: #'Stack-Exercise'!
Element class
	instanceVariableNames: ''!

!Element class methodsFor: 'initialization' stamp: 'DS 10/4/2020 16:16:07'!
with: aValue on: anElement

	^self new initializeWith: aValue on: anElement.! !


!classDefinition: #NonElement category: #'Stack-Exercise'!
OOStackElement subclass: #NonElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonElement methodsFor: 'operations' stamp: 'DS 10/4/2020 15:24:40'!
stackOn: anElement

	self error: self class stackOnErrorDescription.! !

!NonElement methodsFor: 'operations' stamp: 'DS 10/4/2020 15:54:14'!
unstack

	self error: OOStack stackEmptyErrorDescription.! !


!NonElement methodsFor: 'value' stamp: 'DS 10/4/2020 14:42:21'!
value

	self error: OOStack stackEmptyErrorDescription.! !


!NonElement methodsFor: 'testing' stamp: 'DS 10/4/2020 16:03:21'!
isAnElement

	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonElement class' category: #'Stack-Exercise'!
NonElement class
	instanceVariableNames: ''!

!NonElement class methodsFor: 'error descriptions' stamp: 'DS 10/4/2020 15:24:45'!
stackOnErrorDescription

	^'a Non Element cannot stack on anyone element'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
