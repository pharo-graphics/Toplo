Class {
	#name : #ToSelectionGroup,
	#superclass : #Object,
	#instVars : [
		'option',
		'cachedSelectionElement',
		'preComputedBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection element' }
ToSelectionGroup >> boundsFromNodesIn: aListElement [
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
			w := aListElement innerContainer bounds width.
			corner := w @ endBnds corner y ]
		ifFalse: [ corner := endBnds corner ].

	^ (BlBounds origin: startBnds origin corner: corner)
]

{ #category : #'private - selection element' }
ToSelectionGroup >> boundsOfNode: aNode in: aListElement [
	" compute local node bounds "
	^ (aNode measuredBounds inSpace inChild: aListElement innerContainer) bounds
]

{ #category : #'private - selection element' }
ToSelectionGroup >> computeSelectionElementBoundsIn: aListElement [

	preComputedBounds := self boundsFromNodesIn: aListElement
]

{ #category : #'private - selection element' }
ToSelectionGroup >> createSelectionElementIn: aListElement [

	cachedSelectionElement := option newSelectionElementFor: aListElement.
	self computeSelectionElementBoundsIn: aListElement
]

{ #category : #accessing }
ToSelectionGroup >> nodes [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectionGroup >> option: aSelectionOption [

	option := aSelectionOption
]

{ #category : #accessing }
ToSelectionGroup >> preComputedBounds [

	^ preComputedBounds  
]

{ #category : #'private - selection element' }
ToSelectionGroup >> refreshSelectionElementIn: aListElement [

	cachedSelectionElement ifNil: [
		self createSelectionElementIn: aListElement.
		^ self ].
	self computeSelectionElementBoundsIn: aListElement.
	cachedSelectionElement := self updatedSelectionElementIn: aListElement
]

{ #category : #'private - selection element' }
ToSelectionGroup >> removeSelectionElementIn: aListElement [

	cachedSelectionElement ifNil: [  ^ self ].
	cachedSelectionElement removeFromParent.
	cachedSelectionElement := nil.
	preComputedBounds := nil
]

{ #category : #accessing }
ToSelectionGroup >> selectionElement [

	^ cachedSelectionElement 
]

{ #category : #accessing }
ToSelectionGroup >> updatedSelectionElementIn: aListElement [

	cachedSelectionElement position: (cachedSelectionElement
			 positionFrom: preComputedBounds origin
			 in: aListElement).
	cachedSelectionElement size: (cachedSelectionElement
			 sizeFrom: preComputedBounds extent
			 in: aListElement).
	^ cachedSelectionElement
]
