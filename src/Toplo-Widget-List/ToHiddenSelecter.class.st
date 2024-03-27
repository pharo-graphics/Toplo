Class {
	#name : #ToHiddenSelecter,
	#superclass : #ToAdditionalSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToHiddenSelecter >> initialize [ 

	super initialize.
	self eventClass: ToListHiddenSelectionChangedEvent.
	self uniqueId: #hidden
	
]
