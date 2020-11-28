!classDefinition: #CartTest category: 'TusLibros-Solucion'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CartTest methodsFor: 'setup' stamp: 'DS 11/27/2020 20:03:59'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!CartTest methodsFor: 'adding' stamp: 'DS 11/27/2020 19:50:19'!
test01NewCartIsEmpty
	
	| aCart |

	aCart := testObjectsFactory createCart.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/27/2020 19:52:14'!
test02CartShouldHaveOneOfABookWhenAddingIt
	
	|  aCart |

	aCart := testObjectsFactory createCart.
	aCart add: 1 of: testObjectsFactory validBookForTheStore.
	
	self deny: aCart isEmpty.
	self assert: 1 equals: (aCart howManyOf: testObjectsFactory validBookForTheStore).! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/27/2020 20:00:44'!
test03CartShouldHaveManyBooksWhenAddingMany
	
	| aCart |

	aCart := testObjectsFactory createCart.
	aCart add: 5 of: testObjectsFactory validBookForTheStore.
	
	self assert: 5 equals: (aCart howManyOf: testObjectsFactory validBookForTheStore).! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/27/2020 20:03:24'!
test04CanNotAddABookOutOfCatalog
	
	| aCart |

	aCart := testObjectsFactory createCart.

	self should: [ aCart add: 1 of: testObjectsFactory invalidBookForTheStore. ]
		raise: Error
		withMessageText: Cart bookIsOutOfCatalogErrorDescription.! !

!CartTest methodsFor: 'adding' stamp: 'DS 11/27/2020 20:03:51'!
test05CanNotAddLessThanOneBook
	
	| aCart |

	aCart := testObjectsFactory createCart.

	self should: [ aCart add: -1 of: testObjectsFactory validBookForTheStore. ]
		raise: Error
		withMessageText: Cart canNotAddLessThanOneBookErrorDescription.! !


!CartTest methodsFor: 'list' stamp: 'DS 11/27/2020 20:04:39'!
test06NewCartHaveEmptyList

	self assert: testObjectsFactory createCart list isEmpty.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/27/2020 20:05:41'!
test07CartShouldHaveListWithOneOfABookWhenAddingIt

	| aCart |

	aCart := testObjectsFactory createCart.
	aCart add: 1 of: testObjectsFactory validBookForTheStore.

	self assert: (Dictionary with: testObjectsFactory validBookForTheStore -> 1) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/27/2020 20:07:29'!
test08CartShouldHaveListWithManyBooksWhenAddingMany

	| aCart |

	aCart := testObjectsFactory createCart.
	aCart add: 6 of: testObjectsFactory validBookForTheStore.

	self assert: (Dictionary with: testObjectsFactory validBookForTheStore  -> 6) equals: aCart list.! !

!CartTest methodsFor: 'list' stamp: 'DS 11/27/2020 20:09:02'!
test09ModifyCartListShouldNotModifyTheCart

	| aCart list |

	aCart := testObjectsFactory createCart.
	aCart add: 2 of: testObjectsFactory validBookForTheStore.
	
	list := aCart list.
	list removeKey: testObjectsFactory validBookForTheStore.

	self assert: (Dictionary with: testObjectsFactory validBookForTheStore -> 2) equals: aCart list.! !


!classDefinition: #CashierTest category: 'TusLibros-Solucion'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory successCashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CashierTest methodsFor: 'tests' stamp: 'DS 11/27/2020 20:36:00'!
test01CannotCheckoutForAnEmptyCart

	| aCart |

	aCart := testObjectsFactory createCart.

	self should: [successCashier checkoutWith: testObjectsFactory notExpiredCreditCard for: aCart on: testObjectsFactory today ]
		raise: Error
		withMessageText: Cashier emptyCartErrorDescription.

	self assert: (OrderedCollection new) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/27/2020 20:36:00'!
test02ShouldRegisterAnSaleForACartWithOneItem

	| cart receipt |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory validBookForTheStore.
	receipt := 200.

	self assert: receipt equals: (successCashier checkoutWith: testObjectsFactory notExpiredCreditCard for: cart on: testObjectsFactory today).
	self assert: (OrderedCollection with: 200) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/27/2020 21:02:05'!
test03ShouldRegisterAnSaleForACartWithManyItems

	| cart receipt |
	
	cart := testObjectsFactory createCart.
	cart add: 1 of: testObjectsFactory validBookForTheStore.

	receipt := 100.

	self assert: receipt equals: (successCashier checkoutWith: testObjectsFactory notExpiredCreditCard for: cart on: testObjectsFactory today).
	self assert: (OrderedCollection with: 100) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/27/2020 21:03:03'!
test04ShouldRegisterAnSaleForACartWithManyOfSameItems

	| cart receipt |
	
	cart := testObjectsFactory createCart.
	cart add: 8 of: testObjectsFactory validBookForTheStore.

	receipt := 800.

	self assert: receipt equals: (successCashier checkoutWith: testObjectsFactory notExpiredCreditCard for: cart on: testObjectsFactory today).
	self assert: (OrderedCollection with: 800) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/27/2020 21:07:08'!
test05ShouldNotRegisterAnSaleIfCreditCardHasExpired

	| cart |

	cart := testObjectsFactory createCart.
	cart add: 1 of: testObjectsFactory validBookForTheStore.

	self should: [
		successCashier
			checkoutWith: testObjectsFactory expiredCreditCard
			for: cart
			on: testObjectsFactory today
		]
		raise: Error
		withMessageText: Cashier expiratedCreditCardErrorDescription.

	self assert: (OrderedCollection new) equals: successCashier sales.! !

