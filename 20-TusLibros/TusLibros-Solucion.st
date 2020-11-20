!classDefinition: #CartTest category: 'TusLibros-Solucion'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalog isbn1 isbn2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CartTest methodsFor: 'setup' stamp: 'FedericoSabatini 11/19/2020 19:20:29'!
setUp

	catalog := Dictionary new.
	isbn1 := 100000.
	isbn2 := 100001.! !


!CartTest methodsFor: 'adding' stamp: 'DS 11/19/2020 00:26:21'!
test01NewCartIsEmpty
	
	| aCart |

	aCart := Cart with: catalog.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'adding' stamp: 'FedericoSabatini 11/19/2020 19:21:40'!
test02CartShouldHaveOneOfABookWhenAddingIt
	
	|  aCart |

	catalog at: isbn1 put: 100.

	aCart := Cart with: catalog.
	aCart add: 1 of: isbn1.
	
	self deny: aCart isEmpty.
	self assert: 1 equals: (aCart howManyOf: isbn1).! !

!CartTest methodsFor: 'adding' stamp: 'FedericoSabatini 11/19/2020 19:21:59'!
test03CartShouldHaveManyBooksWhenAddingMany
	
	| aCart |

	catalog at: isbn1 put: 100.
	catalog at: isbn2 put: 100.

	aCart := Cart with: catalog.
	aCart add: 5 of: isbn1.
	aCart add: 2 of: isbn2.
	
	self assert: 5 equals: (aCart howManyOf: isbn1).
	self assert: 2 equals: (aCart howManyOf: isbn2).! !

!CartTest methodsFor: 'adding' stamp: 'FedericoSabatini 11/19/2020 19:22:11'!
test04CanNotAddABookOutOfCatalog
	
	| aCart |

	catalog at: isbn2 put: 100.
	aCart := Cart with: catalog.

	self should: [ aCart add: 1 of: isbn1. ]
		raise: Error
		withMessageText: Cart bookIsOutOfCatalogErrorDescription.! !

!CartTest methodsFor: 'adding' stamp: 'FedericoSabatini 11/19/2020 19:22:24'!
test05CanNotAddLessThanOneBook
	
	| aCart |

	catalog at: isbn2 put: 100.
	aCart := Cart with: catalog.

	self should: [ aCart add: -1 of: isbn2. ]
		raise: Error
		withMessageText: Cart canNotAddLessThanOneBookErrorDescription.! !


!CartTest methodsFor: 'list' stamp: 'DS 11/18/2020 00:50:03'!
test06NewCartHaveEmptyList

	| aCart |

	aCart := Cart with: catalog.

	self assert: aCart list isEmpty.! !

!CartTest methodsFor: 'list' stamp: 'FedericoSabatini 11/19/2020 19:22:36'!
test07CartShouldHaveListWithOneOfABookWhenAddingIt

	| aCart |

	catalog at: isbn1 put: 100.

	aCart := Cart with: catalog.
	aCart add: 1 of: isbn1.

	self assert: (Dictionary newFromPairs: {isbn1. 1} ) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'FedericoSabatini 11/19/2020 19:22:48'!
test08CartShouldHaveListWithManyBooksWhenAddingMany

	| aCart |

	catalog at: isbn1 put: 100.
	catalog at: isbn2 put: 100.

	aCart := Cart with: catalog.
	aCart add: 2 of: isbn1.
	aCart add: 1 of: isbn2.

	self assert: (Dictionary newFromPairs: {isbn1. 2. isbn2. 1}) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'FedericoSabatini 11/19/2020 19:23:00'!
test09ModifyCartListShouldNotModifyTheCart

	| aCart list |

	catalog at: isbn1 put: 100.
	catalog at: isbn2 put: 100.

	aCart := Cart with: catalog.
	aCart add: 1 of: isbn1.
	aCart add: 1 of: isbn2.
	
	list := aCart list.
	list removeKey: isbn1.

	self assert: (Dictionary newFromPairs: {isbn1. 1. isbn2. 1}) equals: aCart list.! !


