Class {
	#name : #ToShrinkableContainer,
	#superclass : #ToElement,
	#traits : 'TToShrinkable',
	#classTraits : 'TToShrinkable classTrait',
	#category : #'Toplo-Core-Overlay'
}

{ #category : #configuration }
ToShrinkableContainer >> applyUpwardConfiguration [ 

	super applyUpwardConfiguration.
	self applyShrinkableConfiguration 
]

{ #category : #'hooks - children' }
ToShrinkableContainer >> onChildAdded: anElement [

	super onChildAdded: anElement.
	self requestConfiguration 
]

{ #category : #'children dispatching' }
ToShrinkableContainer >> onChildToBeRemoved: anElement [ 

	super onChildToBeRemoved: anElement.
	self shrinkFeedbackLayer ifNil: [ ^ self ].
	self shrinkFeedbackLayer shrinked = anElement ifFalse: [ ^ self ].
	self shrinkFeedbackLayer shrinked: nil.
	self requestConfiguration 
]
