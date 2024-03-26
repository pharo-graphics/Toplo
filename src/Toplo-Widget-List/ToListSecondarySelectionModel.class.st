Class {
	#name : #ToListSecondarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#instVars : [
		'primarySelectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListSecondarySelectionModel >> additionalDependentSelectionModels [

	^ self primarySelectionModel additionalDependentSelectionModels
]

{ #category : #accessing }
ToListSecondarySelectionModel >> disabledSelectionModel [

	^ self primarySelectionModel disabledSelectionModel
]

{ #category : #accessing }
ToListSecondarySelectionModel >> hiddenSelectionModel [

	^ self primarySelectionModel hiddenSelectionModel
]

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	primarySelectionModel := aListElement selectionModel.
]

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	primarySelectionModel := nil
]

{ #category : #accessing }
ToListSecondarySelectionModel >> primarySelectionModel [

	^ primarySelectionModel
]

{ #category : #accessing }
ToListSecondarySelectionModel >> primarySelectionModel: aSelectionModel [

	primarySelectionModel := aSelectionModel
]

{ #category : #accessing }
ToListSecondarySelectionModel >> uniqueId [

	^ #secondary
]

{ #category : #accessing }
ToListSecondarySelectionModel >> unselectableSelectionModel [

	^ self primarySelectionModel unselectableSelectionModel
]
