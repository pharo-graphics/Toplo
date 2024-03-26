Class {
	#name : #ToDisabledSelectionModelSelecter,
	#superclass : #ToAdditionalSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToDisabledSelectionModelSelecter >> eventClass [

	^ ToListDisabledSelectionChangedEvent
]

{ #category : #'api - hooks' }
ToDisabledSelectionModelSelecter >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	aListElement selectionModel disabledSelectionModel: selectionModel
]

{ #category : #'api - hooks' }
ToDisabledSelectionModelSelecter >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	aListElement selectionModel disabledSelectionModel: nil
]