!classDefinition: #CashierTest category: 'TusLibros-Solucion'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CashierTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:06:01'!
test01CannotInitializeCashierWithEmptyCart

	| aCart aCatalog |

	aCatalog := Dictionary new.
	aCart := Cart with: aCatalog.

	self should: [Cashier for: aCart ]
		raise: Error
		withMessageText: Cashier creatingCashierWithEmptyCartErrorDescription.
		! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:07:30'!
test02CashierPriceShouldBeEqualToACartWithOneElement

	| aCashier aCart aCatalog book |

	book := 100001.

	aCatalog := Dictionary new.
	aCatalog at: book put: 200.
	
	aCart := Cart with: aCatalog.
	aCart add: 1 of: book.
	
	aCashier := Cashier for: aCart.
	
	self assert: 200 equals: aCashier purchaseCost.
	
	
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:06:17'!
test03CashierPriceShouldBeEqualToACartWithManyElements

	| aCashier aCart aCatalog book book2 |
	
	book := 100001.
	book2 := 100002.
	
	aCatalog := Dictionary new.
	aCatalog at: book put: 200.
	aCatalog at: book2 put: 300.
	
	aCart := Cart with: aCatalog.
	aCart add: 1 of: book.
	aCart add: 1 of: book2.
	
	aCashier := Cashier for: aCart.

	self assert: 500 equals: aCashier purchaseCost.
	
	
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:10:34'!
test04CashierPriceShouldBeEqualToACartWithManyOfSameElements

	| aCashier aCart aCatalog book |
	
	book := 100001.
	
	aCatalog := Dictionary new.
	aCatalog at: book put: 200.

	aCart := Cart with: aCatalog.
	aCart add: 4 of: book.
	
	aCashier := Cashier for: aCart.
	
	self assert: 800 equals: aCashier purchaseCost.
	
	
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:06:27'!
test05

	| aCreditCard aCashier aCart aCatalog book |
	
	aCreditCard := 90012225123.
	book := 100001.
	
	aCatalog := Dictionary new.
	aCatalog at: book put: 200.

	aCart := Cart with: aCatalog.
	aCart add: 4 of: book.
	
	aCashier := Cashier for: aCart.
	
	self should: [aCashier checkoutWith: aCreditCard]
		raise: Error
		withMessageText: Cashier invalidCreditCardErrorDescription.
	
	
	
		! !


!classDefinition: #CreditCardTest category: 'TusLibros-Solucion'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:48:08'!
test01

	| number expirationDate owner |
	
	number := '123412341234123'.
	expirationDate  := February, 2021.
	owner := 'FedeSaba S.A.'.

	self should: [ CreditCard withNumber: number withExpirationDate: expirationDate andOwner: owner. ]
		raise: Error
		withMessageText: CreditCard invalidNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:53:01'!
test02

	| number expirationDate owner |
	
	number := '123412341234123a'.
	expirationDate  := February, 2021.
	owner := 'FedeSaba S.A.'.

	self should: [ CreditCard withNumber: number withExpirationDate: expirationDate andOwner: owner. ]
		raise: Error
		withMessageText: CreditCard invalidNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/19/2020 21:52:24'!
test03

	| number expirationDate owner |
	
	number := '1234123412341234'.
	expirationDate  := February, 2021.
	owner := ''.

	self should: [ CreditCard withNumber: number withExpirationDate: expirationDate andOwner: owner. ]
		raise: Error
		withMessageText: CreditCard invalidOwnerErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/19/2020 22:08:17'!
test04

	| number expirationDate owner |
	
	number := '1234123412341234'.
	expirationDate  := 'Verano del 92'.
	owner := 'Fede Saba S.A.'.

	self should: [ CreditCard withNumber: number withExpirationDate: expirationDate andOwner: owner. ]
		raise: Error
		withMessageText: CreditCard invalidExpirationDateErrorDescription.! !


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


