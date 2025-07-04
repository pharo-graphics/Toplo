Class {
	#name : #ToCheckableNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core-Item'
}

{ #category : #'event handling' }
ToCheckableNodeSelectionEventHandler >> clickEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryClickEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'api - accessing' }
ToCheckableNodeSelectionEventHandler >> eventsToHandle [

	^ { BlPrimaryClickEvent }
]

{ #category : #'event handling' }
ToCheckableNodeSelectionEventHandler >> primaryClickEvent: anEvent [

	| node |
	" I'm an handler for a checkableNode which contains an item which is a checkable.
	The item has its own handler to switch its check state.
	A click event can bubble from the checkable item or directly from my checkableNode.
	If the click event bubbles from the item, then do nothing.
	Instread if the event comes directly from the node then it has to be dispatched down to its item "
	anEvent target = anEvent currentTarget ifFalse: [ ^ self ].
	node := anEvent currentTarget.
	node item dispatchEvent: anEvent copy

]
