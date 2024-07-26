Class {
	#name : #ToDictionaryBasedSubSelectionModelRegistry,
	#superclass : #ToSubSelectionModelRegistry,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToDictionaryBasedSubSelectionModelRegistry >> newSubSelectionModelRegistry [

	^ IdentityDictionary new
]

{ #category : #copying }
ToDictionaryBasedSubSelectionModelRegistry >> postCopy [ 

	| nSubs |
	super postCopy.
	nSubs := subs copy.
	subs keysAndValuesDo: [ :key :value |
		nSubs at: key put: value copy ].
	subs release.
	subs := nSubs
]

{ #category : #accessing }
ToDictionaryBasedSubSelectionModelRegistry >> recordSubSelectionModel: aSelectionModel [

	subs at: aSelectionModel uniqueId put: aSelectionModel
]

{ #category : #enumerating }
ToDictionaryBasedSubSelectionModelRegistry >> selectionModelsDo: aBlock [

	subs valuesDo: aBlock
]

{ #category : #accessing }
ToDictionaryBasedSubSelectionModelRegistry >> subSelectionModelWithId: anUniqueId [

	^ subs at: anUniqueId ifAbsent: [  ]
]

{ #category : #accessing }
ToDictionaryBasedSubSelectionModelRegistry >> unrecordSubSelectionModel: aSelectionModel [

	subs removeKey: aSelectionModel uniqueId
]
