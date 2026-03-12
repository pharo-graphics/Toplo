Trait {
	#name : #TToCheckableListElement,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
TToCheckableListElement >> initializeAsCheckableListElement [
	
	self addEventHandler: ToCheckableListElementEventHandler new.
	
	self selectionOption withEmbeddedRepresentation.
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: true.

	self selectionMode multiple: false.
	self selectionMode makeDisabledUnselectable: true
]
