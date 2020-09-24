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

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/24/2020 00:52:04'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook add |
	
	customerBook := CustomerBook new.
	add := [customerBook addCustomerNamed: (self johnLennonCustomer)] .
	
	self timeOfOperation: add mustBeLessThan: 50*millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/24/2020 00:53:05'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney remove |
	
	customerBook := CustomerBook new.
	paulMcCartney := self paulMcCartneyCustomer.
	customerBook addCustomerNamed: paulMcCartney.
	
	remove :=  [customerBook removeCustomerNamed: (self paulMcCartneyCustomer)].
	
	self timeOfOperation: remove mustBeLessThan: 100*millisecond.! !

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

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/24/2020 00:40:29'!
test04CanNotRemoveAnInvalidCustomer
	
	| sampleCustomerBook remove paulMcCartney |

	sampleCustomerBook := self johnLennonCustomerBook .
	remove := #removeCustomerNamed:.
	paulMcCartney := self paulMcCartneyCustomer.

	self sampleBook: sampleCustomerBook mustBeInmutableWhenOperation: remove withCustomer: paulMcCartney raiseError: NotFound.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/24/2020 00:56:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| sampleCustomerBook paulMcCartney zeroCustomers oneCustomer |
	
	sampleCustomerBook  := self paulMcCartneySuspendedCustomerBook.
	paulMcCartney  := self paulMcCartneyCustomer.
	zeroCustomers := 0.
	oneCustomer  := 1.

	self sampleBook: sampleCustomerBook mustHasActives: zeroCustomers andSuspended: oneCustomer.
	self assert: (sampleCustomerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/24/2020 00:56:58'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| sampleCustomerBook paulMcCartney zeroCustomers |
	
	sampleCustomerBook  := self paulMcCartneySuspendedCustomerBook.
	paulMcCartney  := self paulMcCartneyCustomer.
	sampleCustomerBook removeCustomerNamed: paulMcCartney.
	zeroCustomers := 0.

	self sampleBook: sampleCustomerBook mustHasActives: zeroCustomers andSuspended: zeroCustomers.
	self deny: (sampleCustomerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/24/2020 00:40:56'!
test07CanNotSuspendAnInvalidCustomer
	
	| sampleCustomerBook suspended georgeHarrison |

	sampleCustomerBook := self johnLennonCustomerBook.
	suspended := #suspendCustomerNamed:.
	georgeHarrison := self georgeHarrisonCustomer.

	self sampleBook: sampleCustomerBook mustBeInmutableWhenOperation: suspended withCustomer: georgeHarrison raiseError: CantSuspend.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DS 9/24/2020 00:41:03'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| sampleCustomerBook suspended johnLennon |

	sampleCustomerBook := self johnLennonSuspendedCustomerBook.
	suspended := #suspendCustomerNamed:.
	johnLennon := self johnLennonCustomer.

	self sampleBook: sampleCustomerBook mustBeInmutableWhenOperation: suspended withCustomer: johnLennon raiseError: CantSuspend.! !


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


!CustomerBookTest methodsFor: 'helpers' stamp: 'DS 9/24/2020 00:40:14'!
sampleBook: customerBook mustBeInmutableWhenOperation: operation withCustomer: customer raiseError: signalError

	| sampleCustomer |

	sampleCustomer := self johnLennonCustomer.

	[ operation sendTo: customerBook with: customer.
		self fail ]
			on: signalError
			do: [ :anError |
				self assert: customerBook numberOfCustomers = 1.
				self assert: (customerBook includesCustomerNamed: sampleCustomer)].! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'DS 9/24/2020 00:56:40'!
sampleBook: customerBook mustHasActives: numberOfActives andSuspended: numberOfSuspended

	| totalCustomers |

	totalCustomers := numberOfActives + numberOfSuspended.

	self assert: numberOfActives equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspended equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'DS 9/24/2020 00:53:55'!
timeOfOperation: operationToRun mustBeLessThan: timeAllowed

	| timeBeforeRunning timeAfterRunning |

	timeBeforeRunning := Time millisecondClockValue * millisecond.
	operationToRun value.
	timeAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (timeBeforeRunning-timeAfterRunning) < timeAllowed.! !


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


!CustomerBook methodsFor: 'errors management' stamp: 'DS 9/24/2020 00:37:43'!
raiseErrorWithMessage: message

	| errorMessage |
	errorMessage := message sendTo: (self class).

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

!CustomerBook methodsFor: 'customer management' stamp: 'DS 9/24/2020 00:38:17'!
signalCustomerAlreadyExists 

	self raiseErrorWithMessage: #customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'DS 9/24/2020 00:38:01'!
signalCustomerNameCannotBeEmpty 

	self raiseErrorWithMessage: #customerCanNotBeEmptyErrorMessage.! !

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
