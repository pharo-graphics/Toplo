Class {
	#name : #ToBarFlowLayout,
	#superclass : #BlFlowLayout,
	#instVars : [
		'uniformNodeWidth'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #comparing }
ToBarFlowLayout >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	self uniformNodeWidth = anObject uniformNodeWidth ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
ToBarFlowLayout >> hash [

	^ super hash bitXor: self uniformNodeWidth hash
]

{ #category : #initialization }
ToBarFlowLayout >> newMeasurer [ 

	^ ToBarFlowLayoutMeasurer for: self
]

{ #category : #accessing }
ToBarFlowLayout >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #accessing }
ToBarFlowLayout >> uniformNodeWidth: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeWidth := aBoolean
]
