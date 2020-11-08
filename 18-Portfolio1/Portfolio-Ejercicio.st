!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
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

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/6/2020 21:31:22'!
test10
	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self 
		should: [ aPortfolio add: aPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedPortfolioRegistersErrorDescription
! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/6/2020 21:39:55'!
test11
	| aPortfolio aRepeatedPortfolioRegister |
	
	aPortfolio := Portfolio new.
	aRepeatedPortfolioRegister  := Portfolio new.
	
	aPortfolio add: aRepeatedPortfolioRegister.
	
	self 
		should: [ aPortfolio add: aRepeatedPortfolioRegister. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedPortfolioRegistersErrorDescription
! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/6/2020 22:05:19'!
test12

	| aPortfolio secondPortfolio |
	
	aPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	
	secondPortfolio add: aPortfolio.
	
	self 
		should: [aPortfolio add: secondPortfolio. 	]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedPortfolioRegistersErrorDescription
! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/7/2020 16:10:02'!
test13

	| aPortfolio secondPortfolio aRepeatedPortfolioRegister |
	
	aPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	
	aRepeatedPortfolioRegister := ReceptiveAccount new.
	
	secondPortfolio add: aRepeatedPortfolioRegister.
	aPortfolio add: aRepeatedPortfolioRegister.
	
	self 
		should: [ aPortfolio add: secondPortfolio. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedPortfolioRegistersErrorDescription
! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/7/2020 16:39:49'!
test14

	| aPortfolio secondPortfolio thirdPortfolio aRepeatedPortfolioRegister |
	
	aPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio  := Portfolio new.
	
	aRepeatedPortfolioRegister := ReceptiveAccount new.
		
	aPortfolio add: aRepeatedPortfolioRegister.
	thirdPortfolio add: aRepeatedPortfolioRegister.
	
	secondPortfolio add: thirdPortfolio. 

	self 
		should: [aPortfolio add: secondPortfolio.]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedPortfolioRegistersErrorDescription
! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/7/2020 16:42:01'!
test15

	| mainPortfolio secondPortfolio thirdPortfolio aRepeatedPortfolioRegister |
	
	mainPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio  := Portfolio new.
	
	aRepeatedPortfolioRegister := ReceptiveAccount new.
		
	secondPortfolio add: aRepeatedPortfolioRegister.
	thirdPortfolio add: aRepeatedPortfolioRegister.
	
	mainPortfolio add: secondPortfolio. 

	self 
		should: [mainPortfolio add: thirdPortfolio.]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedPortfolioRegistersErrorDescription
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
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


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
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

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
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

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
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

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioRegister category: #'Portfolio-Ejercicio'!
Object subclass: #PortfolioRegister
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioRegister methodsFor: 'transactions' stamp: 'Federico 11/6/2020 20:58:26'!
transactions 
	self subclassResponsibility ! !


!PortfolioRegister methodsFor: 'balance' stamp: 'Federico 11/6/2020 20:58:54'!
balance
	self subclassResponsibility ! !


!PortfolioRegister methodsFor: 'testing' stamp: 'Federico 11/6/2020 21:00:28'!
hasRegistered: aTransaction
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
PortfolioRegister subclass: #Portfolio
	instanceVariableNames: 'portfolioRegisters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'Federico 11/7/2020 17:12:21'!
hasPortfolioRegister: aPortfolioRegister
	^(self = aPortfolioRegister)
	or: [portfolioRegisters includes: aPortfolioRegister]
	or: [(portfolioRegisters select: [ :selfportfolioRegisters | selfportfolioRegisters  hasPortfolioRegister: aPortfolioRegister ]) isEmpty not] "SELF"
	
	or: [(portfolioRegisters select: [ :selfportfolioRegisters | aPortfolioRegister  hasPortfolioRegister: selfportfolioRegisters ]) isEmpty not] "aPortfolioRegister"
	! !

!Portfolio methodsFor: 'testing' stamp: 'Federico 11/6/2020 21:01:52'!
hasRegistered: aTransaction
	^(portfolioRegisters select: [ :aNode | aNode  hasRegistered: aTransaction. ]) isEmpty not.
! !


!Portfolio methodsFor: 'initialization' stamp: 'Federico 11/6/2020 21:01:52'!
initialize
	portfolioRegisters := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'Federico 11/6/2020 21:01:52'!
transactions
	^(portfolioRegisters collect: [ :node | node transactions ]) flatten.
	! !


!Portfolio methodsFor: 'balance' stamp: 'Federico 11/6/2020 21:01:52'!
balance
	^portfolioRegisters sum: [ :aNode | aNode balance.] ifEmpty: [0].
	
	! !


!Portfolio methodsFor: 'adding' stamp: 'Federico 11/7/2020 17:13:57'!
add: aPortfolioRegister


	(
		(self hasPortfolioRegister: aPortfolioRegister)
		or: [aPortfolioRegister hasPortfolioRegister: self] 
	)
		ifTrue: [self error: self class shouldNotHaveRepeatedPortfolioRegistersErrorDescription ].
	
	
	portfolioRegisters add: aPortfolioRegister.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'Federico 11/6/2020 21:33:19'!
shouldNotHaveRepeatedPortfolioRegistersErrorDescription
	^'A portfolio should not have repeated portfolio registers'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
PortfolioRegister subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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
