"
An abstract variable to be used for style properties (values will be expressed in instance of `ToStyleAbstractVariable` children instead its _atomic_ values.
"
Class {
	#name : #ToStyleAbstractVariable,
	#superclass : #Object,
	#category : #'Toplo-StyleSheet'
}

{ #category : #converting }
ToStyleAbstractVariable >> asStyleVariable [

	^ self
]

{ #category : #testing }
ToStyleAbstractVariable >> isEnvironmentVariable [

	^ false
]

{ #category : #testing }
ToStyleAbstractVariable >> isResetVariable [

	^ false
]

{ #category : #evaluating }
ToStyleAbstractVariable >> nonscaledValue [

	^ self value
]

{ #category : #evaluating }
ToStyleAbstractVariable >> preferredScaledValueWith: anObject [

	^ self value
]

{ #category : #evaluating }
ToStyleAbstractVariable >> preferredValueWith: anObject [

	^ self value
]

{ #category : #evaluating }
ToStyleAbstractVariable >> scaledValue [

	^ self nonscaledValue
]

{ #category : #evaluating }
ToStyleAbstractVariable >> value [

	^ self subclassResponsibility
]
