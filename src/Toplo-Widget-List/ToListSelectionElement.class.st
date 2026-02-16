Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#traits : 'TToListSelectionElement',
	#classTraits : 'TToListSelectionElement classTrait',
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'private - selection element' }
ToListSelectionElement >> boundsInListElement: aListElement [

	| first last startBnds endBnds corner containers |
	containers := self nodeContainers.
	first := containers first.
	last := containers last.
	startBnds := (first measuredBounds inSpace inChild:
		              aListElement innerElement) bounds.
	endBnds := first = last
		           ifTrue: [ startBnds ]
		           ifFalse: [
				           (last measuredBounds inSpace inChild:
					            aListElement innerElement) bounds ].
	(aListElement isVertical and: [
		 first constraints horizontal isMatchParent ])
		ifTrue: [
				| w |
				w := aListElement innerElement bounds width.
				corner := w @ endBnds corner y ]
		ifFalse: [ corner := endBnds corner ].

	^ Rectangle
		  origin: (self
				   positionFrom:
				   startBnds origin + aListElement innerElement position
				   in: aListElement)
		  extent:
		  (self sizeFrom: corner - startBnds origin in: aListElement)
]

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	self initializeAsListSelectionElement 
]
