!classDefinition: #CartTest category: 'TusLibros-Solucion'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros-Solucion'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #CreditCardTest category: 'TusLibros-Solucion'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/29/2020 17:54:55'!
assertCreateCreditCardWithNumber: anNumber withOwner: anOwner expiringOn: aMonth shouldRaiseErrorDescription: anErrorDescription 

	self should: [ CreditCard withNumber: anNumber withOwner: anOwner expiringOn: aMonth. ]
		raise: Error
		withMessageText: anErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/29/2020 17:55:13'!
test01CreditCardNumberShouldHave16Characters

	self
		assertCreateCreditCardWithNumber: '123412341234123'
		withOwner: 'FedeSaba S.A.'
		expiringOn: February, 2021
		shouldRaiseErrorDescription: CreditCard invalidNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/29/2020 17:55:28'!
test02CreditCardOwnerCanNotBeEmpty

	self 
		assertCreateCreditCardWithNumber: '1234123412341234'
		withOwner:  ''
		expiringOn:  February, 2021
		shouldRaiseErrorDescription: CreditCard invalidOwnerErrorDescription.! !


!classDefinition: #FacadeTusLibrosTest category: 'TusLibros-Solucion'!
TestCase subclass: #FacadeTusLibrosTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!FacadeTusLibrosTest methodsFor: 'setup' stamp: 'DS 11/29/2020 17:35:28'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!FacadeTusLibrosTest methodsFor: 'merchant processor protocol' stamp: 'DS 11/29/2020 17:35:13'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!FacadeTusLibrosTest methodsFor: 'create' stamp: 'DS 11/29/2020 18:30:39'!
test01CreateCartHaveEmptyList

	| tusLibros cartID |

	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	self assert: (Dictionary new) equals: (tusLibros listCartFor: cartID).! !

!FacadeTusLibrosTest methodsFor: 'create' stamp: 'DS 11/29/2020 18:30:39'!
test02CannotCreateCartWithInvalidPassword

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ tusLibros createCartForUser: 1 withPassword: 'bad password'.]
		raise: Error
 		withMessageText: FacadeTusLibros badAuthenticationErrorDescription.! !

!FacadeTusLibrosTest methodsFor: 'create' stamp: 'DS 11/29/2020 18:32:41'!
test03CannotCreateCartWithUnknownUser

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ tusLibros createCartForUser: 3 withPassword: 'pass'. ]
		raise: Error
		withMessageText: FacadeTusLibros badAuthenticationErrorDescription.! !

!FacadeTusLibrosTest methodsFor: 'create' stamp: 'DS 11/29/2020 18:31:15'!
test04CannotAssignSameIDForDifferentCarts

	| tusLibros cartID cartID2 |

	tusLibros := testObjectsFactory tusLibros.
	
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	cartID2 := tusLibros createCartForUser: 2 withPassword: 'pass'.

	self assert: (cartID ~= cartID2).! !


!FacadeTusLibrosTest methodsFor: 'adding' stamp: 'DS 11/29/2020 18:32:15'!
test05AddedItemIsIncludedInCartList

	| tusLibros cartID expectedCartList |

	expectedCartList := Dictionary with: testObjectsFactory itemSellByTheStore -> 1.

	tusLibros := testObjectsFactory tusLibros.	
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	tusLibros addToCart: cartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.
	self assert: expectedCartList equals: (tusLibros listCartFor: cartID).! !

!FacadeTusLibrosTest methodsFor: 'adding' stamp: 'DS 11/29/2020 18:33:29'!
test06AddedItemsInDifferentsCartsAreInRespectiveLists

	| tusLibros firstCartID secondCartID expectedFirstCart expectedSecondCart |

	expectedFirstCart := Dictionary with: testObjectsFactory itemSellByTheStore -> 5.
	expectedSecondCart := Dictionary with: testObjectsFactory itemSellByTheStore -> 10.

	tusLibros := testObjectsFactory tusLibros.	
	firstCartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	secondCartID := tusLibros createCartForUser: 2 withPassword: 'pass'.

	tusLibros addToCart: firstCartID aQuantity: 5 of: testObjectsFactory itemSellByTheStore.
	tusLibros addToCart: secondCartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	
	self assert: expectedFirstCart equals: (tusLibros listCartFor: firstCartID).
	self assert: expectedSecondCart equals: (tusLibros listCartFor: secondCartID).! !

!FacadeTusLibrosTest methodsFor: 'adding' stamp: 'DS 11/29/2020 18:33:44'!
test07CannotAddToUnknownCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [tusLibros addToCart: 1 aQuantity: 5 of: testObjectsFactory itemSellByTheStore]
		raise: Error
		withMessageText: FacadeTusLibros unknownCartIDErrorDescription.! !


