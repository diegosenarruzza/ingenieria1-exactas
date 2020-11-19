!classDefinition: #CartTest category: 'TusLibros-Solucion'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalog isbn1 isbn2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CartTest methodsFor: 'setup' stamp: 'DS 11/18/2020 00:34:19'!
setUp

	catalog := OrderedCollection new.
	isbn1 := 100000.
	isbn2 := 100001.! !


!CartTest methodsFor: 'adding' stamp: 'DS 11/19/2020 00:26:21'!
test01NewCartIsEmpty
	
	| aCart |

	aCart := Cart with: catalog.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/19/2020 00:29:54'!
test02CartShouldHaveOneOfABookWhenAddingIt
	
	|  aCart |

	catalog add: isbn1.

	aCart := Cart with: catalog.
	aCart add: 1 of: isbn1.
	
	self deny: aCart isEmpty.
	self assert: 1 equals: (aCart howManyOf: isbn1).! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/19/2020 00:30:14'!
test03CartShouldHaveManyBooksWhenAddingMany
	
	| aCart |

	catalog add: isbn1.
	catalog add: isbn2.

	aCart := Cart with: catalog.
	aCart add: 5 of: isbn1.
	aCart add: 2 of: isbn2.
	
	self assert: 5 equals: (aCart howManyOf: isbn1).
	self assert: 2 equals: (aCart howManyOf: isbn2).! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/19/2020 00:21:38'!
test04CanNotAddABookOutOfCatalog
	
	| aCart |

	catalog add: isbn2.
	aCart := Cart with: catalog.

	self should: [ aCart add: 1 of: isbn1. ]
		raise: Error
		withMessageText: Cart bookIsOutOfCatalogErrorDescription.! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/19/2020 00:21:46'!
test05CanNotAddLessThanOneBook
	
	| aCart |

	catalog add: isbn2.
	aCart := Cart with: catalog.

	self should: [ aCart add: -1 of: isbn2. ]
		raise: Error
		withMessageText: Cart canNotAddLessThanOneBookErrorDescription.! !


!CartTest methodsFor: 'list' stamp: 'DS 11/18/2020 00:50:03'!
test06NewCartHaveEmptyList

	| aCart |

	aCart := Cart with: catalog.

	self assert: aCart list isEmpty.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/19/2020 00:32:10'!
test07CartShouldHaveListWithOneOfABookWhenAddingIt

	| aCart |

	catalog add: isbn1.

	aCart := Cart with: catalog.
	aCart add: 1 of: isbn1.

	self assert: (Dictionary newFromPairs: {isbn1. 1} ) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/19/2020 00:32:37'!
test08CartShouldHaveListWithManyBooksWhenAddingMany

	| aCart |

	catalog add: isbn1.
	catalog add: isbn2.

	aCart := Cart with: catalog.
	aCart add: 2 of: isbn1.
	aCart add: 1 of: isbn2.

	self assert: (Dictionary newFromPairs: {isbn1. 2. isbn2. 1}) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/19/2020 00:34:26'!
test09ModifyCartListShouldNotModifyTheCart

	| aCart list |

	catalog add: isbn1.
	catalog add: isbn2.

	aCart := Cart with: catalog.
	aCart add: 1 of: isbn1.
	aCart add: 1 of: isbn2.
	
	list := aCart list.
	list removeKey: isbn1.

	self assert: (Dictionary newFromPairs: {isbn1. 1. isbn2. 1}) equals: aCart list.! !


!classDefinition: #Cart category: 'TusLibros-Solucion'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cart methodsFor: 'initialization' stamp: 'DS 11/18/2020 00:13:25'!
initializeWith: aCatalog 

	catalog := aCatalog.
	books := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'DS 11/19/2020 00:21:07'!
add: aQuantity of: aBook

	(aQuantity > 0) ifFalse: [ self signalCanNotAddLessThanOneBook ].
	(catalog includes: aBook) ifFalse: [ self signalBookIsOutOfCatalog ].

	books add: aBook withOccurrences: aQuantity.! !


!Cart methodsFor: 'accessing' stamp: 'DS 11/19/2020 00:25:39'!
howManyOf: aBook

	^books occurrencesOf: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'DS 11/19/2020 00:07:22'!
list

	^books contents copy.! !


!Cart methodsFor: 'testing' stamp: 'DS 11/19/2020 00:24:22'!
isEmpty

	^books isEmpty.! !


!Cart methodsFor: 'errors' stamp: 'DS 11/18/2020 00:38:43'!
signalBookIsOutOfCatalog

	^ self error: self class bookIsOutOfCatalogErrorDescription! !

!Cart methodsFor: 'errors' stamp: 'DS 11/18/2020 23:53:35'!
signalCanNotAddLessThanOneBook

	^ self error: self class canNotAddLessThanOneBookErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Solucion'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'DS 11/18/2020 00:12:34'!
with: aCatalog

	^self new initializeWith: aCatalog.! !


!Cart class methodsFor: 'error descriptions' stamp: 'DS 11/18/2020 00:26:48'!
bookIsOutOfCatalogErrorDescription

	^'The book you are trying to add is out of catalog'.! !

!Cart class methodsFor: 'error descriptions' stamp: 'DS 11/18/2020 23:51:26'!
canNotAddLessThanOneBookErrorDescription

	^'Can not add less than one book'.! !
