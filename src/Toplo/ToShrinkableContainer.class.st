Class {
	#name : #ToShrinkableContainer,
	#superclass : #ToElement,
	#traits : 'TToShrinkable',
	#classTraits : 'TToShrinkable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #configuration }
ToShrinkableContainer >> applyWidgetConfiguration [ 

	super applyWidgetConfiguration.
	self applyShrinkableConfiguration 
]

{ #category : #'hooks - children' }
ToShrinkableContainer >> onChildAdded: anElement [

	super onChildAdded: anElement.
	self firstChild = anElement ifFalse: [ ^ self ].
	self shrinkFeedbackLayer ifNil: [ ^ self ].
	self shrinkFeedbackLayer shrinked: anElement
]

{ #category : #'children dispatching' }
ToShrinkableContainer >> onChildToBeRemoved: anElement [ 

	super onChildToBeRemoved: anElement.
	self shrinkFeedbackLayer ifNil: [ ^ self ].
	self shrinkFeedbackLayer shrinked = anElement ifFalse: [ ^ self ].
	self shrinkFeedbackLayer shrinked: nil
]
