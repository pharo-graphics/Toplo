Class {
	#name : #ToListSelectionWithElementVariant,
	#superclass : #ToListSelectionRepresentationVariant,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToListSelectionWithElementVariant >> addSelectionElementsIn: aListElement [

	| selectionElements |
	self isMasked ifTrue: [ ^ self ].
	selectionElements := Array new: 50 streamContents: [ :stream |
			                     representation
				                     stream: stream
				                     withNewSelectionElementIn: aListElement
				                     option: self ].
	selectionElements isEmpty ifTrue: [ ^ self ].
	self updateSelectionContainerWith: selectionElements in: aListElement
]

{ #category : #testing }
ToListSelectionWithElementVariant >> isAnimated [

	^ selectionOption isAnimated 
]

{ #category : #accessing }
ToListSelectionWithElementVariant >> isBeneath [

	^ selectionOption isBeneath 
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementVariant >> newSelectionElementIn: aListElement forNodeContainers: aNodeContainerArray [

	^ selectionOption elementFactory value
		  nodeContainers: aNodeContainerArray listElement: aListElement;
		  selectionOption: self;
		  yourself
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementVariant >> updateSelectionContainerWith: anArray in: aListElement [
	" add new selection with animation if possible. 
	Pay attention, an animation can be used. In case of animation, the SelectedSkinEvent is sent only when the animation ends to have a nice visual effect. If no animation is used, then SelectedSkinEvent is sent just after the selection is added "

	self notifyNodesSelectedIn: aListElement.
	self selectionContainer addAllSelectionElements: anArray.

]

{ #category : #'private - selection updating' }
ToListSelectionWithElementVariant >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	super
		updateSelectionIn: aListElement
		withSelectionModel: aSelectionModel.
	representationChanged ifFalse: [ ^ self ].
	self addSelectionElementsIn: aListElement
]
