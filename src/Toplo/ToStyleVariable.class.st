"
A holder for an attribute `atomic` value.
It holds numbers, strings, symbols.
"
Class {
	#name : #ToStyleVariable,
	#superclass : #ToStyleAbstractVariable,
	#instVars : [
		'value'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #'instance creation' }
ToStyleVariable class >> newValue: anObject [

	^ self new 
		value: anObject;
		yourself
]

{ #category : #'ston-core' }
ToStyleVariable class >> stonName [

	^ 'Variable'
]

{ #category : #evaluating }
ToStyleVariable >> nonscaledValue [

	^ self value ifNil: [ 0 ]
]

{ #category : #evaluating }
ToStyleVariable >> preferredScaledValueWith: anObject [

	^ self value = 0 
		ifTrue: [ anObject ]
		ifFalse: [ self scaledValue ]
]

{ #category : #evaluating }
ToStyleVariable >> preferredValueWith: anObject [

	^ self value = 0 
		ifTrue: [ anObject ]
		ifFalse: [ self value ]
]

{ #category : #evaluating }
ToStyleVariable >> scaledValue [

	^ self nonscaledValue * self currentWorld displayScaleFactor
]

{ #category : #private }
ToStyleVariable >> toColor: aColorOrSymbol [

	"Try if color"
	aColorOrSymbol isSymbol ifFalse: [ ^ aColorOrSymbol ].
	"Try by name"
	(Color named: aColorOrSymbol) ifNotNil: [ :aColor | ^ aColor ]. 
	"Try by HEX (CSS style)"				
	^ Color fromHexString: aColorOrSymbol
]

{ #category : #evaluating }
ToStyleVariable >> value [

	^ value
]

{ #category : #accessing }
ToStyleVariable >> value: anObject [

	value := anObject
]

{ #category : #evaluating }
ToStyleVariable >> valueAsColor [

	^ self toColor: self value
]
