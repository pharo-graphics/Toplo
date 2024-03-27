Class {
	#name : #ToDisabledSelecter,
	#superclass : #ToAdditionalSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToDisabledSelecter >> initialize [ 

	super initialize.
	self eventClass: ToListDisabledSelectionChangedEvent.
	self uniqueId: #disabled
	
]
