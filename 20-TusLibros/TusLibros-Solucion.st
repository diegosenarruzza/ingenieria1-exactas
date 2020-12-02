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


!classDefinition: #InternalRestInterfaceTest category: 'TusLibros-Solucion'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior clockBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!InternalRestInterfaceTest methodsFor: 'adding' stamp: 'FedericoSabatini 12/1/2020 18:17:17'!
test05AddedItemIsIncludedInCartList

	| tusLibros cartID expectedCartList |

	expectedCartList := Bag new.
	expectedCartList add: testObjectsFactory itemSellByTheStore withOccurrences: 1.

	tusLibros := testObjectsFactory tusLibros.	
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	tusLibros addToCart: cartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.
	self assert: expectedCartList equals: (tusLibros listCartFor: cartID).! !

!InternalRestInterfaceTest methodsFor: 'adding' stamp: 'FedericoSabatini 12/1/2020 18:18:07'!
test06AddedItemsInDifferentsCartsAreInRespectiveLists

	| tusLibros firstCartID secondCartID expectedFirstCart expectedSecondCart |

	expectedFirstCart := Bag new.
	expectedFirstCart add: testObjectsFactory itemSellByTheStore withOccurrences: 5.
	expectedSecondCart := Bag new. 
	expectedSecondCart add: testObjectsFactory itemSellByTheStore withOccurrences: 10.

	tusLibros := testObjectsFactory tusLibros.	
	firstCartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	secondCartID := tusLibros createCartForUser: 2 withPassword: 'pass'.

	tusLibros addToCart: firstCartID aQuantity: 5 of: testObjectsFactory itemSellByTheStore.
	tusLibros addToCart: secondCartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	
	self assert: expectedFirstCart equals: (tusLibros listCartFor: firstCartID).
	self assert: expectedSecondCart equals: (tusLibros listCartFor: secondCartID).! !

!InternalRestInterfaceTest methodsFor: 'adding' stamp: 'DS 11/30/2020 22:16:51'!
test07CannotAddToUnknownCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [tusLibros addToCart: 1 aQuantity: 5 of: testObjectsFactory itemSellByTheStore]
		raise: Error
		withMessageText: InternalRestInterface unknownCartIDErrorDescription.! !


!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:16:22'!
assertUpdatedTimeToCartAfter: aTusLibrosBlock

	| tusLibros cartID checkIfExpired updatedTime |

	tusLibros := testObjectsFactory tusLibros: self.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	tusLibros addToCart: cartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.

	checkIfExpired := false.
	clockBehavior := [
		checkIfExpired
			ifFalse: [
				checkIfExpired := true.
				testObjectsFactory now next: 10*minute.
			] ifTrue: [
				updatedTime :=  testObjectsFactory now next: 5*minute.
				updatedTime.
			].		
	].
	aTusLibrosBlock value: tusLibros value: cartID.

	self assert: (testObjectsFactory now next: 5*minute) equals: updatedTime.! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:23:54'!
shouldRaiseCartTimeExpiredErrorWhen: aTusLibrosBlock

	| tusLibros cartID |
	
	tusLibros := testObjectsFactory tusLibros: self.		
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	
	clockBehavior := [ testObjectsFactory now next: 31*minute ].

	self should: [ aTusLibrosBlock value: tusLibros value: cartID ]
		raise: Error
		withMessageText: InternalRestInterface cartTimeExpiredErrorDescription.! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:23:54'!
