Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement',
		'selectionOption',
		'nodeContainers',
		'precomputedBounds'
	],
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

{ #category : #comparing }
ToListSelectionElement >> equals: other [

	self class = other class ifFalse: [ ^ false ].
	listElement = other listElement ifFalse: [ ^ false ].
	selectionOption = other selectionOption ifFalse: [ ^ false ].
	nodeContainers = other nodeContainers ifFalse: [ ^ false ].
	precomputedBounds = other precomputedBounds ifFalse: [ ^ false ].
	^ true
]

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self focusability: BlFocusability ignore.
	" must prevent mouse events for the scrolling events "
	self preventMouseEvents.
	self outskirts: BlOutskirts inside
]

{ #category : #accessing }
ToListSelectionElement >> isBeneath [

	^ selectionOption isBeneath
]

{ #category : #'focus testing' }
ToListSelectionElement >> isFocusable [
	" a selection element can't have the focus "

	^ false
]

{ #category : #accessing }
ToListSelectionElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListSelectionElement >> nodeContainer [

	^ nodeContainers first
]

{ #category : #accessing }
ToListSelectionElement >> nodeContainers [

	^ nodeContainers
]

{ #category : #accessing }
ToListSelectionElement >> nodeContainers: aNodeContainerArray listElement: aListElement [

	| bnds |
	nodeContainers := aNodeContainerArray.
	listElement := aListElement.
	bnds := self precomputedBoundsIn: aListElement.
	self position: bnds origin.
	self extent: bnds extent
]

{ #category : #private }
ToListSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint 
]

{ #category : #accessing }
ToListSelectionElement >> precomputedBounds [

	^ precomputedBounds
]

{ #category : #accessing }
ToListSelectionElement >> precomputedBoundsIn: aListElement [

	^ precomputedBounds ifNil: [
		  precomputedBounds := self boundsInListElement: aListElement ]
]

{ #category : #accessing }
ToListSelectionElement >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToListSelectionElement >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]

{ #category : #private }
ToListSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ aPoint
]
