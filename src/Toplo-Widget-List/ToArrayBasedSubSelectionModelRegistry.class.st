Class {
	#name : #ToArrayBasedSubSelectionModelRegistry,
	#superclass : #ToSubSelectionModelRegistry,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToArrayBasedSubSelectionModelRegistry >> newSubSelectionModelRegistry [

	^ Array new
]

{ #category : #copying }
ToArrayBasedSubSelectionModelRegistry >> postCopy [ 

	| nSubs |
	super postCopy.
	nSubs := subs copy.
	subs withIndexDo: [ :value :index |
		nSubs at: index put: value copy ].
	subs := nSubs
]

{ #category : #accessing }
ToArrayBasedSubSelectionModelRegistry >> recordSubSelectionModel: aSelectionModel [

	subs := subs copyWith: aSelectionModel
]

{ #category : #enumerating }
ToArrayBasedSubSelectionModelRegistry >> selectionModelsDo: aBlock [

	subs do: aBlock
]

{ #category : #accessing }
ToArrayBasedSubSelectionModelRegistry >> subSelectionModelWithId: anUniqueId [

	^ subs detect: [ :sm | sm uniqueId = anUniqueId ] ifNone: [  ]
]

{ #category : #accessing }
ToArrayBasedSubSelectionModelRegistry >> unrecordSubSelectionModel: aSelectionModel [

	subs := subs copyWithout: aSelectionModel
]
