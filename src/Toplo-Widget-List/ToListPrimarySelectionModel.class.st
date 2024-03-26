Class {
	#name : #ToListPrimarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#instVars : [
		'disabledSelectionModel',
		'hiddenSelectionModel',
		'unselectableSelectionModel',
		'additionalDependentSelectionModels'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListPrimarySelectionModel >> additionalDependentSelectionModels [

	^ additionalDependentSelectionModels
]

{ #category : #accessing }
ToListPrimarySelectionModel >> disabledSelectionModel [

	^ disabledSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> disabledSelectionModel: aSelectionModel [

	disabledSelectionModel := aSelectionModel.
	disabledSelectionModel ifNil: [ ^ self ].
	aSelectionModel uniqueId: #disabled
]

{ #category : #accessing }
ToListPrimarySelectionModel >> hiddenSelectionModel [

	^ hiddenSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> hiddenSelectionModel: aSelectionModel [

	hiddenSelectionModel := aSelectionModel.
	hiddenSelectionModel ifNil: [ ^ self ].
	aSelectionModel uniqueId: #hidden
]

{ #category : #initialization }
ToListPrimarySelectionModel >> initialize [

	super initialize.
	additionalDependentSelectionModels := #(  )
]

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	disabledSelectionModel := nil.
	hiddenSelectionModel := nil.
	unselectableSelectionModel := nil.
	additionalDependentSelectionModels := nil
]

{ #category : #accessing }
ToListPrimarySelectionModel >> uniqueId [

	^ #primary
]

{ #category : #accessing }
ToListPrimarySelectionModel >> unselectableSelectionModel [

	^ unselectableSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> unselectableSelectionModel: aSelectionModel [

	unselectableSelectionModel := aSelectionModel.
	aSelectionModel ifNil: [ ^ self ].
	aSelectionModel uniqueId: #unselectable
]