test12CannotAddOnExpiredCart

	self shouldRaiseCartTimeExpiredErrorWhen: [ :anInternalRestInterface :aCartID | 
		anInternalRestInterface addToCart: aCartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:23:54'!
test13CannotListOnExpiredCart

	self shouldRaiseCartTimeExpiredErrorWhen: [ :anInternalRestInterface :aCartID |
		anInternalRestInterface listCartFor: aCartID
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:23:54'!
test14CannotCheckoutOnExpiredCart

	self shouldRaiseCartTimeExpiredErrorWhen: [ :anInternalRestInterface :aCartID |
		self tusLibros: anInternalRestInterface checkoutCartID: aCartID
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:22:32'!
test15AddAnItemShouldRestartExpirationTime

	self assertUpdatedTimeToCartAfter: [ :anInternalRestInterface :aCartID | 
		anInternalRestInterface addToCart: aCartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:20:12'!
test16ListCartShouldRestartExpirationTime

	self assertUpdatedTimeToCartAfter: [ :anInternalRestInterface :aCartID | anInternalRestInterface listCartFor: aCartID ].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 11/30/2020 22:21:05'!
test17CheckoutShouldRestartExpirationTime

	self assertUpdatedTimeToCartAfter: [ :anInternalRestInterface :aCartID | self tusLibros: anInternalRestInterface checkoutCartID: aCartID].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'FedericoSabatini 12/2/2020 12:21:56'!
test21CannotListPurchasesOnExpiredCart

	self shouldRaiseCartTimeExpiredErrorWhen: [ :anInternalRestInterface :aCartID | 
		anInternalRestInterface listPurchases: aCartID.
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'FedericoSabatini 12/2/2020 12:21:52'!
test22ListPurchasesOfCartShouldRestartExpirationTime

	self assertUpdatedTimeToCartAfter: [ :anInternalRestInterface :aCartID | 
		anInternalRestInterface listPurchases: aCartID.
	].! !


!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 11/29/2020 19:31:24'!
test08CheckoutShouldBeRegisterInSalesBook

	| tusLibros cartID |

	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	
	tusLibros addToCart: cartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	
	self assert: 100 equals: (self tusLibros: tusLibros checkoutCartID: cartID).
	self assert: 100 equals: (tusLibros salesBook first total).
	self assert: 1 equals: (tusLibros salesBook size).! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 11/29/2020 19:31:54'!
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

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 11/30/2020 22:16:51'!
test10CannotCheckoutToUnknownCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ self tusLibros: tusLibros checkoutCartID: 1 ]
		raise: Error
		withMessageText: InternalRestInterface unknownCartIDErrorDescription.
		
	self assert: tusLibros salesBook isEmpty.! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 11/30/2020 22:16:51'!
test11CannotListAnUnknownCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.
	self should: [ tusLibros listCartFor: 1 ]
		raise: Error
		withMessageText: InternalRestInterface unknownCartIDErrorDescription .! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 11/29/2020 18:44:41'!
tusLibros: aFacadeTusLibros checkoutCartID: aCartID

	^aFacadeTusLibros
		checkOutCart: aCartID
		withCCN: testObjectsFactory creditCardNumber 
		withCCED: testObjectsFactory notExpiredCreditCardDate 
		andCCO: testObjectsFactory creditCardOwner
		throught: self
		on: testObjectsFactory today.! !


!InternalRestInterfaceTest methodsFor: 'create' stamp: 'FedericoSabatini 12/1/2020 18:13:53'!
test01CreateCartHaveEmptyList

	| tusLibros cartID |

	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.

	self assert: (Bag new) equals: (tusLibros listCartFor: cartID).! !

!InternalRestInterfaceTest methodsFor: 'create' stamp: 'DS 11/30/2020 22:16:51'!
test02CannotCreateCartWithInvalidPassword

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ tusLibros createCartForUser: 1 withPassword: 'bad password'.]
		raise: Error
 		withMessageText: InternalRestInterface badAuthenticationErrorDescription.! !

!InternalRestInterfaceTest methodsFor: 'create' stamp: 'DS 11/30/2020 22:16:51'!
test03CannotCreateCartWithUnknownUser

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ tusLibros createCartForUser: 3 withPassword: 'pass'. ]
		raise: Error
		withMessageText: InternalRestInterface badAuthenticationErrorDescription.! !

!InternalRestInterfaceTest methodsFor: 'create' stamp: 'DS 11/29/2020 18:31:15'!
test04CannotAssignSameIDForDifferentCarts

	| tusLibros cartID cartID2 |

	tusLibros := testObjectsFactory tusLibros.
	
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	cartID2 := tusLibros createCartForUser: 2 withPassword: 'pass'.

	self assert: (cartID ~= cartID2).! !


!InternalRestInterfaceTest methodsFor: 'expiration clock protocol' stamp: 'FedericoSabatini 11/30/2020 20:32:30'!
now
	^clockBehavior value.! !


!InternalRestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'DS 11/29/2020 17:35:13'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!InternalRestInterfaceTest methodsFor: 'setup' stamp: 'FedericoSabatini 11/30/2020 21:12:28'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	clockBehavior := [ testObjectsFactory now ].! !


!InternalRestInterfaceTest methodsFor: 'list purchases' stamp: 'FedericoSabatini 12/2/2020 11:34:14'!
test18listPurchasesShouldReturnZeroOnEmptyCart

	| tusLibros expectedPurchases cartID  |

	expectedPurchases := OrderedCollection with: '0'.
	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	
	self assert: expectedPurchases equals: (tusLibros listPurchases: cartID).! !

!InternalRestInterfaceTest methodsFor: 'list purchases' stamp: 'FedericoSabatini 12/2/2020 11:42:20'!
test19listPurchasesAfterAddToCartShouldIncludeBookAndTotal

	| tusLibros expectedPurchases cartID |

	expectedPurchases := OrderedCollection 
		with: (testObjectsFactory itemSellByTheStore, ' -> ', testObjectsFactory itemSellByTheStorePrice asString)
		with: testObjectsFactory itemSellByTheStorePrice asString.
		
	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	
	tusLibros addToCart: cartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.
	
	self assert: expectedPurchases equals: (tusLibros listPurchases: cartID).! !

!InternalRestInterfaceTest methodsFor: 'list purchases' stamp: 'FedericoSabatini 12/2/2020 12:15:48'!
test20listPurchasesAfterAddingMultipleBooksShouldIncludeBooksAndTotal

	| tusLibros expectedPurchases cartID |

	expectedPurchases := OrderedCollection 
		with: (testObjectsFactory itemSellByTheStore, ' -> ', (testObjectsFactory itemSellByTheStorePrice * 5) asString)
		with: (testObjectsFactory itemSellByTheStorePrice * 5) asString.
		
	tusLibros := testObjectsFactory tusLibros.
	cartID := tusLibros createCartForUser: 1 withPassword: 'pass'.
	
	tusLibros addToCart: cartID aQuantity: 5 of: testObjectsFactory itemSellByTheStore.
	
	self assert: expectedPurchases equals: (tusLibros listPurchases: cartID).! !


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


!Cart methodsFor: 'total' stamp: 'FedericoSabatini 12/2/2020 11:57:59'!
total
	
	^ items sum: [ :anItem | catalog at: anItem ] ifEmpty: [0]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accesing' stamp: 'FedericoSabatini 12/1/2020 18:19:05'!
items
	
	^items asBag.! !

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


!classDefinition: #InternalRestInterface category: 'TusLibros-Solucion'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'authenticator carts currentID catalog salesBook expiringTime clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'FedericoSabatini 11/30/2020 20:35:11'!
initializeWithAuthenticator: anAuthenticator withCatalog: aCatalog usingClock: aClock 
	
	authenticator := anAuthenticator.
	catalog := aCatalog.
	
	clock := aClock.
	
	carts := Dictionary new.
	currentID := 0.
	salesBook := OrderedCollection new.! !


!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 11/30/2020 22:00:35'!
addToCart: aCartID aQuantity: aQuantity of: anItem
	
	| aSessionCart |

	"self assertUnkownCartID: aCartID.	"

	aSessionCart := self cartWith: aCartID.
	
	(aSessionCart expiringTimestamp < clock now) ifTrue: [ self error: self class cartTimeExpiredErrorDescription ].
	carts at: aCartID put: (SessionCart for: aSessionCart cart expiringAt:  (clock now next: 30*minute) ).
	
	aSessionCart cart add: aQuantity of: anItem.
	
	! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 11/30/2020 22:00:47'!
checkOutCart: aCartID withCCN: anCCN withCCED: anCCED andCCO: anCCO throught: aMerchantProccesor on: aDate

	| creditCard aSessionCart cashier |
	
	"self assertUnkownCartID: aCartID."
	aSessionCart := self cartWith: aCartID.
	
	(aSessionCart expiringTimestamp < clock now) ifTrue: [ self error: self class cartTimeExpiredErrorDescription ].
	carts at: aCartID put: (SessionCart for: aSessionCart cart expiringAt:  (clock now next: 30*minute) ).

	creditCard := CreditCard withNumber: anCCN withOwner: anCCO expiringOn: anCCED.
	cashier := Cashier toCheckout: aSessionCart cart charging: creditCard throught: aMerchantProccesor on: aDate registeringOn: salesBook.

	^cashier checkOut.! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'FedericoSabatini 11/30/2020 20:37:47'!
createCartForUser: anID withPassword: aPassword 

	| cart |

	self assertAuthenticate: anID withPassword: aPassword.
	
	currentID := currentID + 1.
	cart := Cart acceptingItemsOf: catalog.
	
	carts at: currentID put: (SessionCart for: cart expiringAt: (clock now next: 30*minute)).

	^currentID.! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 11/30/2020 22:00:42'!
listCartFor: aCartID

	| aSessionCart |
	aSessionCart := self cartWith: aCartID.
	
	(aSessionCart expiringTimestamp < clock now) ifTrue: [ self error: self class cartTimeExpiredErrorDescription ].
	carts at: aCartID put: (SessionCart for: aSessionCart cart expiringAt:  (clock now next: 30*minute) ).

	^aSessionCart cart items.! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'FedericoSabatini 12/2/2020 12:22:18'!
listPurchases: aCartID

	| aSessionCart purchaseList |
	aSessionCart := self cartWith: aCartID.
	
	(aSessionCart expiringTimestamp < clock now) ifTrue: [ self error: self class cartTimeExpiredErrorDescription ].
	carts at: aCartID put: (SessionCart for: aSessionCart cart expiringAt:  (clock now next: 30*minute) ).
	
	purchaseList := OrderedCollection new.
	
	(aSessionCart cart items) asSet do: 
		[ :cartKey | purchaseList addLast: cartKey, ' -> ', ((catalog at: cartKey) * (aSessionCart cart items occurrencesOf: cartKey)) asString].
	purchaseList addLast: aSessionCart cart total asString.
	
	^purchaseList.! !


!InternalRestInterface methodsFor: 'errors' stamp: 'DS 11/29/2020 18:52:50'!
signalBadAuthentication

	^ self error: self class badAuthenticationErrorDescription! !

!InternalRestInterface methodsFor: 'errors' stamp: 'DS 11/29/2020 18:21:02'!
signalUnknownCartID

	^ self error: self class unknownCartIDErrorDescription! !


!InternalRestInterface methodsFor: 'assertions' stamp: 'DS 11/29/2020 19:00:47'!
assertAuthenticate: anID withPassword: aPassword

	( (authenticator includesKey: anID) not or: [(authenticator at: anID) ~= aPassword] 	)
		ifTrue: [self error: self class badAuthenticationErrorDescription].
! !

!InternalRestInterface methodsFor: 'assertions' stamp: 'DS 11/30/2020 18:51:35'!
cartWith: aCartID

	^(carts at: aCartID ifAbsent: [ self signalUnknownCartID ]).! !


!InternalRestInterface methodsFor: 'accessing' stamp: 'DS 11/29/2020 19:08:20'!
salesBook

	^salesBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros-Solucion'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'FedericoSabatini 11/30/2020 20:34:34'!
withAuthenticator: anAuthenticator withCatalog: aCatalog usingClock: aClock
	^self new initializeWithAuthenticator: anAuthenticator withCatalog: aCatalog usingClock: aClock.! !


!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'FedericoSabatini 11/29/2020 15:39:11'!
badAuthenticationErrorDescription

    ^'Dont exist an user with this password'.! !

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'DS 11/30/2020 18:24:49'!
cartTimeExpiredErrorDescription

	^'Your cart has expired'.! !

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 18:18:17'!
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
	instanceVariableNames: 'today debitBehavior gregorianDateTime'
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


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'FedericoSabatini 11/30/2020 20:46:25'!
initialize

	today := DateAndTime now.
	gregorianDateTime := GregorianDateTime date: FixedGregorianDate today timeOfDay: TimeOfDay now.! !


!StoreTestObjectsFactory methodsFor: 'tusLibros' stamp: 'DS 11/30/2020 22:16:51'!
tusLibros

	| authenticator |

	authenticator := Dictionary with: 1 -> 'pass' with: 2 -> 'pass'.

	^InternalRestInterface 
		withAuthenticator: authenticator 
		withCatalog: self defaultCatalog
		usingClock: self.! !

!StoreTestObjectsFactory methodsFor: 'tusLibros' stamp: 'DS 11/30/2020 22:16:51'!
tusLibros: aClock

	| authenticator |

	authenticator := Dictionary with: 1 -> 'pass' with: 2 -> 'pass'.

	^InternalRestInterface 
		withAuthenticator: authenticator 
		withCatalog: self defaultCatalog
		usingClock: aClock.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'FedericoSabatini 11/30/2020 20:59:02'!
now
	
	^gregorianDateTime! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
