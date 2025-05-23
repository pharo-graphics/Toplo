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
