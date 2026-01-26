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
		  representations do: [ :r | stream nextPut: r nodeContainers ] ]
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> representations [

	^ representations
]

{ #category : #accessing }
ToCompositeSelectionRepresentation >> representations: anArray [

	representations := anArray
]

{ #category : #'private - selection updating' }
ToCompositeSelectionRepresentation >> stream: aStream withNewSelectionElementIn: aListElement option: aSelectionOption [

	representations do: [ :rep |
			rep
				stream: aStream
				withNewSelectionElementIn: aListElement
				option: aSelectionOption ]
]