!FacadeTusLibrosTest methodsFor: 'checkout' stamp: 'DS 11/29/2020 19:31:24'!
test08CheckoutShouldBeRegisterInSalesBook

	| tusLibros cartID |

	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	
	tusLibros addToCart: cartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	
	self assert: 100 equals: (self tusLibros: tusLibros checkoutCartID: cartID).
	self assert: 100 equals: (tusLibros salesBook first total).
	self assert: 1 equals: (tusLibros salesBook size).! !

!FacadeTusLibrosTest methodsFor: 'checkout' stamp: 'DS 11/29/2020 19:31:54'!
test09CannotCheckoutWhnCreditCardHasNotCredit

	| tusLibros cartID |

	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	tusLibros addToCart: cartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.

	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	self should: [ self tusLibros: tusLibros checkoutCartID: cartID ]
		raise: Error
		withMessageText: Cashier creditCardHasNoCreditErrorMessage.
		
	self assert: tusLibros salesBook isEmpty.! !

!FacadeTusLibrosTest methodsFor: 'checkout' stamp: 'DS 11/29/2020 19:08:04'!
test10CannotCheckoutToUnknownCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ self tusLibros: tusLibros checkoutCartID: 1 ]
		raise: Error
		withMessageText: FacadeTusLibros unknownCartIDErrorDescription.
		
	self assert: tusLibros salesBook isEmpty.! !

!FacadeTusLibrosTest methodsFor: 'checkout' stamp: 'DS 11/29/2020 18:44:41'!
tusLibros: aFacadeTusLibros checkoutCartID: aCartID

	^aFacadeTusLibros
		checkOutCart: aCartID
		withCCN: testObjectsFactory creditCardNumber 
		withCCED: testObjectsFactory notExpiredCreditCardDate 
		andCCO: testObjectsFactory creditCardOwner
		throught: self
		on: testObjectsFactory today.! !


!FacadeTusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DS 11/30/2020 18:57:55'!
test11CannotListAnUnknownCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.
	self should: [ tusLibros listCartFor: 1 ]
		raise: Error
		withMessageText: FacadeTusLibros unknownCartIDErrorDescription .! !

!FacadeTusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DS 11/30/2020 19:09:04'!
test12

	| authenticator tusLibros cartID |

	authenticator := Dictionary with: 1 -> 'pass' with: 2 -> 'pass'.
	tusLibros := FacadeTusLibros withAuthenticator: authenticator withCatalog: testObjectsFactory defaultCatalog andExpiringTime: -1*minute.

	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	self should: [ tusLibros addToCart: cartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore ]
		raise: Error
		withMessageText: FacadeTusLibros cartTimeExpiredErrorDescription.! !

!FacadeTusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DS 11/30/2020 19:09:10'!
test13

	| authenticator tusLibros cartID |

	authenticator := Dictionary with: 1 -> 'pass' with: 2 -> 'pass'.
	tusLibros := FacadeTusLibros withAuthenticator: authenticator withCatalog: testObjectsFactory defaultCatalog andExpiringTime: -1*minute.

	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	self should: [ tusLibros listCartFor: cartID ]
		raise: Error
		withMessageText: FacadeTusLibros cartTimeExpiredErrorDescription.! !

!FacadeTusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DS 11/30/2020 19:11:06'!
test14

	| authenticator tusLibros cartID |

	authenticator := Dictionary with: 1 -> 'pass' with: 2 -> 'pass'.
	tusLibros := FacadeTusLibros withAuthenticator: authenticator withCatalog: testObjectsFactory defaultCatalog andExpiringTime: -1*minute.

	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	self should: [ self tusLibros: tusLibros checkoutCartID: cartID ]
		raise: Error
		withMessageText: FacadeTusLibros cartTimeExpiredErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros-Solucion'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accesing' stamp: 'FedericoSabatini 11/29/2020 16:36:53'!
items
	
	| ocurrences |
	
	ocurrences := Dictionary new.
	
	items do: [ :item | (ocurrences includesKey: item) 
		ifTrue: [ocurrences at: item put: (ocurrences at: item) + 1] 
		ifFalse: [ocurrences at: item put: 1]].
	
	^ocurrences.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Solucion'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros-Solucion'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Solucion'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros-Solucion'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'DS 11/29/2020 17:53:42'!
initializeWithNumber: aCreditCardNumber withOwner: anOwner expiringOn: aMonth

	number := aCreditCardNumber.
	expiration := aMonth.
	owner := anOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Solucion'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 17:51:53'!
