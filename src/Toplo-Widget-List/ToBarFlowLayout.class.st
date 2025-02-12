Class {
	#name : #ToBarFlowLayout,
	#superclass : #BlFlowLayout,
	#instVars : [
		'uniformNodeWidth',
		'uniformNodeHeight',
		'minNodeHeight',
		'minNodeWidth'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #comparing }
ToBarFlowLayout >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	self uniformNodeWidth = anObject uniformNodeWidth ifFalse: [ ^ false ].
	self uniformNodeHeight = anObject uniformNodeHeight ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
ToBarFlowLayout >> hash [

	^ (super hash bitXor: self uniformNodeWidth hash) bitXor:
		  self uniformNodeHeight
]

{ #category : #initialization }
ToBarFlowLayout >> initialize [ 

	super initialize.
	uniformNodeWidth := false.
	uniformNodeHeight := false
]

{ #category : #accessing }
ToBarFlowLayout >> minNodeHeight [

	^ minNodeHeight
]

{ #category : #accessing }
ToBarFlowLayout >> minNodeHeight: aNumber [

	minNodeHeight := aNumber
]

{ #category : #accessing }
ToBarFlowLayout >> minNodeWidth [

	^ minNodeWidth
]

{ #category : #accessing }
ToBarFlowLayout >> minNodeWidth: aNumber [

	minNodeWidth := aNumber
]

{ #category : #initialization }
ToBarFlowLayout >> newMeasurer [ 

	^ ToBarFlowLayoutMeasurer for: self
]

{ #category : #accessing }
ToBarFlowLayout >> uniformNodeHeight [

	^ uniformNodeHeight 
]

{ #category : #accessing }
ToBarFlowLayout >> uniformNodeHeight: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeHeight := aBoolean
]

{ #category : #accessing }
ToBarFlowLayout >> uniformNodeWidth [

	^ uniformNodeWidth 
]

{ #category : #accessing }
ToBarFlowLayout >> uniformNodeWidth: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeWidth := aBoolean
]
