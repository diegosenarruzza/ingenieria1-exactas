!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'balance tests' stamp: 'Federico 11/6/2020 11:49:24'!
test01PortfolioStartsWithNoIncome
	| aPortfolio |
	aPortfolio := Portfolio new.
	
	self assert: 0 equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'Federico 11/6/2020 11:51:08'!
test02BalanceCountAccountTransactions
	| aPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio add: anAccount.
	Deposit register: 100 on: anAccount.
		
	self assert: 100 equals: aPortfolio balance.

! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'Federico 11/6/2020 11:51:48'!
test03BalanceCountPortafolioAndAccountTransactions
	| aMainPortfolio anotherPortfolio aPortfolioAccount aMainAccount |
	
	aMainPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aMainAccount := ReceptiveAccount new.
	aPortfolioAccount  := ReceptiveAccount new.
	
	anotherPortfolio add: aPortfolioAccount.
	aMainPortfolio add: aMainAccount.
	aMainPortfolio add: anotherPortfolio.

	Deposit register: 100 on: aMainAccount.
	Deposit register: 100 on: aPortfolioAccount.
		
	self assert: 200 equals: aMainPortfolio balance.

! !


!PortfolioTest methodsFor: 'hasRegistered tests' stamp: 'Federico 11/6/2020 11:55:34'!
test04PortfolioDoesNotRegisterUnknownTransaction

	| aPortfolio aTransaction |
	
	aPortfolio := Portfolio new.
	
	aTransaction :=  Deposit for: 100.
		
	self deny: (aPortfolio hasRegistered: aTransaction).

! !

!PortfolioTest methodsFor: 'hasRegistered tests' stamp: 'Federico 11/6/2020 11:56:07'!
test05PortfolioHasRegisteredAccountTransactions
	| aPortfolio anAccount aTransaction |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aTransaction := Deposit register: 100 on: anAccount.
	aPortfolio add: anAccount.
		
	self assert: (aPortfolio hasRegistered: aTransaction).

! !

!PortfolioTest methodsFor: 'hasRegistered tests' stamp: 'Federico 11/6/2020 11:56:43'!
test06PortfolioHasRegisteredAnotherPortfolioTransactions

	| aMainPortfolio anotherPortfolio aPortfolioAccount aMainAccount aTransaction secondTransaction |
	
	aMainPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aMainAccount := ReceptiveAccount new.
	aPortfolioAccount  := ReceptiveAccount new.
	
	anotherPortfolio add: aPortfolioAccount.
	
	aMainPortfolio add: aMainAccount.
	aMainPortfolio add: anotherPortfolio.

	aTransaction := Deposit register: 100 on: aPortfolioAccount.	
	secondTransaction := Deposit register: 100 on: aMainAccount.

	self assert: (anotherPortfolio hasRegistered: aTransaction).
	self assert: (aMainPortfolio hasRegistered: secondTransaction).
	self assert: (aMainPortfolio hasRegistered: aTransaction).


! !


!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/6/2020 11:57:48'!
test07PortfolioStartsWithNoTransactions
	| aPortfolio |
	
	aPortfolio := Portfolio new.
		
		
	self assert: ((aPortfolio transactions) isEmpty).

! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/6/2020 11:58:13'!
test08PortfolioIncludesAccountTransactions
	| aPortfolio anAccount aTransaction |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio add: anAccount.
	aTransaction := Deposit register: 50 on: anAccount.
		
	self assert: 1 equals: anAccount transactions size.
	self assert: (aPortfolio transactions includes: aTransaction).
		

! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/6/2020 11:58:28'!
test09PortfolioIncludesAnotherPortfolioTransactions
	| aMainPortfolio anotherPortfolio aMainAccount aPortfolioAccount aTransaction secondTransaction |
	
	aMainPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aPortfolioAccount  := ReceptiveAccount new.
	aMainAccount  := ReceptiveAccount new.
	
	anotherPortfolio add: aPortfolioAccount.
	
	aMainPortfolio add: anotherPortfolio.
	aMainPortfolio add: aMainAccount.

	aTransaction := Deposit register: 100 on: aPortfolioAccount.	
	secondTransaction := Deposit register: 200 on: aMainAccount.	
		
	self assert: 2 equals: aMainPortfolio transactions size.
	self assert: (aMainPortfolio transactions includes: aTransaction).
	self assert: (aMainPortfolio transactions includes: secondTransaction).
		

! !


