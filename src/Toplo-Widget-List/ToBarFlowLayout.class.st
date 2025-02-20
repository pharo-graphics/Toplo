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

{ #category : #accessing }
ToBarFlowLayout >> hasUniformNodeHeight [

	^ uniformNodeHeight 
]

{ #category : #accessing }
ToBarFlowLayout >> hasUniformNodeHeight: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeHeight := aBoolean
]

{ #category : #accessing }
ToBarFlowLayout >> hasUniformNodeWidth [

	^ uniformNodeWidth 
]

{ #category : #accessing }
ToBarFlowLayout >> hasUniformNodeWidth: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeWidth := aBoolean
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
