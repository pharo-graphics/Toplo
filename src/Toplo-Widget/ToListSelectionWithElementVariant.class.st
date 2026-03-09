Class {
	#name : #ToListSelectionWithElementVariant,
	#superclass : #ToListSelectionRepresentationVariant,
	#category : #'Toplo-Widget-List'
}

{ #category : #'private - selection updating' }
ToListSelectionWithElementVariant >> addSelectionElementsIn: aListElement [

	| selectionElements |
	selectionElements := Array new: 40 streamContents: [ :stream |
			                     representation
				                     stream: stream
				                     withNewSelectionElementIn: aListElement
				                     option: self ].
	self updateSelectionContainerWith: selectionElements in: aListElement
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementVariant >> checkSelectionContainerIn: aListElement [

	selectionOption addSelectionContainerIn: aListElement
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
ToListSelectionWithElementVariant >> updateRepresentationIn: aListElement [

	super updateRepresentationIn: aListElement.
	self addSelectionElementsIn: aListElement
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementVariant >> updateSelectionContainerWith: anArray in: aListElement [
	" add new selection with animation if possible. 
	Pay attention, an animation can be used. In case of animation, the SelectedSkinEvent is sent only when the animation ends to have a nice visual effect. If no animation is used, then SelectedSkinEvent is sent just after the selection is added "

	self isAnimated ifFalse: [ self notifyNodesSelectedIn: aListElement ].
	self selectionContainer addAllSelectionElements: anArray
]
