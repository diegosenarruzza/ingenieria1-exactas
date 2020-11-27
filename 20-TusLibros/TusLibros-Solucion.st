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
	instanceVariableNames: 'commonCart creditCard expiratedCreditCard successCashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CashierTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:23:11'!
test01CannotCheckoutForAnEmptyCart

	| aCart |

	aCart := Cart with: (Dictionary new).

	self should: [successCashier checkoutWith: creditCard for: aCart ]
		raise: Error
		withMessageText: Cashier emptyCartErrorDescription.

	self assert: (OrderedCollection new) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:37:35'!
test02ShouldRegisterAnSaleForACartWithOneItem

	| receipt |

	receipt := 200.

	self assert: receipt equals: (successCashier checkoutWith: creditCard for: commonCart).
	self assert: (OrderedCollection with: 200) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:37:41'!
test03ShouldRegisterAnSaleForACartWithManyItems

	| book receipt |
	
	book := 200002.
	commonCart add: 1 of: book.

	receipt := 500.

	self assert: receipt equals: (successCashier checkoutWith: creditCard for: commonCart ).
	self assert: (OrderedCollection with: 500) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:37:48'!
test04ShouldRegisterAnSaleForACartWithManyOfSameItems

	| book receipt |
	
	book := 100001.
	commonCart add: 3 of: book.

	receipt := 800.

	self assert: receipt equals: (successCashier checkoutWith: creditCard for: commonCart).
	self assert: (OrderedCollection with: 800) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:35:53'!
test05ShouldNotRegisterAnSaleIfCreditCardHasExpired

	|  aCashier |

	aCashier := Cashier with: (SuccessMerchantProcesor new).

	self should: [aCashier checkoutWith: expiratedCreditCard for: commonCart]
		raise: Error
		withMessageText: Cashier expiratedCreditCardErrorDescription.

	self assert: (OrderedCollection new) equals: aCashier sales.
	! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:36:15'!
test06ShouldNotRegisterAnSaleIfMPRaiseAnEexception

	| aCashier mp |

	mp := ErrorMerchantProcesor new.
	aCashier := Cashier with: mp.
	
	self should: [aCashier checkoutWith: creditCard for: commonCart ]
		raise: Error
		withMessageText: ErrorMerchantProcesor errorDescription.
	
	self assert: (OrderedCollection new) equals: aCashier sales.! !


!CashierTest methodsFor: 'setUp' stamp: 'DS 11/22/2020 19:58:42'!
setUp

	| book1 book2 |
	book1 := 100001.
	book2 := 200002.

	commonCart := Cart with: (Dictionary newFromPairs: {book1.200. book2.300 }).
	commonCart add: 1 of: book1.

	expiratedCreditCard := CreditCard withNumber: '1234123412341234' withExpirationDate: (February, 2020) andOwner: 'Fede'.
	creditCard := CreditCard withNumber: '1234123412341234' withExpirationDate: (February, 2022) andOwner: 'Fede'.

	successCashier := Cashier with: (SuccessMerchantProcesor new).! !


!classDefinition: #CreditCardTest category: 'TusLibros-Solucion'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:49:35'!
assertCreateCreditCardWithNumber: anNumber withExpirationDate: anExpirationDate andOwner: anOwner shouldRaiseErrorDescription: anErrorDescription 

	self should: [ CreditCard withNumber: anNumber withExpirationDate: anExpirationDate andOwner: anOwner . ]
		raise: Error
		withMessageText: anErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:56:40'!
test01CreditCardNumberShouldHave16Characters

	self
		assertCreateCreditCardWithNumber: '123412341234123'
		withExpirationDate: February, 2021
		andOwner: 'FedeSaba S.A.'
		shouldRaiseErrorDescription: CreditCard invalidNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:56:55'!
test02CreditCardNumberShouldBeAnStringOfDigits

	self 
		assertCreateCreditCardWithNumber: '123412341234123a'
		withExpirationDate:  February, 2021
		andOwner:  'FedeSaba S.A.'
		shouldRaiseErrorDescription: CreditCard invalidNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:57:06'!
test03CreditCardOwnerCanNotBeEmpty

	self 
		assertCreateCreditCardWithNumber: '1234123412341234'
		withExpirationDate:  February, 2021
		andOwner:  ''
		shouldRaiseErrorDescription: CreditCard invalidOwnerErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/22/2020 19:57:28'!
