Trait {
	#name : #TToListNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - list node' }
TToListNode >> clickEventHandlerClass [

	^ nil
]

{ #category : #'t - list node' }
TToListNode >> flagAsDisabled: aBoolean [

	self holder disabled: aBoolean.
	super flagAsDisabled: aBoolean
]

{ #category : #'t - list node' }
TToListNode >> initializeAsListNode [

	self matchParent.
	self addEventHandlerOn: ToRemoveButtonClickedEvent do: [ :event |
			| target listElement |
			" since the event is fired, on should stop it's dispatching here "
			event consume.
			target := event currentTarget.
			listElement := target holder listElement.
			target removeFromList.
			" Now the mouse move should be replayed because the mouse can be over the same remove button after the removal. It is postponed to let the node be re-built and configured before replaying "
			listElement postponeAction: [ :l | l requestMouseMoveReplay ] ]
]

{ #category : #'t - list node' }
TToListNode >> isFake [

	| list |
	list := self holder listElement.
	^ list fakeNode = self
]

{ #category : #'t - list node' }
TToListNode >> isFirst [

	^ self holder position = 1
]

{ #category : #'t - list node' }
TToListNode >> isLast [

	^ self holder position = self holder dataSource itemCount 
]

{ #category : #'t - list node' }
TToListNode >> isSelected [

	^ self holder isSelected
]

{ #category : #'t - list node' }
TToListNode >> listElementDo: aValuable [

	self holder listElement ifNotNil: [ :le | aValuable value: le ]
]

{ #category : #'t - list node' }
TToListNode >> removeFromList [

	self holder removeNodeFromList 
]

{ #category : #'t - list node' }
TToListNode >> selected: aBoolean [

	self holder selected: aBoolean
]
