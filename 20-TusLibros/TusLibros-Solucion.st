!classDefinition: #CartTest category: 'TusLibros-Solucion'!
TestCase subclass: #CartTest
	instanceVariableNames: 'isbn1 isbn2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CartTest methodsFor: 'ocurrences' stamp: 'FedericoSabatini 11/17/2020 12:08:20'!
test01NewCartIsEmptyWithNoOcurrences
	
	| aCart |
	
	aCart := Cart new.
	
	self assert: aCart isEmpty.
	self assert: 0 equals: (aCart ocurrencesOf: isbn1).! !

!CartTest methodsFor: 'ocurrences' stamp: 'FedericoSabatini 11/17/2020 12:10:54'!
test02CartShouldHaveOneOcurrenceOnAddingOneBook
	
	| aCart |
	
	aCart := Cart new.
	aCart add: isbn1.
	
	self deny: aCart isEmpty.
	self assert: (aCart isBookOnCart: isbn1).
	self assert: 1 equals: (aCart ocurrencesOf: isbn1).! !

!CartTest methodsFor: 'ocurrences' stamp: 'FedericoSabatini 11/17/2020 12:03:25'!
test03CartShouldHaveManyOcurrencesOnAddingSameBookMultipleTimes
	
	| aCart |
	
	aCart := Cart new.
	
	aCart add: isbn1 withOcurrences: 5.
	
	self assert: 5 equals: (aCart ocurrencesOf: isbn1).! !


!CartTest methodsFor: 'setup' stamp: 'FedericoSabatini 11/16/2020 19:31:03'!
setUp

	isbn1 := 100000.
	isbn2 := 100001.! !


!classDefinition: #Cart category: 'TusLibros-Solucion'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cart methodsFor: 'testing' stamp: 'FedericoSabatini 11/17/2020 11:52:39'!
isBookOnCart: aBookISBN
	^books includes: aBookISBN.! !

!Cart methodsFor: 'testing' stamp: 'FedericoSabatini 11/17/2020 11:51:44'!
isEmpty
	^books size = 0! !


!Cart methodsFor: 'initialization' stamp: 'FedericoSabatini 11/17/2020 11:50:54'!
initialize
	books := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'FedericoSabatini 11/17/2020 12:10:39'!
add: aBook 
	books add: aBook.
	 ! !

!Cart methodsFor: 'adding' stamp: 'FedericoSabatini 11/17/2020 12:01:44'!
add: aBook withOcurrences: ocurrences 
	books add: aBook withOccurrences: ocurrences.
	 ! !


!Cart methodsFor: 'ocurrences' stamp: 'FedericoSabatini 11/17/2020 11:52:36'!
ocurrencesOf: aBookISBN
	^books occurrencesOf: aBookISBN! !
