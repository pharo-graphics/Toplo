Class {
	#name : #ToBarFlowLayout,
	#superclass : #BlFlowLayout,
	#instVars : [
		'lineUniformWidth'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #comparing }
ToBarFlowLayout >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	self lineUniformWidth = anObject lineUniformWidth ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
ToBarFlowLayout >> hash [

	^ super hash bitXor: self lineUniformWidth hash
]

{ #category : #accessing }
ToBarFlowLayout >> lineUniformWidth [

	^ lineUniformWidth ifNil: [ lineUniformWidth := false ]
]

{ #category : #accessing }
ToBarFlowLayout >> lineUniformWidth: aBoolean [
	" an option that set the same width to all elements of a line "
	lineUniformWidth := aBoolean
]

{ #category : #initialization }
ToBarFlowLayout >> newMeasurer [ 

	^ ToBarFlowLayoutMeasurer for: self
]
