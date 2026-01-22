Class {
	#name : #ToCompositeSelectionRepresentation,
	#superclass : #ToSelectionRepresentation,
	#instVars : [
		'representations'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToCompositeSelectionRepresentation >> equivalentTo: other [

	(super equivalentTo: other) ifFalse: [ ^ false ].
	representations size = other representations size ifFalse: [ ^ false ].
	representations
		with: other representations
		do: [ :r1 :r2 | (r1 equivalentTo: r2) ifFalse: [ ^ false ] ].
	^ true
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
