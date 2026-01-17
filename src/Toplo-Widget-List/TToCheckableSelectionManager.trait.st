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
	checkBoxSelectionHandler := BlEventHandler
		                            on: ToListPrimarySelectionChangedEvent
		                            do: [ :event |
				                            self postponeAction: [
					                            self
						                            updateCheckboxesOnSelectionChangedEvent:
						                            event ] ].
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

	cbox checked: aNode holder isSelected.

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
TToCheckableSelectionManager >> updateCheckboxesOnSelectionChangedEvent: anEvent [

	anEvent touchedIntervals do: [ :int |
			int do: [ :pos |
					self nodeContainers do: [ :container |
							(container checkbox notNil and: [ container holder position = pos ])
								ifTrue: [
										container checkbox checked:
											(self selectionModel containsIndex:
												 container holder position) ] ] ] ]
]
