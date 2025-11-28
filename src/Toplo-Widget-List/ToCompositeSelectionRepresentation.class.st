Class {
	#name : #ToCompositeSelectionRepresentation,
	#superclass : #ToSelectionRepresentation,
	#instVars : [
		'representations'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToCompositeSelectionRepresentation >> = other [

	super = other ifFalse: [ ^ false ].
	^ representations = other representations
]

{ #category : #comparing }
ToCompositeSelectionRepresentation >> hash [

	^ super hash bitXor: representations hash
]

{ #category : #initialization }
ToCompositeSelectionRepresentation >> initialize [

	super initialize.
	representations := #(  )
]

{ #category : #testing }
ToCompositeSelectionRepresentation >> isComposite [ 

	^ true
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> nodeContainers [

	^ Array streamContents: [ :stream |
		  representations do: [ :r | stream nextPutAll: r nodeContainers ] ]
]

{ #category : #removing }
ToCompositeSelectionRepresentation >> onRemovedFromListElement: aListElement [

	representations do: [ :rep |
		rep onRemovedFromListElement: aListElement ]
]

{ #category : #'private - selection element' }
ToCompositeSelectionRepresentation >> refreshSelectionElementIn: aListElement option: aListSelectionRepresentationOption [

	representations do: [ :rep |
		rep refreshSelectionElementIn: aListElement option: aListSelectionRepresentationOption ]
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> representations [

	^ representations
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> representations: anArray [

	representations := anArray
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> selectionBounds [

	^ Rectangle merging:
		  (representations collect: [ :g | g selectionBounds ])
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> selectionElement [

	^ representations first selectionElement
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> selectionElements [

	^ Array streamContents: [ :stream |
		  representations do: [ :rep |
			  stream nextPutAll: rep selectionElements ] ]
]
