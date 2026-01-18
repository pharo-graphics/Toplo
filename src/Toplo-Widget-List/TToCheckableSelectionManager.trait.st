Trait {
	#name : #TToCheckableSelectionManager,
	#instVars : [
		'checkBoxSelectionHandler',
		'checkboxUpdateRequested'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> addCheckboxSelectionManagement [

	checkBoxSelectionHandler ifNotNil: [ ^ self ].
	checkBoxSelectionHandler := BlEventHandler
		                            on: ToListPrimarySelectionChangedEvent
		                            do: [ :event |
		                            self requestUpdateCheckboxes ].
	self addEventHandler: checkBoxSelectionHandler
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckbox [

	|  cbox |
	cbox := ToCheckbox new.
	cbox id: #checkbox.
	cbox switchToNextCheckStateOnClick: false.
	cbox focusability: BlFocusability none.
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckboxInNodeContainer: aNode [

	| cbox |
	self selectionMode selectOnClick: false.
	cbox := self newCheckbox.
	" add a guard to prevent checking if it not desired.
	Here, it is not possible to take the check into account 
	if the list is not focused"
	cbox addEventHandlerOn: ToCheckableCheckRequestEvent do: [ :event |
			(self hasFocus not and: [ self isFocusable ]) ifTrue: [
					(self selectionModel isNotEmpty and: [
						 self selectionModel selectedIndexesCount > 1 ]) ifTrue: [
						event deny ] ] ].

	cbox privateChecked: aNode holder isSelected.

	" In case the checkbox has been checked, update the list selection "
	cbox
		addEventHandlerOn: BlPrimaryClickEvent
		do: [ :event |
		self onCheckableCheckEvent: event onNodeContainer: aNode ].
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> onCheckableCheckEvent: anEvent onNodeContainer: aNodeContainer [

	self notifyClickOnNode: aNodeContainer node fromEvent: anEvent
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> onUseCheckboxChangedWith: aBoolean [

	aBoolean
		ifTrue: [ self addCheckboxSelectionManagement ]
		ifFalse: [ self removeCheckboxSelectionManagement ].
	self postponeAction: [  self notifyDataSourceChanged ]
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> removeCheckboxSelectionManagement [

	checkBoxSelectionHandler ifNil: [ ^ self ].
	self selectionMode selectOnClick: true.
	self removeEventHandler: checkBoxSelectionHandler.
	checkBoxSelectionHandler := nil
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> requestUpdateCheckboxes [

	checkboxUpdateRequested := true.
	self requestLayout
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> updateCheckboxes [

	checkboxUpdateRequested := false.
	self nodeManager checkableNode ifFalse: [ ^ self ].
	self nodeContainersDo: [ :nc |
			nc checkbox ifNotNil: [ :cbox |
				cbox privateChecked: nc holder isSelected ] ]
]
