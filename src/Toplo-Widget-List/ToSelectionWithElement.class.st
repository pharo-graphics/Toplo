Class {
	#name : #ToSelectionWithElement,
	#superclass : #ToSelectionRepresentation,
	#instVars : [
		'cachedSelectionElement',
		'preComputedBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection element' }
ToSelectionWithElement >> boundsFromNodesIn: aListElement [
	" compute my bounds from my list of adjacent nodes. "

	| first last startBnds endBnds corner myNodes |
	myNodes := self nodes.
	first := myNodes first.
	last := myNodes last.
	startBnds := self boundsOfNode: first in: aListElement.
	endBnds := first = last
		           ifTrue: [ startBnds ]
		           ifFalse: [ self boundsOfNode: last in: aListElement].
	(aListElement isVertical and: [
		 first constraints horizontal isMatchParent ])
		ifTrue: [
			| w |
			w := aListElement innerElement bounds width.
			corner := w @ endBnds corner y ]
		ifFalse: [ corner := endBnds corner ].

	^ (BlBounds origin: startBnds origin corner: corner) asRectangle
]

{ #category : #'private - selection element' }
ToSelectionWithElement >> boundsOfNode: aNode in: aListElement [
	" compute local node bounds "
	^ (aNode measuredBounds inSpace inChild: aListElement innerElement) bounds
]

{ #category : #'private - selection element' }
ToSelectionWithElement >> createSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	cachedSelectionElement := aSelectionRepresentationOption newSelectionElementIn: aListElement.
	cachedSelectionElement nodes: self nodes.
	preComputedBounds := self boundsFromNodesIn: aListElement
]

{ #category : #removing }
ToSelectionWithElement >> onRemovedFromListElement: aListElement [

	cachedSelectionElement ifNil: [  ^ self ].
	cachedSelectionElement removeFromParent.
	cachedSelectionElement := nil.
	preComputedBounds := nil
]

{ #category : #accessing }
ToSelectionWithElement >> preComputedBounds [

	^ preComputedBounds  
]

{ #category : #'private - selection element' }
ToSelectionWithElement >> refreshSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	self
		createSelectionElementIn: aListElement
		option: aSelectionRepresentationOption
]

{ #category : #accessing }
ToSelectionWithElement >> selectionElement [

	^ cachedSelectionElement 
]

{ #category : #accessing }
ToSelectionWithElement >> updatedSelectionElementIn: aListElement [

	cachedSelectionElement position: (cachedSelectionElement
			 positionFrom: preComputedBounds origin
			 in: aListElement).
	cachedSelectionElement size: (cachedSelectionElement
			 sizeFrom: preComputedBounds extent
			 in: aListElement).
	^ cachedSelectionElement
]
