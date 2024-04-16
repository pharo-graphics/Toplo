Class {
	#name : #ToPrimarySelecter,
	#superclass : #ToCompositeSelecter,
	#instVars : [
		'subSelecterIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToPrimarySelecter >> initialize [ 

	super initialize.
	subSelecterIndex := IdentityDictionary new
]

{ #category : #'instance creation' }
ToPrimarySelecter >> newOperator [
	
	^ ToPrimarySelectionModelOperator new
]

{ #category : #'instance creation' }
ToPrimarySelecter >> newSelectionModelInElement: anElement [

	^ anElement newPrimarySelectionModel
]

{ #category : #accessing }
ToPrimarySelecter >> recordSubSelecter: aSelecter [

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

{ #category : #accessing }
ToPrimarySelecter >> subSelecterIndex [

	^ subSelecterIndex
]

{ #category : #accessing }
ToPrimarySelecter >> unrecordSubSelecter: aSelecter [

	aSelecter ifNil: [ ^ self ].
	subSelecterIndex removeKey:	aSelecter uniqueId.
	self selectionModel unrecordSubSelectionModel: aSelecter selectionModel
]
