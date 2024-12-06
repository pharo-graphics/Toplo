Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement',
		'selectionOption',
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	" let install the skin immediately to speed-up selection updating "
	self applySkinInstallerOnFirstRequest: true.
	" a selection element can't have the focus "
	self focusability: BlFocusability none.
	" must prevent mouse events for the scrolling events "
	self preventMouseEvents 
]

{ #category : #accessing }
ToListSelectionElement >> isBeneath [

	^ selectionOption isBeneath
]

{ #category : #accessing }
ToListSelectionElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListSelectionElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToListSelectionElement >> nodes [

	^ nodes
]

{ #category : #accessing }
ToListSelectionElement >> nodes: aNodeArray [

	nodes := aNodeArray
]

{ #category : #private }
ToListSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint
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
