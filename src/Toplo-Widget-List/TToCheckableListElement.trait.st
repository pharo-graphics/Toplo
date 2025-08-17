Trait {
	#name : #TToCheckableListElement,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
TToCheckableListElement >> initializeAsCheckableListElement [
	
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self addEventHandler: ToCheckableBarElementEventHandler new.

	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.

	self primarySelectionMode makeDisabledUnselectable: true
]