test04CreditCardExpirationDateShouldBeAnGregorianMonthOfYear

	self 
		assertCreateCreditCardWithNumber: '1234123412341234'
		withExpirationDate:  'Verano del 92'
		andOwner:  'FedeSaba S.A.'
		shouldRaiseErrorDescription: CreditCard invalidExpirationDateErrorDescription.! !


!classDefinition: #FacadeTusLibrosTest category: 'TusLibros-Solucion'!
TestCase subclass: #FacadeTusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!FacadeTusLibrosTest methodsFor: 'tests' stamp: 'DS 11/26/2020 21:39:04'!
test01CreateCartHaveEmptyList

	| tusLibros cartID authenticator |

	authenticator := Dictionary with: 1 -> 'password'.
	tusLibros := FacadeTusLibros with: authenticator.
	cartID := tusLibros createCartForUser: 1 withPassword: 'password'.

	self assert: (Dictionary new) equals: (tusLibros listCartFor: cartID).! !

!FacadeTusLibrosTest methodsFor: 'tests' stamp: 'DS 11/26/2020 21:39:29'!
test02CannotCreateCartWithInvalidPassword

	| tusLibros authenticator |

	authenticator := Dictionary with: 1 -> 'password'.
	tusLibros := FacadeTusLibros with: authenticator.

	self should: [		tusLibros createCartForUser: 1 withPassword: 'bad password'.		]
		raise: Error
		withMessageText: FacadeTusLibros badAuthenticationErrorDescription.! !

!FacadeTusLibrosTest methodsFor: 'tests' stamp: 'DS 11/26/2020 21:40:29'!
test03CannotCreateCartWithUnknownUser

	| tusLibros authenticator |

	authenticator := Dictionary with: 1 -> 'password'.
	tusLibros := FacadeTusLibros with: authenticator.

	self should: [		tusLibros createCartForUser: 2 withPassword: 'password'.		]
		raise: Error
		withMessageText: FacadeTusLibros badAuthenticationErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros-Solucion'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cart methodsFor: 'initialization' stamp: 'DS 11/22/2020 19:44:51'!
initializeWith: aCatalog 

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'assertions' stamp: 'DS 11/22/2020 19:45:26'!
assertAddMoreThanZeroItems: aQuantity

	^ (aQuantity > 0) ifFalse: [ self signalCanNotAddLessThanOneItem ]! !

!Cart methodsFor: 'assertions' stamp: 'DS 11/22/2020 19:44:23'!
assertItemIsInCatalog: anItem

	^ (catalog includesKey: anItem) ifFalse: [ self signalBookIsOutOfCatalog ]! !


!Cart methodsFor: 'adding' stamp: 'DS 11/22/2020 19:44:51'!
add: aQuantity of: anItem

	self assertAddMoreThanZeroItems: aQuantity.
	self assertItemIsInCatalog: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'private accesing' stamp: 'DS 11/19/2020 21:03:02'!
catalog

	^catalog.! !


!Cart methodsFor: 'accessing' stamp: 'DS 11/22/2020 19:45:03'!
howManyOf: anItem

	^items occurrencesOf: anItem.! !

!Cart methodsFor: 'accessing' stamp: 'DS 11/22/2020 19:44:51'!
list

	^items contents copy.! !

!Cart methodsFor: 'accessing' stamp: 'DS 11/22/2020 18:28:40'!
purchaseCost

	| purchaseSum |

	purchaseSum := 0.
	self list keysAndValuesDo: [ :aKey :aValue | purchaseSum := purchaseSum + (catalog at: aKey) * aValue].
	^purchaseSum.! !


!Cart methodsFor: 'testing' stamp: 'DS 11/22/2020 19:44:51'!
isEmpty

	^items isEmpty.! !


!Cart methodsFor: 'errors' stamp: 'DS 11/18/2020 00:38:43'!
signalBookIsOutOfCatalog

	^ self error: self class bookIsOutOfCatalogErrorDescription! !

!Cart methodsFor: 'errors' stamp: 'DS 11/22/2020 19:45:26'!
signalCanNotAddLessThanOneItem

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
	instanceVariableNames: 'mp sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cashier methodsFor: 'initialization' stamp: 'DS 11/22/2020 18:30:54'!
initializeWith: anMP

	mp := anMP.
	sales := OrderedCollection new.! !


!Cashier methodsFor: 'exceptions' stamp: 'DS 11/22/2020 19:38:37'!
signalEmptyCart

	^ self error: self class emptyCartErrorDescription! !

!Cashier methodsFor: 'exceptions' stamp: 'DS 11/22/2020 19:39:22'!
signalExpiredCreditCard

	^ self error: self class expiratedCreditCardErrorDescription! !


