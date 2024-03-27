Class {
	#name : #ToUnselectableSelecter,
	#superclass : #ToAdditionalSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToUnselectableSelecter >> initialize [ 

	super initialize.
	self eventClass: ToListUnselectableSelectionChangedEvent.
	self uniqueId: #unselectable
	
]
