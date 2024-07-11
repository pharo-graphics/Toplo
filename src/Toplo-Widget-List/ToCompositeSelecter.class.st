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

	aSelecter ifNil: [ ^ self ].
	subSelecterIndex 
		at: aSelecter uniqueId
		ifPresent: [
		Error signal: 'A selecter with the same id already exists' ].
	subSelecterIndex
		at: aSelecter uniqueId
		put: aSelecter.
	self selectionModel recordSubSelectionModel: aSelecter selectionModel
]

{ #category : #operations }
ToCompositeSelecter >> shiftSelection: anInteger from: anIndex [

	(anInteger < 0 and: [ self itemCount >= anIndex ]) ifTrue: [
		| count |
		count := anInteger abs.
		self deselectIndex: anIndex to: anIndex + count - 1 ].
	" must send to super ** here ** to deselect the right index if needed "
	super shiftSelection: anInteger from: anIndex.
	subSelecterIndex valuesDo: [ :s |
		s shiftSelection: anInteger from: anIndex ]
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterIndex [

	^ subSelecterIndex
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterWithId: anUniqueId [

	^ subSelecterIndex  at: anUniqueId ifAbsent: [  ]
]

{ #category : #accessing }
ToCompositeSelecter >> unrecordSubSelecter: aSelecter [

	aSelecter ifNil: [ ^ self ].
	subSelecterIndex removeKey:	aSelecter uniqueId.
	self selectionModel unrecordSubSelectionModel: aSelecter selectionModel
]
