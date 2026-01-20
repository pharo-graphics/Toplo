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
	" the checkbox is not responsible for its skin update (to render the check state).
	The update is done by the list element primary selection event handler 
	as a consequence of the primary selection change "
	cbox switchToNextCheckStateOnClick: false.
	cbox focusability: BlFocusability none.
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> newCheckboxInNodeContainer: aNodeContainer [

	| cbox |
	cbox := self newCheckbox.
	cbox privateChecked: aNodeContainer holder isSelected.
	" In case the checkbox has been checked, update the list selection "
	cbox addEventHandlerOn: BlPrimaryClickEvent do: [ :event |
		self notifyClickOnNode: aNodeContainer node fromEvent: event ].
	^ cbox
]

{ #category : #'t - checkable selection manager' }
TToCheckableSelectionManager >> requestUpdateCheckboxes [

	checkboxesUpdateRequested := true.
	" the checkboxes are updated after the layout is done "
	self requestLayout
]
