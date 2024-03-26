Class {
	#name : #ToDisabledSelectionModelSelecter,
	#superclass : #ToAdditionalSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToDisabledSelectionModelSelecter >> eventClass [

	^ ToListDisabledSelectionChangedEvent
]

{ #category : #accessing }
ToDisabledSelectionModelSelecter >> uniqueId [

	^ #disabled
]
