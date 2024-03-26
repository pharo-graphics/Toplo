Class {
	#name : #ToListPrimarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#instVars : [
		'additionalSelectionModels',
		'disabledSelectionModel',
		'hiddenSelectionModel',
		'unselectableSelectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListPrimarySelectionModel >> additionalSelectionModels [

	^ additionalSelectionModels
]

{ #category : #accessing }
ToListPrimarySelectionModel >> disabledSelectionModel [

	^ disabledSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> disabledSelectionModel: aSelectionModel [

	disabledSelectionModel := aSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> hiddenSelectionModel [

	^ hiddenSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> hiddenSelectionModel: aSelectionModel [

	hiddenSelectionModel := aSelectionModel
]

{ #category : #initialization }
ToListPrimarySelectionModel >> initialize [

	super initialize.
	additionalSelectionModels := #(  )
]

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	disabledSelectionModel := nil.
	hiddenSelectionModel := nil.
	unselectableSelectionModel := nil.
	additionalSelectionModels := nil
]

{ #category : #accessing }
ToListPrimarySelectionModel >> unselectableSelectionModel [

	^ unselectableSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> unselectableSelectionModel: aSelectionModel [

	unselectableSelectionModel := aSelectionModel
]
