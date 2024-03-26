Class {
	#name : #ToHiddenSelectionModelSelecter,
	#superclass : #ToAdditionalSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToHiddenSelectionModelSelecter >> eventClass [

	^ ToListHiddenSelectionChangedEvent
]

{ #category : #'api - hooks' }
ToHiddenSelectionModelSelecter >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	aListElement selectionModel hiddenSelectionModel: selectionModel
]

{ #category : #'api - hooks' }
ToHiddenSelectionModelSelecter >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	aListElement selectionModel hiddenSelectionModel: nil
]
