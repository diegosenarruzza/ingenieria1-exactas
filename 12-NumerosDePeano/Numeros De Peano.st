!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 18:44:02'!
* unNumero
	^unNumero .! !

!I class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:02:59'!
+ unNumero
	^unNumero next.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:00:58'!
- unNumero
	^self descripcionDeErrorDeNumerosNegativosNoSoportados .
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:17:44'!
/ unNumero 
	^ unNumero = self
		ifTrue: [self]
		ifFalse: [self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ] .! !

!I class methodsFor: 'as yet unclassified' stamp: 'DS 9/17/2020 01:09:54'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	Error new signal: 'No se puede dividir por un numero mayor'. 
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'DS 9/17/2020 01:09:46'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ Error new signal: 'No se soportan numeros negativos.' 	. 
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:02:59'!
next
	^self createChildNamed: self name, 'I'! !


!classDefinition: #II category: #'Numeros De Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:03:24'!
* unNumero
	^(self previous * unNumero) + unNumero .! !

!II class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:03:24'!
+ unNumero

	^self previous + unNumero next! !

!II class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:03:24'!
- unNumero 
	^ (unNumero = I) ifTrue: [self previous] ifFalse: [self previous - unNumero previous] .! !

!II class methodsFor: 'as yet unclassified' stamp: 'DS 9/17/2020 00:40:28'!
/ unNumero

	^ unNumero = I ifTrue: [self]
		ifFalse: [ 	self = unNumero 
			ifTrue: [I]
			ifFalse: [self > unNumero ifTrue: [self > unNumero next ifTrue: [ self - unNumero / unNumero + I] ifFalse: [I]] ifFalse: [self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]]
		].! !

!II class methodsFor: 'as yet unclassified' stamp: 'DS 9/17/2020 00:42:05'!
> unNumero

	^(self name) size > (unNumero name) size! !

!II class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:03:24'!
previous
	^self parent! !


!classDefinition: #III category: #'Numeros De Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIII category: #'Numeros De Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIII category: #'Numeros De Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIII category: #'Numeros De Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #NumerosDePeanoTest category: #'Numeros De Peano'!
DenotativeObject subclass: #NumerosDePeanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumerosDePeanoTest class' category: #'Numeros De Peano'!
NumerosDePeanoTest class
	instanceVariableNames: ''!

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:03:54'!
test01SiguienteIEsII

	Assert that: I next isEqualTo: II.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:03:58'!
test02SiguienteIIEsIII

	Assert that: II next isEqualTo: III.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:04:08'!
test03SumaDeIYIEsElSiguiente

	Assert that: I+I isEqualTo: I next.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 09:08:05'!
test04SumaDeUnNumeroYIEsElSiguiente

	Assert that: III+I isEqualTo: IIII.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:04:16'!
test05AnteriorDeIIEsI

	Assert that: II previous isEqualTo: I.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 23:04:22'!
test06AnteriorDeIIIEsII

	Assert that: III previous isEqualTo: II.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 09:09:15'!
test07RestaDeIIYIEsI

	Assert that: II - I isEqualTo: I.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 18:28:31'!
test08RestaDeIIIIYIIEsII

	Assert that: IIII - II isEqualTo: II.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 18:29:53'!
test09ProductoDeIYIIEsII

	Assert that: I * II isEqualTo: II.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 18:42:51'!
test10ProductoDeIIYIIIEsIIIIII

	Assert that: II * III isEqualTo: IIIIII.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/16/2020 22:48:39'!
test11CocienteEntreIIYIIEsI

	Assert that: II / II isEqualTo: I.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'DS 9/17/2020 01:08:05'!
test12CocienteEntreIIIIIIYIIEsIII

	Assert that: IIIIII / II isEqualTo: III.! !
