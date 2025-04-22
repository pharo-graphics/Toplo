Class {
	#name : #ToTabNode,
	#superclass : #ToCheckableNode,
	#traits : 'TToRemovableNode',
	#classTraits : 'TToRemovableNode classTrait',
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabNode >> applyWidgetConfiguration [ 

	super applyWidgetConfiguration.
	self removeRemoveButton.
	self isRemovable
		ifTrue: [ self addRemoveButton ].
	self requestNewSkin 
]

{ #category : #'t - bar node' }
ToTabNode >> listElementReferenceBoundsInSpace [

	|  list |
	list := self holder listElement.
	^ list bounds inSpace
]

{ #category : #skin }
ToTabNode >> newRawSkin [ 

	^ ToTabNodeSkin new
]