!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test10PortafolioShouldNotBeAddedToHimself
	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self 
		should: [ aPortfolio add: aPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test11AddedPortfolioShouldNotContainRepeatedChilds
	| mainPortfolio secondPortfolio |
	
	mainPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	
	mainPortfolio add: secondPortfolio.
	self 
		should: [ secondPortfolio add: mainPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test12AddedPortafolioShouldNotContainSuccesiveRepeatedChilds
	| mainPortfolio secondPortfolio thirdPortfolio |
	
	mainPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	thirdPortfolio := Portfolio new.
	
	mainPortfolio add: secondPortfolio.
	secondPortfolio add: thirdPortfolio.
	self 
		should: [ thirdPortfolio add: mainPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test13AddedPortafolioShouldNotBeInHisChilds

	| aPortfolio aRepeatedPortfolio |
	
	aPortfolio := Portfolio new.
	aRepeatedPortfolio  := Portfolio new.
	
	aPortfolio add: aRepeatedPortfolio.
	
	self 
		should: [ aPortfolio add: aRepeatedPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
		
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test14AddedPortafolioShouldNotBeInHisSuccesiveChilds

	| mainPortfolio secondPortfolio aRepeatedPortfolio |
	
	mainPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	aRepeatedPortfolio  := Portfolio new.
	
	mainPortfolio add: secondPortfolio. 
	secondPortfolio add: aRepeatedPortfolio.
	
	self 
		should: [ mainPortfolio add: aRepeatedPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
		
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test15AddedPortfolioChildsShouldNotBeInPortfolioChilds
	
	| aPortfolio secondPortfolio aRepeatedPortfolioRegister |
	
	aPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	
	aRepeatedPortfolioRegister := ReceptiveAccount new.
	
	secondPortfolio add: aRepeatedPortfolioRegister.
	aPortfolio add: aRepeatedPortfolioRegister.
	
	self 
		should: [ aPortfolio add: secondPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
		
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test16AddedPortfolioHerarchyShouldNotBeInHisHerarchy
	
	| aPortfolio secondPortfolio thirdPortfolio aRepeatedPortfolioRegister |
	
	aPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio := Portfolio new.
	
	aRepeatedPortfolioRegister := ReceptiveAccount new.
	
	thirdPortfolio add: aRepeatedPortfolioRegister.
	secondPortfolio add: aRepeatedPortfolioRegister.
	
	aPortfolio add: secondPortfolio.
	
	self 
		should: [ aPortfolio add: thirdPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
		
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test17
	
	| rootPortfolio secondPortfolio thirdPortfolio  |
	
	rootPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio := Portfolio new.

	rootPortfolio add: secondPortfolio.
	rootPortfolio add: thirdPortfolio.
	
	self 
		should: [ secondPortfolio add: thirdPortfolio ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
		
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test18
	
	| rootPortfolio secondPortfolio thirdPortfolio FourthPortfolio Account |
	
	rootPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio := Portfolio new.
	
	FourthPortfolio := Portfolio new.
	Account := ReceptiveAccount new.
	
	rootPortfolio add: secondPortfolio.
	rootPortfolio add: thirdPortfolio.
	
	secondPortfolio add: Account.
	thirdPortfolio add: FourthPortfolio.
	
	self 
		should: [ FourthPortfolio add: Account ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
		
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 20:03:17'!
test19
	
	| rootPortfolio1 rootPortfolio2 aPortfolio anAccount |
	
	rootPortfolio1 := Portfolio new.
	rootPortfolio2 := Portfolio new.

	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.

	rootPortfolio1 add: aPortfolio.
	rootPortfolio1 add: anAccount.	
	rootPortfolio2 add: aPortfolio.

	self 
		should: [ aPortfolio add: anAccount ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
		
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'Federico 11/2/2020 20:48:56'!
countFor: aBalance
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'Federico 11/2/2020 20:48:17'!
countFor: aBalance
	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'Federico 11/2/2020 19:20:48'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'Federico 11/2/2020 20:48:37'!
countFor: aBalance
	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankRecord category: 'Portfolio-Ejercicio'!
Object subclass: #BankRecord
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankRecord methodsFor: 'transactions' stamp: 'Federico 11/6/2020 20:58:26'!
transactions 
	self subclassResponsibility ! !


!BankRecord methodsFor: 'balance' stamp: 'Federico 11/6/2020 20:58:54'!
balance
	self subclassResponsibility ! !


!BankRecord methodsFor: 'testing' stamp: 'Federico 11/6/2020 21:00:28'!
hasRegistered: aTransaction
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankRecord subclass: #Portfolio
	instanceVariableNames: 'bankRecords parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'DS 11/8/2020 20:00:29'!
hasPortfolioRegister: aPortfolioRegister

	^(self = aPortfolioRegister)
	or: [(bankRecords select: [ :childRegisters | aPortfolioRegister  hasPortfolioRegister: childRegisters ]) isEmpty not]
	or: [(bankRecords select: [ :childRegisters | childRegisters  hasPortfolioRegister: aPortfolioRegister ]) isEmpty not].
	! !

!Portfolio methodsFor: 'testing' stamp: 'DS 11/8/2020 20:00:29'!
hasRegistered: aTransaction
	^(bankRecords select: [ :aNode | aNode  hasRegistered: aTransaction. ]) isEmpty not.
! !


!Portfolio methodsFor: 'initialization' stamp: 'DS 11/8/2020 20:00:29'!
initialize

	bankRecords := OrderedCollection new.
	parentPortfolios := RootParentPortfolio for: self.! !


!Portfolio methodsFor: 'transactions' stamp: 'DS 11/8/2020 20:00:29'!
transactions
	^(bankRecords collect: [ :node | node transactions ]) flatten.
	! !


!Portfolio methodsFor: 'balance' stamp: 'DS 11/8/2020 20:00:29'!
balance
	^bankRecords sum: [ :aNode | aNode balance.] ifEmpty: [0].
	
	! !


!Portfolio methodsFor: 'assert / errors' stamp: 'DS 11/8/2020 20:01:56'!
assertRepeatedBankRecord: aBankRecord

	| rootPortfolios |
	
	rootPortfolios := self rootPortfolios.		
	
	((rootPortfolios select: [:rootPorfolio | rootPorfolio hasPortfolioRegister: aBankRecord]) isEmpty not)
	ifTrue: [self signalShouldNotHaveRepeatedBankRecords ]! !

!Portfolio methodsFor: 'assert / errors' stamp: 'DS 11/8/2020 20:02:22'!
signalShouldNotHaveRepeatedBankRecords

	^ self error: self class shouldNotHaveRepeatedBankRecordsErrorDescription! !


!Portfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 20:01:05'!
add: aBankRecord

	self assertRepeatedBankRecord: aBankRecord.

	aBankRecord addTo: self.	! !

!Portfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 20:00:47'!
addSecure: aBankRecord

	bankRecords add: aBankRecord.! !

!Portfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 19:41:10'!
addTo: aPortfolio

	parentPortfolios := 	parentPortfolios addParent: aPortfolio.

	aPortfolio addSecure: self.! !


!Portfolio methodsFor: 'roots' stamp: 'DS 11/8/2020 19:45:47'!
rootPortfolios

	^parentPortfolios roots.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'DS 11/8/2020 20:02:32'!
shouldNotHaveRepeatedBankRecordsErrorDescription
	^'A portfolio should not have repeated bank records'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankRecord subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parentRegisters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DS 11/8/2020 18:14:01'!
initialize

	transactions := OrderedCollection new.
	parentRegisters  := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Federico 11/2/2020 20:46:39'!
balance

    | balance |
    balance := 0.

    transactions do: [ :aTransaction | balance := aTransaction countFor: balance ].

    ^balance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'Federico 11/7/2020 16:18:24'!
hasPortfolioRegister: aPortfolioRegister
	^self = aPortfolioRegister.
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'Federico 11/7/2020 16:15:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'adding' stamp: 'DS 11/8/2020 19:09:51'!
addTo: aPortfolio

	aPortfolio addSecure: self.! !


!classDefinition: #ParentPortfolio category: 'Portfolio-Ejercicio'!
Object subclass: #ParentPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #CollectionParentPortfolio category: 'Portfolio-Ejercicio'!
ParentPortfolio subclass: #CollectionParentPortfolio
	instanceVariableNames: 'parents portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!CollectionParentPortfolio methodsFor: 'initialization' stamp: 'DS 11/8/2020 19:44:08'!
initializeFor: aPortfolio with: aParentPortfolio

	portfolio := aPortfolio.
	parents := OrderedCollection with: aParentPortfolio.! !


!CollectionParentPortfolio methodsFor: 'as yet unclassified' stamp: 'DS 11/8/2020 19:38:50'!
addParent: aParentPortfolio

	parents add: aParentPortfolio.
	^self.! !

!CollectionParentPortfolio methodsFor: 'as yet unclassified' stamp: 'DS 11/8/2020 19:39:31'!
roots

	^(parents collect: [ :parentPortfolio | parentPortfolio rootPortfolios ]) flatten.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CollectionParentPortfolio class' category: 'Portfolio-Ejercicio'!
CollectionParentPortfolio class
	instanceVariableNames: ''!

!CollectionParentPortfolio class methodsFor: 'instance creation' stamp: 'DS 11/8/2020 19:43:11'!
for: aPortfolio with: aParentPortfolio

	^self new initializeFor: aPortfolio with: aParentPortfolio.! !


!classDefinition: #RootParentPortfolio category: 'Portfolio-Ejercicio'!
ParentPortfolio subclass: #RootParentPortfolio
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootParentPortfolio methodsFor: 'initialization' stamp: 'DS 11/8/2020 19:44:53'!
initializateFor: aPortfolio

	portfolio := aPortfolio.! !


!RootParentPortfolio methodsFor: 'as yet unclassified' stamp: 'DS 11/8/2020 19:37:53'!
addParent: aParentPortfolio

	^CollectionParentPortfolio for: portfolio with: aParentPortfolio.! !

!RootParentPortfolio methodsFor: 'as yet unclassified' stamp: 'DS 11/8/2020 19:38:13'!
roots

	^OrderedCollection with: portfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootParentPortfolio class' category: 'Portfolio-Ejercicio'!
RootParentPortfolio class
	instanceVariableNames: ''!

!RootParentPortfolio class methodsFor: 'as yet unclassified' stamp: 'DS 11/8/2020 19:44:38'!
for: aPortfolio

	^self new initializateFor: aPortfolio.! !
