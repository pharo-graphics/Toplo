Class {
	#name : #ToStyleVariableSTONReader,
	#superclass : #ToStyleSTONReader,
	#category : #'Toplo-StyleSheet'
}

{ #category : #parsing }
ToStyleVariableSTONReader >> isContainedValueChar: char [

	^ char = $(
]

{ #category : #parsing }
ToStyleVariableSTONReader >> parseContainedValue [
	| result | 

	self parseContainedValueDo: [ :aValue | result := aValue ].

	^ result

]

{ #category : #parsing }
ToStyleVariableSTONReader >> parseContainedValueDo: block [

	self expectChar: $(.
	(self matchChar: $)) ifTrue: [ ^ self ]. "short cut for empty value"
	[ readStream atEnd ] whileFalse: [
		block cull: self parseValue.
		(self matchChar: $)) ifTrue: [ ^ self ]  ].

	self error: 'end of contained value expected'
]

{ #category : #parsing }
ToStyleVariableSTONReader >> parseNamedInstVarsFor: anObject [

	self parseMapDo: [ :instVarName :value |
		anObject 
			instVarNamed: instVarName asString 
			put: value asStyleVariable ]
]

{ #category : #parsing }
ToStyleVariableSTONReader >> parseSimpleValue [
	| char |

	readStream atEnd ifFalse: [ 
		char := readStream peek.
		(self isContainedValueChar: char) ifTrue: [ 
			^ self parseContainedValue ] ].

	^ super parseSimpleValue
]

{ #category : #private }
ToStyleVariableSTONReader >> styleClasses [

	^ super styleClasses, ToStyleAbstractVariable allSubclasses
]
