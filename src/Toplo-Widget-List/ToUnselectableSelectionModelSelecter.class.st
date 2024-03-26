Class {
	#name : #ToUnselectableSelectionModelSelecter,
	#superclass : #ToPredefinedAdditionalSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToUnselectableSelectionModelSelecter >> eventClass [

	^ ToListUnselectableSelectionChangedEvent
]

{ #category : #'api - hooks' }
ToUnselectableSelectionModelSelecter >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	aListElement selectionModel unselectableSelectionModel: selectionModel
]

{ #category : #'api - hooks' }
ToUnselectableSelectionModelSelecter >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	aListElement selectionModel unselectableSelectionModel: nil
]
