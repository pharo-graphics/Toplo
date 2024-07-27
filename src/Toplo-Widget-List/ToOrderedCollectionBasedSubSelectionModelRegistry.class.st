Class {
	#name : #ToOrderedCollectionBasedSubSelectionModelRegistry,
	#superclass : #ToSubSelectionModelRegistry,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToOrderedCollectionBasedSubSelectionModelRegistry >> newSubSelectionModelRegistry [

	^ OrderedCollection new
]

{ #category : #copying }
ToOrderedCollectionBasedSubSelectionModelRegistry >> postCopy [

	| nSubs |
	super postCopy.
	nSubs := subs collect: [ :sm | sm copy ].
	subs := nSubs
]

{ #category : #accessing }
ToOrderedCollectionBasedSubSelectionModelRegistry >> recordSubSelectionModel: aSelectionModel [

	subs add: aSelectionModel
]

{ #category : #enumerating }
ToOrderedCollectionBasedSubSelectionModelRegistry >> selectionModelsDo: aBlock [

	subs do: aBlock
]

{ #category : #accessing }
ToOrderedCollectionBasedSubSelectionModelRegistry >> subSelectionModelWithId: anUniqueId [

	^ subs detect: [ :sm | sm uniqueId = anUniqueId ] ifNone: [  ]
]

{ #category : #accessing }
ToOrderedCollectionBasedSubSelectionModelRegistry >> unrecordSubSelectionModel: aSelectionModel [

	subs remove: aSelectionModel
]
