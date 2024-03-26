Class {
	#name : #ToListSecondarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListSecondarySelectionModel >> dependentSelectionModelIndex [

	^ self primarySelectionModel dependentSelectionModelIndex
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
	listElement := aListElement.
]

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	listElement := nil
]

{ #category : #accessing }
ToListSecondarySelectionModel >> primarySelectionModel [

	^ listElement selectionModel
]

{ #category : #accessing }
ToListSecondarySelectionModel >> uniqueId [

	^ #secondary
]

{ #category : #accessing }
ToListSecondarySelectionModel >> unselectableSelectionModel [

	^ self primarySelectionModel unselectableSelectionModel
]