invalidExpirationDateErrorDescription

    ^'Invalid format of Expiration Date'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 17:51:58'!
invalidNumberErrorDescription

    ^'Invalid number of credit card'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 17:52:04'!
invalidOwnerErrorDescription

    ^'Owner can not be empty'.! !


!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/29/2020 17:51:05'!
assertValidCreditCardNumber: aCreditCardNumber

	^(aCreditCardNumber size = 16) ifFalse: [ self error: self invalidNumberErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/29/2020 17:51:28'!
assertValidOwner: anOwner

	^anOwner ifEmpty: [ self error: self invalidOwnerErrorDescription ].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'DS 11/29/2020 17:53:28'!
withNumber: aNumber withOwner: anOwner expiringOn: aMonth

    self assertValidCreditCardNumber: aNumber.
    self assertValidOwner: anOwner.

    ^self new initializeWithNumber: aNumber withOwner: anOwner expiringOn: aMonth.! !


!classDefinition: #FacadeTusLibros category: 'TusLibros-Solucion'!
Object subclass: #FacadeTusLibros
	instanceVariableNames: 'authenticator carts currentID catalog salesBook expiringTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!FacadeTusLibros methodsFor: 'initialization' stamp: 'DS 11/29/2020 19:08:45'!
initializeWith: anAuthenticator and: aCatalog 

	authenticator := anAuthenticator.
	carts := Dictionary new. 
	catalog := aCatalog.
	currentID := 0.
	salesBook := OrderedCollection new.! !

!FacadeTusLibros methodsFor: 'initialization' stamp: 'DS 11/30/2020 18:50:38'!
initializeWithAuthenticator: anAuthenticator withCatalog: aCatalog andExpiringTime: anExpiringTime 

	authenticator := anAuthenticator.
	catalog := aCatalog.
	expiringTime := anExpiringTime.
	carts := Dictionary new.
	currentID := 0.
	salesBook := OrderedCollection new.! !


!FacadeTusLibros methodsFor: 'api rest' stamp: 'DS 11/30/2020 19:26:25'!
addToCart: aCartID aQuantity: aQuantity of: anItem
	
	| aSessionCart |

	"self assertUnkownCartID: aCartID.	"

	aSessionCart := self cartWith: aCartID.
	
	(aSessionCart expiringTimestamp < GregorianDateTime now) ifTrue: [ self error: self class cartTimeExpiredErrorDescription ].
	
	aSessionCart cart add: aQuantity of: anItem.
	
	! !

!FacadeTusLibros methodsFor: 'api rest' stamp: 'DS 11/30/2020 19:26:51'!
checkOutCart: aCartID withCCN: anCCN withCCED: anCCED andCCO: anCCO throught: aMerchantProccesor on: aDate

	| creditCard aSessionCart cashier |
	
	"self assertUnkownCartID: aCartID."
	aSessionCart := self cartWith: aCartID.
	
	(aSessionCart expiringTimestamp < GregorianDateTime now) ifTrue: [ self error: self class cartTimeExpiredErrorDescription ].

	creditCard := CreditCard withNumber: anCCN withOwner: anCCO expiringOn: anCCED.
	cashier := Cashier toCheckout: aSessionCart cart charging: creditCard throught: aMerchantProccesor on: aDate registeringOn: salesBook.

	^cashier checkOut.! !

!FacadeTusLibros methodsFor: 'api rest' stamp: 'DS 11/30/2020 19:25:05'!
createCartForUser: anID withPassword: aPassword 

	| cart expirationTime |

	self assertAuthenticate: anID withPassword: aPassword.
	
	currentID := currentID + 1.
	cart := Cart acceptingItemsOf: catalog.
	expirationTime := GregorianDateTime now next: expiringTime.
	carts at: currentID put: (SessionCart for: cart expiringAt: expirationTime).

	^currentID.! !

!FacadeTusLibros methodsFor: 'api rest' stamp: 'DS 11/30/2020 19:27:23'!
listCartFor: aCartID

	| aSessionCart |
	aSessionCart := self cartWith: aCartID.
	
	(aSessionCart expiringTimestamp < GregorianDateTime now) ifTrue: [ self error: self class cartTimeExpiredErrorDescription ].

	^aSessionCart cart items.! !


!FacadeTusLibros methodsFor: 'errors' stamp: 'DS 11/29/2020 18:52:50'!
signalBadAuthentication

	^ self error: self class badAuthenticationErrorDescription! !

!FacadeTusLibros methodsFor: 'errors' stamp: 'DS 11/29/2020 18:21:02'!
signalUnknownCartID

	^ self error: self class unknownCartIDErrorDescription! !


!FacadeTusLibros methodsFor: 'assertions' stamp: 'DS 11/29/2020 19:00:47'!
assertAuthenticate: anID withPassword: aPassword

	( (authenticator includesKey: anID) not or: [(authenticator at: anID) ~= aPassword] 	)
		ifTrue: [self error: self class badAuthenticationErrorDescription].
! !

!FacadeTusLibros methodsFor: 'assertions' stamp: 'DS 11/30/2020 18:48:11'!
assertUnkownCartID: aCartID

	^(carts at: aCartID ifAbsent: [ self signalUnknownCartID ]) first.! !

!FacadeTusLibros methodsFor: 'assertions' stamp: 'DS 11/30/2020 18:51:35'!
cartWith: aCartID

	^(carts at: aCartID ifAbsent: [ self signalUnknownCartID ]).! !


!FacadeTusLibros methodsFor: 'accessing' stamp: 'DS 11/29/2020 19:08:20'!
salesBook

	^salesBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacadeTusLibros class' category: 'TusLibros-Solucion'!
FacadeTusLibros class
	instanceVariableNames: ''!

!FacadeTusLibros class methodsFor: 'instance creation' stamp: 'FedericoSabatini 11/29/2020 16:03:10'!
with: anAuthenticator and: aCatalog 
	^self new initializeWith: anAuthenticator and: aCatalog.! !

!FacadeTusLibros class methodsFor: 'instance creation' stamp: 'DS 11/30/2020 18:22:57'!
withAuthenticator: anAuthenticator withCatalog: aCatalog andExpiringTime: anExpiringTime

	^self new initializeWithAuthenticator: anAuthenticator withCatalog: aCatalog andExpiringTime: anExpiringTime.! !


!FacadeTusLibros class methodsFor: 'error descriptions' stamp: 'FedericoSabatini 11/29/2020 15:39:11'!
badAuthenticationErrorDescription

    ^'Dont exist an user with this password'.! !

!FacadeTusLibros class methodsFor: 'error descriptions' stamp: 'DS 11/30/2020 18:24:49'!
cartTimeExpiredErrorDescription

	^'Your cart has expired'.! !


!FacadeTusLibros class methodsFor: 'as yet unclassified' stamp: 'DS 11/29/2020 18:18:17'!
unknownCartIDErrorDescription
	^ 'Unknowed cart ID'.! !


!classDefinition: #Sale category: 'TusLibros-Solucion'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Solucion'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #SessionCart category: 'TusLibros-Solucion'!
Object subclass: #SessionCart
	instanceVariableNames: 'cart expiringTimestamp'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!SessionCart methodsFor: 'accesing' stamp: 'DS 11/30/2020 19:24:06'!
cart

	^cart.! !

!SessionCart methodsFor: 'accesing' stamp: 'DS 11/30/2020 19:24:16'!
expiringTimestamp

	^expiringTimestamp.! !


!SessionCart methodsFor: 'initialization' stamp: 'DS 11/30/2020 19:23:44'!
initializeFor: aCart expiringAt: aGregorianDateTime

	cart := aCart.
	expiringTimestamp := aGregorianDateTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SessionCart class' category: 'TusLibros-Solucion'!
SessionCart class
	instanceVariableNames: ''!

!SessionCart class methodsFor: 'as yet unclassified' stamp: 'DS 11/30/2020 19:28:27'!
for: aCart expiringAt: aGregorianDateTime

	^self new initializeFor: aCart expiringAt: aGregorianDateTime.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Solucion'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:11:52'!
creditCardNumber

	^'1234123412341234'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:11:45'!
creditCardOwner

	^'an buisines S.A.'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:12:09'!
expiredCreditCard
	
	^CreditCard 
		withNumber: self creditCardNumber 
		withOwner: self creditCardOwner 
		expiringOn: self expiredCreditCardDate! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:05:26'!
expiredCreditCardDate
	
	^Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:12:21'!
notExpiredCreditCard
	
	^CreditCard 
		withNumber: self creditCardNumber 
		withOwner: self creditCardOwner 
		expiringOn: self notExpiredCreditCardDate.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:07:07'!
notExpiredCreditCardDate
	
	^Month month: today monthIndex year: today yearNumber + 1.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'tusLibros' stamp: 'DS 11/30/2020 18:52:58'!
tusLibros

	| authenticator |

	authenticator := Dictionary with: 1 -> 'pass' with: 2 -> 'pass'.

	^FacadeTusLibros withAuthenticator: authenticator withCatalog: self defaultCatalog andExpiringTime: 30*minute.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
