!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/19/2020 21:35:20'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook addOperation |
	
	customerBook := CustomerBook new.
	addOperation := [customerBook addCustomerNamed: (self johnLennonCustomer)] .
	
	self assert: (self checkTimeOfOperation: addOperation withMillisecondsAllowed: 50 ).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/19/2020 21:37:43'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney removeOperation |
	
	customerBook := CustomerBook new.
	paulMcCartney := self paulMcCartneyCustomer.
	customerBook addCustomerNamed: paulMcCartney.
	
	removeOperation :=  [customerBook removeCustomerNamed: (self paulMcCartneyCustomer)].
	
	self assert: (self checkTimeOfOperation: removeOperation withMillisecondsAllowed: 100 ).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/20/2020 00:58:28'!
test04CanNotRemoveAnInvalidCustomer
	
	| sampleCustomerBook operation customer |

	sampleCustomerBook := self johnLennonCustomerBook .
	operation := #removeCustomerNamed:.
	customer := self paulMcCartneyCustomer.

	self sampleBook: sampleCustomerBook isInmutableWhen: operation with: customer wakeUp: NotFound.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/20/2020 00:58:03'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| sampleCustomerBook paulMcCartney zeroActiveCustomers oneSuspendedCustomers |
	
	sampleCustomerBook  := self paulMcCartneySuspendedCustomerBook.
	paulMcCartney  := self paulMcCartneyCustomer.
	zeroActiveCustomers := 0.
	oneSuspendedCustomers  := 1.
	
	self sampleBook: sampleCustomerBook has: zeroActiveCustomers and: oneSuspendedCustomers.
	self assert: (sampleCustomerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/20/2020 00:57:11'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| sampleCustomerBook paulMcCartney zeroActiveCustomers zeroSuspendedCustomers |
	
	sampleCustomerBook  := self paulMcCartneySuspendedCustomerBook.
	paulMcCartney  := self paulMcCartneyCustomer.
	sampleCustomerBook removeCustomerNamed: paulMcCartney.
	zeroActiveCustomers := 0.
	zeroSuspendedCustomers  := 0.
	
	self sampleBook: sampleCustomerBook has: zeroActiveCustomers and: zeroSuspendedCustomers.
	self deny: (sampleCustomerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/20/2020 00:38:40'!
test07CanNotSuspendAnInvalidCustomer
	
	| sampleCustomerBook operation customer |

	sampleCustomerBook := self johnLennonCustomerBook.
	operation := #suspendCustomerNamed:.
	customer := self georgeHarrisonCustomer.

	self sampleBook: sampleCustomerBook isInmutableWhen: operation with: customer wakeUp: CantSuspend.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/20/2020 00:38:33'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| sampleCustomerBook operation customer |

	sampleCustomerBook := self johnLennonSuspendedCustomerBook.
	operation := #suspendCustomerNamed:.
	customer := self johnLennonCustomer.

	self sampleBook: sampleCustomerBook isInmutableWhen: operation with: customer wakeUp: CantSuspend.! !


!CustomerBookTest methodsFor: 'sample data' stamp: 'DS 9/19/2020 21:29:52'!
georgeHarrisonCustomer

	^ 'George Harrison'.! !

!CustomerBookTest methodsFor: 'sample data' stamp: 'DS 9/19/2020 21:23:12'!
johnLennonCustomer

	^ 'John Lennon'.! !

!CustomerBookTest methodsFor: 'sample data' stamp: 'DS 9/20/2020 00:17:40'!
johnLennonCustomerBook

	| customerBook |

	customerBook := CustomerBook new.
	customerBook addCustomerNamed: (self johnLennonCustomer).
	^ customerBook .! !

!CustomerBookTest methodsFor: 'sample data' stamp: 'DS 9/20/2020 00:17:35'!
johnLennonSuspendedCustomerBook

	| customerBook |

	customerBook := self johnLennonCustomerBook.
	customerBook suspendCustomerNamed: (self johnLennonCustomer).

	^customerBook.
	! !

!CustomerBookTest methodsFor: 'sample data' stamp: 'DS 9/19/2020 21:27:30'!
paulMcCartneyCustomer

	^ 'Paul McCartney'.! !

!CustomerBookTest methodsFor: 'sample data' stamp: 'DS 9/20/2020 00:17:16'!
paulMcCartneySuspendedCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := self paulMcCartneyCustomer.

	customerBook := CustomerBook new.
	customerBook addCustomerNamed:paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	^ customerBook .! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'DS 9/19/2020 20:49:51'!
checkTimeOfOperation: operationToRun withMillisecondsAllowed: millisecondsAllowed

	|millisecondsBeforeRunning millisecondsAfterRunning|

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	operationToRun value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^ (millisecondsAfterRunning-millisecondsBeforeRunning) < (millisecondsAllowed * millisecond).! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'DS 9/20/2020 00:36:58'!
sampleBook: customerBook has: activeCustomers and: suspendedCustomers

	| totalCustomers |

	totalCustomers := activeCustomers + suspendedCustomers.

	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'DS 9/21/2020 18:44:19'!
sampleBook: customerBook isInmutableWhen: operation with: customer wakeUp: signalError

	| sampleCustomer |

	sampleCustomer := self johnLennonCustomer.

	[ operation sendTo: customerBook with: customer.
		self fail ]
			on: signalError
			do: [ :anError |
				self assert: customerBook numberOfCustomers = 1.
				self assert: (customerBook includesCustomerNamed: sampleCustomer)].! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'DS 9/21/2020 18:29:10'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ].! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'errors management' stamp: 'DS 9/21/2020 18:42:03'!
wakeUpSignalError: signal

	| errorMessage |
	errorMessage := signal sendTo: (self class).

	self error: errorMessage. ! !


!CustomerBook methodsFor: 'customer management' stamp: 'DS 9/21/2020 18:27:29'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'DS 9/21/2020 17:32:13'!
numberOfCustomers
	
	^self numberOfActiveCustomers  + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'DS 9/20/2020 20:36:45'!
removeCustomerNamed: aName 

    | removeNameFromCollection |

    removeNameFromCollection := [:collection |
	(collection includes: aName) ifTrue: [^collection remove: aName].
    ].

    removeNameFromCollection value: active.
    removeNameFromCollection value: suspended.

    ^ NotFound signal! !

!CustomerBook methodsFor: 'customer management' stamp: 'DS 9/21/2020 23:19:06'!
signalCustomerAlreadyExists 

	self wakeUpSignalError: #customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'DS 9/21/2020 18:41:49'!
signalCustomerNameCannotBeEmpty 

	self wakeUpSignalError: #customerCanNotBeEmptyErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
