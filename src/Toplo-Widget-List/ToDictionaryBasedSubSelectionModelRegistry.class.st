Class {
	#name : #ToDictionaryBasedSubSelectionModelRegistry,
	#superclass : #ToSubSelectionModelRegistry,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #copying }
ToDictionaryBasedSubSelectionModelRegistry >> copySelectionFrom: otherRegistry [

	self subModelKeys = otherRegistry subModelKeys ifFalse: [ Error new signal: '' ].
	subs keysAndValuesDo: [ :k :v | v copySelectionFrom: (otherRegistry subSelectionModelWithId: k) ]
]

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
ToDictionaryBasedSubSelectionModelRegistry >> subModelKeys [

	^ subs keys
]

{ #category : #accessing }
ToDictionaryBasedSubSelectionModelRegistry >> subSelectionModelWithId: anUniqueId [

	^ subs at: anUniqueId ifAbsent: [  ]
]

{ #category : #accessing }
ToDictionaryBasedSubSelectionModelRegistry >> unrecordSubSelectionModel: aSelectionModel [

	subs removeKey: aSelectionModel uniqueId
]
