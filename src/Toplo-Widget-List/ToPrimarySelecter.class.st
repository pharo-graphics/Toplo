Class {
	#name : #ToPrimarySelecter,
	#superclass : #ToCompositeSelecter,
	#instVars : [
		'subSelecterIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'command application' }
ToPrimarySelecter >> commandApplied: aCommand [

	| req |
	eventTarget dispatchEvent:
		(ToPrimarySelectionCommandAppliedEvent new
			 command: aCommand;
			 yourself).


	req := ToListPrimarySelectionChangeRequestEvent new
		       requestedAction: [
			       eventTarget dispatchEvent:
					       (ToListPrimarySelectionChangedEvent new
						        selectionModel: aCommand selectionModel;
						        yourself) ];
		       yourself.

	eventTarget dispatchAuthorisationRequest: req
]

{ #category : #initialization }
ToPrimarySelecter >> initialize [ 

	super initialize.
	subSelecterIndex := IdentityDictionary new
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
