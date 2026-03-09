Trait {
	#name : #TToCheckableSelectionManager,
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckbox [

	^ ToListNodeContainerCheckbox new
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckboxInNodeContainer: aNodeContainer [

	| cbox |
	cbox := self newCheckbox.
	cbox nodeContainer: aNodeContainer.
	cbox
		addEventHandlerOn: ToCheckableCheckRequestEvent
		do: [ :event | event authorized: aNodeContainer holder isSelectable ].

	" In case the checkbox has been checked, update the list selection "
	cbox
		addEventHandlerOn: BlPrimaryClickEvent
		do: [ :event | self notifyClickOnCheckbox: cbox onEvent: event ].
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> notifyClickOnCheckbox: aCheckbox onEvent: anEvent [

	| node |
	node := aCheckbox nodeContainer node.
	node isAttachedToSceneGraph ifFalse: [ ^ self ].
	self isDisabled ifTrue: [ ^ self ].

	node dispatchEvent: (ToListClickOnNodeCheckboxEvent new
			 fillFromTime: aCheckbox space time;
			 sourceEvent: anEvent;
			 yourself)
]
