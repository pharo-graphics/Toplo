Trait {
	#name : #TToBarNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - bar node' }
TToBarNode >> initializeAsBarNode [

	self matchParent.
	self addEventHandlerOn: ToRemoveButtonClickedEvent do: [ :event |
			| target listElement |
			" since the event is fired, on should stop it dispatching here "
			event consume.
			target := event currentTarget.
			listElement := target holder listElement.
			target removeFromBar.
			" Now the mouse move should be replayed because the mouse can be over the same remove button after the removal. It is postponed to let the node be re-built and configured before replaying "
			listElement postponeAction: [ :l | l requestMouseMoveReplay ] ]
]

{ #category : #'t - bar node' }
TToBarNode >> removeFromBar [

	self holder removeNodeFromBar 
]
