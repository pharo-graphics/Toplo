Trait {
	#name : #TToCheckableListElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
TToCheckableListElement >> initializeAsCheckableListElement [
	
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self addEventHandler: ToCheckableListElementEventHandler new.
	self selectionOption withEmbeddedRepresentation.
	
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: true.

	self primarySelectionMode makeDisabledUnselectable: true
]