!CashierTest methodsFor: 'tests' stamp: 'DS 11/27/2020 21:18:32'!
test06ShouldNotRegisterAnSaleIfMPRaiseAnEexception

	| cart aCashier |

	cart := testObjectsFactory createCart.
	cart add: 1 of: testObjectsFactory validBookForTheStore.

	aCashier := Cashier with: (MerchantProcesorSimulator errorBehavior).
	
	self should: [
		aCashier 
			checkoutWith: testObjectsFactory notExpiredCreditCard
			for: cart
			on: testObjectsFactory today
		]
		raise: Error
		withMessageText: MerchantProcesorSimulator errorDescription.
	
	self assert: (OrderedCollection new) equals: aCashier sales.! !


!CashierTest methodsFor: 'setUp' stamp: 'DS 11/27/2020 21:17:37'!
setUp

	successCashier := Cashier with: (MerchantProcesorSimulator successBehavior).
	
	testObjectsFactory := StoreTestObjectsFactory new.! !


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

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/27/2020 19:34:29'!
test02CreditCardOwnerCanNotBeEmpty

	self 
		assertCreateCreditCardWithNumber: '1234123412341234'
		withExpirationDate:  February, 2021
		andOwner:  ''
		shouldRaiseErrorDescription: CreditCard invalidOwnerErrorDescription.! !


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

!Cashier methodsFor: 'assertions' stamp: 'DS 11/27/2020 20:31:47'!
assertNotExpiredCreditCard: aCreditCard

	| today |

	today := DateAndTime now.

	(aCreditCard expirationDate start < Month month: today monthIndex year: today yearNumber) ifTrue: [ self signalExpiredCreditCard ].! !

!Cashier methodsFor: 'assertions' stamp: 'DS 11/27/2020 21:10:01'!
assertNotExpiredCreditCard: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [ self signalExpiredCreditCard ].! !


!Cashier methodsFor: 'checkout' stamp: 'DS 11/27/2020 21:09:31'!
checkoutWith: aCreditCard for: aCart on: aDate 

	| ammount |

	self assertNotEmptyCart: aCart.
	self assertNotExpiredCreditCard: aCreditCard on: aDate.

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


!CreditCard methodsFor: 'testing' stamp: 'DS 11/27/2020 20:33:19'!
isExpiredOn: aDate 
	
	^expirationDate start < (Month month: aDate monthIndex year: aDate yearNumber) start.! !


!CreditCard methodsFor: 'accessing' stamp: 'DS 11/22/2020 17:01:54'!
expirationDate

	^expirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Solucion'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/27/2020 19:34:07'!
assertValidCreditCardNumber: aCreditCardNumber

	^(aCreditCardNumber size = 16 	) ifFalse: [	self error: self invalidNumberErrorDescription].! !

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/19/2020 22:12:37'!
assertValidOwner: anOwner

	^ anOwner ifEmpty: [self error: self invalidOwnerErrorDescription].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'DS 11/27/2020 20:23:18'!
withNumber: aCreditCardNumber withExpirationDate: anExpirationDate andOwner: anOwner

	self assertValidCreditCardNumber: aCreditCardNumber.
	self assertValidOwner: anOwner.

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
	instanceVariableNames: 'behavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!MerchantProcesorSimulator methodsFor: 'debit' stamp: 'DS 11/27/2020 21:16:04'!
debit: anAmmount from: aCreditCard

	^behavior value: anAmmount value: aCreditCard.! !


!MerchantProcesorSimulator methodsFor: 'initialization' stamp: 'DS 11/27/2020 21:15:41'!
initializeWithBehavior: aBlockBehavior

	behavior := aBlockBehavior.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesorSimulator class' category: 'TusLibros-Solucion'!
MerchantProcesorSimulator class
	instanceVariableNames: ''!

!MerchantProcesorSimulator class methodsFor: 'error descriptions' stamp: 'DS 11/27/2020 21:18:55'!
errorDescription

	^'Can not process the credit card'.! !


!MerchantProcesorSimulator class methodsFor: 'behaviors' stamp: 'DS 11/27/2020 21:14:37'!
errorBehavior

	^self new initializeWithBehavior: [ :anAmmount :aCreditCard | self error: self errorDescription].! !

!MerchantProcesorSimulator class methodsFor: 'behaviors' stamp: 'DS 11/27/2020 21:20:09'!
successBehavior

	^self new initializeWithBehavior: [ :anAmmount :aCreditCard | anAmmount. ].! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Solucion'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'DS 11/27/2020 19:49:57'!
createCart

	^Cart with: self defaultCatalog.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'DS 11/27/2020 19:48:49'!
defaultCatalog

	^Dictionary with: self validBookForTheStore -> self validBookForTheStorePrice.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'DS 11/27/2020 20:12:27'!
initialize

	today := DateAndTime now.! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'DS 11/27/2020 20:03:10'!
invalidBookForTheStore

	^'an invalid book'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'DS 11/27/2020 19:45:33'!
validBookForTheStore

	^'The lord of the rings'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'DS 11/27/2020 19:48:36'!
validBookForTheStorePrice

	^100.! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/27/2020 21:05:46'!
expiredCreditCard

	^CreditCard 
		withNumber: '1234123412341234'
		withExpirationDate: (Month month: today monthIndex year: today yearNumber - 1)
		andOwner: 'Fede'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/27/2020 20:21:43'!
notExpiredCreditCard

	^CreditCard 
		withNumber: '1234123412341234'
		withExpirationDate: (Month month: today monthIndex year: today yearNumber + 1)
		andOwner: 'Fede'.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'DS 11/27/2020 20:12:33'!
today
	
	^ today.! !
