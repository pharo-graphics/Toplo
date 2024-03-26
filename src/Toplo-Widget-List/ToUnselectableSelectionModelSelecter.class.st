Class {
	#name : #ToUnselectableSelectionModelSelecter,
	#superclass : #ToAdditionalSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToUnselectableSelectionModelSelecter >> eventClass [

	^ ToListUnselectableSelectionChangedEvent
]

{ #category : #accessing }
ToUnselectableSelectionModelSelecter >> uniqueId [

	^ #unselectable
]
