Trait {
	#name : #TToCheckableSelectionManager,
	#instVars : [
		'checkboxesUpdateRequested'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> checkboxesUpdateDone [

	checkboxesUpdateRequested := false
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> checkboxesUpdateRequested [

	^ checkboxesUpdateRequested ifNil: [ checkboxesUpdateRequested := false ]
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckbox [

	|  cbox |
	cbox := ToCheckbox new.
	cbox id: #'list-selection-checkbox'.
	cbox focusability: BlFocusability none.
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckboxInNodeContainer: aNodeContainer [

	| cbox |
	cbox := self newCheckbox.

	cbox
		addEventHandlerOn: ToCheckableCheckRequestEvent
		do: [ :event | event authorized: aNodeContainer holder isSelectable ].

	cbox checked: aNodeContainer holder isSelected.
	" In case the checkbox has been checked, update the list selection "
	cbox addEventHandlerOn: BlPrimaryClickEvent do: [ :event |
			self
				notifyClickOnCheckbox: cbox
				onNode: aNodeContainer node
				onEvent: event ].
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> notifyClickOnCheckbox: aCheckbox onNode: aNode onEvent: anEvent [

	aNode isAttachedToSceneGraph ifFalse: [ ^ self ].
	self isDisabled ifTrue: [ ^ self ].

	aNode dispatchEvent: (ToListClickOnNodeCheckboxEvent new
			 fillFromTime: aNode space time;
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> requestUpdateCheckboxes [

	checkboxesUpdateRequested := true.
	" the checkboxes are updated after the layout is done "
	self requestLayout
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> updateCheckboxes [

	self nodeManager checkableNode ifFalse: [ ^ self ].
	self checkboxesUpdateRequested ifFalse: [ ^ self ].
	self checkboxesUpdateDone.
	self nodeContainersDo: [ :nc |
			nc checkbox ifNotNil: [ :cbox |
				cbox enabled: true.
				cbox privateChecked: (nc holder isSelected and: [ nc holder isSelectable ] ) ] ]
]
