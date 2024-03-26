Class {
	#name : #ToSelectGroupSelectionModelSelecter,
	#superclass : #ToAdditionalSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToSelectGroupSelectionModelSelecter >> eventClass [

	^ ToSelectGroupSelectionChangedEvent
]

{ #category : #accessing }
ToSelectGroupSelectionModelSelecter >> uniqueId [

	^ #group
]
