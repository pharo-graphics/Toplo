Class {
	#name : #ToCompositeSelecter,
	#superclass : #ToListSelecter,
	#instVars : [
		'subSelecterIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToCompositeSelecter >> initialize [ 

	super initialize.
	subSelecterIndex := IdentityDictionary new
]

{ #category : #accessing }
ToCompositeSelecter >> recordSubSelecter: aSelecter [

	subSelecterIndex 
		at: aSelecter selectionChangedEventClass
		ifPresent: [
		Error signal: 'A selecter for the same selection already exists' ].
	subSelecterIndex
		at: aSelecter selectionChangedEventClass
		put: aSelecter.
	self selectionModel recordSubSelectionModel: aSelecter selectionModel
]

{ #category : #operations }
ToCompositeSelecter >> shiftSelection: anInteger from: anIndex [

	super shiftSelection: anInteger from: anIndex.
	subSelecterIndex valuesDo: [ :s |
		s shiftSelection: anInteger from: anIndex ]
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterIndex [

	^ subSelecterIndex
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterWithEventClass: anUniqueId [

	^ subSelecterIndex  at: anUniqueId ifAbsent: [  ]
]

{ #category : #accessing }
ToCompositeSelecter >> unrecordSubSelecter: aSelecter [

	aSelecter ifNil: [ ^ self ].
	subSelecterIndex removeKey:	aSelecter selectionChangedEventClass.
	self selectionModel unrecordSubSelectionModel: aSelecter selectionModel
]

{ #category : #operations }
ToCompositeSelecter >> updateSelectionAfter: aValuable withDataAccessor: aDataAccessor [

	| selectionIndex |
	" a dictionary to store the selected item collection (value) of each selecter (key)"
	selectionIndex := IdentityDictionary new.

	" save selected data items for each sub-selecter "
	subSelecterIndex valuesDo: [ :subselecter |
			| selection |
			selection := subselecter selectedIndexes collect: [ :idx |
				             aDataAccessor at: idx ].
			selectionIndex at: subselecter put: selection ].

	super updateSelectionAfter: aValuable withDataAccessor: aDataAccessor.

	" select back the selected items"
	selectionIndex keysAndValuesDo: [ :subselecter :selection |
			subselecter selectOnlyIndexes:
				(selection collect: [ :dataItem | aDataAccessor indexOf: dataItem ]) ]
]
