Trait {
	#name : #TToCheckableSelectionManager,
	#instVars : [
		'checkBoxSelectionHandler'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> addCheckboxSelectionManagement [

	checkBoxSelectionHandler ifNotNil: [ ^ self ].
	self selectionMode selectOnClick: false.
	checkBoxSelectionHandler := BlEventHandler
		                            on: ToListPrimarySelectionChangedEvent
		                            do: [ :event |
		                            self
			                            updateCheckboxesOnSelectionChangedEvent:
			                            event ].
	self addEventHandler: checkBoxSelectionHandler
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckbox [

	|  cbox |
	cbox := ToCheckbox new.
	cbox addStamp: #iconic.
	cbox id: #cellCheckbox.
	cbox focusability: BlFocusability none.
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckboxInNode: aNode [

	| cbox |
	cbox := self newCheckbox.
	" add a guard to prevent checking if it not desired.
	Here, it is not possible to take the check into account 
	if the list is not focused"
	cbox addEventHandlerOn: ToCheckableCheckRequestEvent do: [ :event |
			(self hasFocus not and: [ self isFocusable ]) ifTrue: [
					(self selectionModel isNotEmpty and: [
						 self selectionModel selectedIndexesCount > 1 ]) ifTrue: [ event deny ] ] ].

	cbox ensureChecked: aNode holder isSelected.

	" In case the checkbox has been checked, update the list selection "
	cbox addEventHandlerOn: ToCheckableCheckEvent do: [ :event |
			| req |
			req := ToListClickOnNodeRequestEvent new
				       requestedAction: [
					       self onCheckableCheckEvent: event onNode: aNode ];
				       yourself.
			aNode dispatchAuthorisationRequest: req ].
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> onCheckableCheckEvent: anEvent onNode: aNode [

	anEvent checked ifFalse: [ ^ aNode holder selected: false ].
	self spaceDo: [ :sp |
		anEvent sourceEvent: sp mouseProcessor lastMouseDownEvent ].
	self notifyClickOnNode: aNode fromEvent: anEvent
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> onUseCheckboxChangedWith: aBoolean [

	aBoolean
		ifTrue: [ self addCheckboxSelectionManagement ]
		ifFalse: [ self removeCheckboxSelectionManagement ].
	self notifyDataSourceChanged
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> removeCheckboxSelectionManagement [

	checkBoxSelectionHandler ifNil: [ ^ self ].
	self selectionMode selectOnClick: true.
	self removeEventHandler: checkBoxSelectionHandler.
	checkBoxSelectionHandler := nil
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> updateCheckboxesOnSelectionChangedEvent: anEvent [

	anEvent touchedIntervals do: [ :int |
		self dataSource notifyItemsChanged: int ]
]