!Cashier methodsFor: 'assertions' stamp: 'DS 11/22/2020 19:38:43'!
assertNotEmptyCart: aCart

	aCart isEmpty ifTrue: [self signalEmptyCart ].! !

!Cashier methodsFor: 'assertions' stamp: 'DS 11/22/2020 19:39:31'!
assertNotExpiredCreditCard: aCreditCard

	(aCreditCard expirationDate < GregorianMonthOfYear current) ifTrue: [ self signalExpiredCreditCard ].! !


!Cashier methodsFor: 'checkout' stamp: 'DS 11/22/2020 19:39:59'!
checkoutWith: aCreditCard for: aCart

	| ammount |

	self assertNotEmptyCart: aCart.
	self assertNotExpiredCreditCard: aCreditCard.

	ammount := aCart purchaseCost.

	mp debit: ammount from: aCreditCard.
	sales add: ammount.

	^ammount.! !


!Cashier methodsFor: 'accesing' stamp: 'DS 11/22/2020 18:04:17'!
sales

	^sales.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Solucion'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'DS 11/22/2020 18:37:20'!
emptyCartErrorDescription
	^'Cannot create a cashier from an empty Cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'DS 11/22/2020 16:43:05'!
expiratedCreditCardErrorDescription

	^'The Credit Card has expired'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'DS 11/22/2020 18:30:43'!
with: anMP

	^self new initializeWith: anMP.! !


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


!CreditCard methodsFor: 'accessing' stamp: 'DS 11/22/2020 17:01:54'!
expirationDate

	^expirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Solucion'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/22/2020 19:59:18'!
assertValidCreditCardNumber: aCreditCardNumber

	^(aCreditCardNumber size ~= 16
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


!classDefinition: #FacadeTusLibros category: 'TusLibros-Solucion'!
Object subclass: #FacadeTusLibros
	instanceVariableNames: 'authenticator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!FacadeTusLibros methodsFor: 'as yet unclassified' stamp: 'DS 11/26/2020 21:34:26'!
createCartForUser: anID withPassword: aPassword

	authenticator at: anID ifAbsent: [self error: self class badAuthenticationErrorDescription ].
	((authenticator at: anID) = aPassword) ifFalse: [self error: self class badAuthenticationErrorDescription].

! !


!FacadeTusLibros methodsFor: 'list' stamp: 'DS 11/26/2020 20:50:18'!
listCartFor: aCartID

	^Dictionary new.! !


!FacadeTusLibros methodsFor: 'initialization' stamp: 'DS 11/26/2020 21:13:01'!
initializeWith: anAuthenticator 

	authenticator := anAuthenticator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacadeTusLibros class' category: 'TusLibros-Solucion'!
FacadeTusLibros class
	instanceVariableNames: ''!

!FacadeTusLibros class methodsFor: 'instance creation' stamp: 'DS 11/26/2020 20:58:26'!
with: anAuthenticator

	^self new initializeWith: anAuthenticator.! !


!FacadeTusLibros class methodsFor: 'error descriptions' stamp: 'DS 11/26/2020 20:59:50'!
badAuthenticationErrorDescription

	^'Dont exist an user with this password'.! !


!classDefinition: #MerchantProcesorSimulator category: 'TusLibros-Solucion'!
Object subclass: #MerchantProcesorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!MerchantProcesorSimulator methodsFor: 'debit' stamp: 'DS 11/22/2020 17:41:27'!
debit: anAmmount from: aCreditCard

	self subclassResponsibility.! !


!classDefinition: #ErrorMerchantProcesor category: 'TusLibros-Solucion'!
MerchantProcesorSimulator subclass: #ErrorMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!ErrorMerchantProcesor methodsFor: 'debit' stamp: 'DS 11/22/2020 17:31:30'!
debit: anAmmount from: aCreditCard 

	self error: self class errorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorMerchantProcesor class' category: 'TusLibros-Solucion'!
ErrorMerchantProcesor class
	instanceVariableNames: ''!

!ErrorMerchantProcesor class methodsFor: 'as yet unclassified' stamp: 'DS 11/22/2020 17:24:59'!
errorDescription

	^'Can not process the credit card'.! !


!classDefinition: #SuccessMerchantProcesor category: 'TusLibros-Solucion'!
MerchantProcesorSimulator subclass: #SuccessMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!SuccessMerchantProcesor methodsFor: 'debit' stamp: 'DS 11/22/2020 17:13:56'!
debit: anAmmount from: aCreditCard 

	^anAmmount.! !
