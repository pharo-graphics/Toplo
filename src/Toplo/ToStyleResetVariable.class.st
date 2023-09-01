"
A variable to reset previous values. 
This variable has to be used when user want to override the value of a parent property and replace it for the default value.

## Example

`Geometry { #height: Reset }`
"
Class {
	#name : #ToStyleResetVariable,
	#superclass : #ToStyleAbstractVariable,
	#category : #'Toplo-StyleSheet'
}

{ #category : #'ston-core' }
ToStyleResetVariable class >> stonName [

	^ 'Reset'
]

{ #category : #'instance creation' }
ToStyleResetVariable >> fromSton: stonReader [
]

{ #category : #testing }
ToStyleResetVariable >> isResetVariable [

	^ true
]

{ #category : #evaluating }
ToStyleResetVariable >> preferredValueWith: anObject [

	^ nil
]

{ #category : #evaluating }
ToStyleResetVariable >> value [

	^ nil
]
