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


!CartTest methodsFor: 'ocurrences' stamp: 'DS 11/18/2020 00:33:49'!
test01NewCartIsEmptyWithNoOcurrences
	
	| aCart |

	aCart := Cart with: catalog.
	
	self assert: aCart isEmpty.
	self assert: 0 equals: (aCart ocurrencesOf: isbn1).! !

!CartTest methodsFor: 'ocurrences' stamp: 'DS 11/18/2020 00:33:19'!
test02CartShouldHaveOneOcurrenceOnAddingOneBook
	
	|  aCart |

	catalog add: isbn1.
	aCart := Cart with: catalog.
	aCart add: isbn1.
	
	self deny: aCart isEmpty.
	self assert: (aCart isBookOnCart: isbn1).
	self assert: 1 equals: (aCart ocurrencesOf: isbn1).! !

!CartTest methodsFor: 'ocurrences' stamp: 'DS 11/18/2020 00:34:01'!
test03CartShouldHaveManyOcurrencesOnAddingSameBookMultipleTimes
	
	| aCart |

	catalog add: isbn1.
	aCart := Cart with: catalog.
	
	aCart add: isbn1 withOcurrences: 5.
	
	self assert: 5 equals: (aCart ocurrencesOf: isbn1).! !

!CartTest methodsFor: 'ocurrences' stamp: 'DS 11/18/2020 00:37:14'!
test04CanNotAddBookWithNoOcurrencesOutOfCatalog
	
	| aCart |

	catalog add: isbn2.
	aCart := Cart with: catalog.

	self should: [ aCart add: isbn1. ]
		raise: Error
		withMessageText: Cart bookIsOutOfCatalogErrorDescription.! !

!CartTest methodsFor: 'ocurrences' stamp: 'DS 11/18/2020 00:37:10'!
test05CanNotAddBookWithManyOcurrencesOutOfCatalog
	
	| aCart |

	catalog add: isbn2.
	aCart := Cart with: catalog.

	self should: [ aCart add: isbn1 withOcurrences: 2. ]
		raise: Error
		withMessageText: Cart bookIsOutOfCatalogErrorDescription.! !


!CartTest methodsFor: 'list' stamp: 'DS 11/18/2020 00:50:03'!
test06NewCartHaveEmptyList

	| aCart |

	aCart := Cart with: catalog.

	self assert: aCart list isEmpty.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/18/2020 00:51:30'!
test07CartShouldHaveListWithOneOcurrenceOnAddingOneBook

	| aCart |

	catalog add: isbn1.

	aCart := Cart with: catalog.
	aCart add: isbn1.

	self assert: (Bag with: isbn1) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/18/2020 00:52:34'!
test08CartShouldHaveListWithManyOcurrencesOnAddingManyBooks

	| aCart |

	catalog add: isbn1.
	catalog add: isbn2.

	aCart := Cart with: catalog.
	aCart add: isbn1 withOcurrences: 2.
	aCart add: isbn2.

	self assert: (Bag with: isbn1 with: isbn1 with: isbn2) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/18/2020 00:59:50'!
test09ListReturnedShouldBeACopyOfCartList

	| aCart list |

	catalog add: isbn1.
	catalog add: isbn2.

	aCart := Cart with: catalog.
	aCart add: isbn1.
	aCart add: isbn2.
	
	list := aCart list.
	list remove: isbn1.

	self assert: (Bag with: isbn1 with: isbn2) equals: aCart list.! !


!classDefinition: #Cart category: 'TusLibros-Solucion'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cart methodsFor: 'testing' stamp: 'FedericoSabatini 11/17/2020 11:52:39'!
isBookOnCart: aBookISBN
	^books includes: aBookISBN.! !

!Cart methodsFor: 'testing' stamp: 'FedericoSabatini 11/17/2020 11:51:44'!
isEmpty
	^books size = 0! !


!Cart methodsFor: 'initialization' stamp: 'DS 11/18/2020 00:13:25'!
initializeWith: aCatalog 

	catalog := aCatalog.
	books := Bag new.! !


!Cart methodsFor: 'errors' stamp: 'DS 11/18/2020 00:38:43'!
signalBookIsOutOfCatalog

	^ self error: self class bookIsOutOfCatalogErrorDescription! !


!Cart methodsFor: 'adding' stamp: 'DS 11/18/2020 00:37:48'!
add: aBook 

	self add: aBook withOcurrences: 1.
	 ! !

!Cart methodsFor: 'adding' stamp: 'DS 11/18/2020 00:38:43'!
add: aBook withOcurrences: ocurrences

	(catalog includes: aBook) ifFalse: [ self signalBookIsOutOfCatalog ].

	books add: aBook withOccurrences: ocurrences.! !


!Cart methodsFor: 'ocurrences' stamp: 'FedericoSabatini 11/17/2020 11:52:36'!
ocurrencesOf: aBookISBN
	^books occurrencesOf: aBookISBN! !


!Cart methodsFor: 'accessing' stamp: 'DS 11/18/2020 00:58:46'!
list

	^books copy.! !

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
