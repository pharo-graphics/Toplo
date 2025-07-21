Class {
	#name : #ToCheckableListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item bar element - accessing' }
ToCheckableListElement >> defaultNodeManagerClass [ 

	^ ToCheckableListNodeManager
]

{ #category : #initialization }
ToCheckableListElement >> initialize [ 

	super initialize.
	
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.

	self primarySelectionMode makeDisabledUnselectable: true
]