!Cart methodsFor: 'adding' stamp: 'FedericoSabatini 11/19/2020 19:19:22'!
add: aQuantity of: aBook

	(aQuantity > 0) ifFalse: [ self signalCanNotAddLessThanOneBook ].
	(catalog includesKey: aBook) ifFalse: [ self signalBookIsOutOfCatalog ].
	
	books add: aBook withOccurrences: aQuantity.! !


!Cart methodsFor: 'private accesing' stamp: 'DS 11/19/2020 21:03:02'!
catalog

	^catalog.! !


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


!classDefinition: #Cashier category: 'TusLibros-Solucion'!
Object subclass: #Cashier
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cashier methodsFor: 'initialization' stamp: 'DS 11/19/2020 21:05:44'!
initializeFor: aCart

	cart := aCart.! !


!Cashier methodsFor: 'checkout' stamp: 'FedericoSabatini 11/19/2020 20:02:46'!
checkoutWith: aCreditCard
	self error: self class invalidCreditCardErrorDescription.! !

!Cashier methodsFor: 'checkout' stamp: 'DS 11/19/2020 21:03:50'!
purchaseCost

	| purchaseSum |

	purchaseSum := 0.
	cart list keysAndValuesDo: [ :aKey :aValue | purchaseSum := purchaseSum + (cart catalog at: aKey) * aValue].
	^purchaseSum.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Solucion'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'FedericoSabatini 11/19/2020 19:04:16'!
creatingCashierWithEmptyCartErrorDescription
	^'Cannot create a cashier from an empty Cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'FedericoSabatini 11/19/2020 19:58:33'!
invalidCreditCardErrorDescription
	^'Invalid Credit Card error description'! !


!Cashier class methodsFor: 'assertions' stamp: 'DS 11/19/2020 21:05:24'!
assertEmptyCart: aCart

	^ aCart isEmpty ifTrue: [self error: self creatingCashierWithEmptyCartErrorDescription ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'DS 11/19/2020 21:05:24'!
for: aCart

	self assertEmptyCart: aCart.

	^self new initializeFor: aCart.! !


!classDefinition: #CreditCard category: 'TusLibros-Solucion'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CreditCard methodsFor: 'initialization' stamp: 'DS 11/19/2020 21:48:01'!
initializeWithNumber: aCreditCardNumber withExpirationDate: anExpirationDate andOwner: anOwner

	creditCardNumber := aCreditCardNumber.
	expirationDate := anExpirationDate.
	owner := anOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Solucion'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/19/2020 22:12:26'!
assertValidCreditCardNumber: aCreditCardNumber

	^(aCreditCardNumber size < 16
		or: [ aCreditCardNumber asArray anySatisfy: [:aNumber | aNumber isDigit not] ]
	) ifTrue: [	self error: self invalidNumberErrorDescription].! !

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/19/2020 22:12:34'!
assertValidFormatExpirationDate: anExpirationDate

	^ (anExpirationDate isKindOf: GregorianMonthOfYear) ifFalse: [self error: self invalidExpirationDateErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/19/2020 22:12:37'!
assertValidOwner: anOwner

	^ anOwner ifEmpty: [self error: self invalidOwnerErrorDescription].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'DS 11/19/2020 22:10:46'!
withNumber: aCreditCardNumber withExpirationDate: anExpirationDate andOwner: anOwner

	self assertValidCreditCardNumber: aCreditCardNumber.
	self assertValidOwner: anOwner.
	self assertValidFormatExpirationDate: anExpirationDate.

	^self new initializeWithNumber: aCreditCardNumber withExpirationDate: anExpirationDate andOwner: anOwner.! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/19/2020 22:08:48'!
invalidExpirationDateErrorDescription

	^'Invalid format of Expiration Date'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/19/2020 21:45:36'!
invalidNumberErrorDescription

	^'Invalid number of credit card'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/19/2020 21:50:24'!
invalidOwnerErrorDescription

	^'Owner can not be empty'.! !
