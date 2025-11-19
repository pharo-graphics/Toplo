Trait {
	#name : #TToCheckboxBasedSelectionManager,
	#instVars : [
		'checkBoxSelectionHandler'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - checkbox based selection manager' }
TToCheckboxBasedSelectionManager >> addCheckboxSelectionManagement [

	checkBoxSelectionHandler ifNotNil: [ ^ self ].
	self selectionMode selectOnClick: false.
	checkBoxSelectionHandler := self
		                            addEventHandlerOn:
		                            ToListPrimarySelectionChangedEvent
		                            do: [ :event |
				                            event touchedIntervals do: [ :int |
					                            self dataSource notifyItemsChanged:
						                            int ] ]
]

{ #category : #'t - checkbox based selection manager' }
TToCheckboxBasedSelectionManager >> newCheckableElementIn: anElement inNode: aNode [

	| innerElement cbox |
	cbox := ToCheckbox new.
	cbox focusability: BlFocusability none.
	cbox checked: aNode holder isSelected.
	
	" add a guard to prevent checking if it not desired.
	Here, it is not possible to take the check into account 
	if the list is not focused"
	cbox addEventHandlerOn: ToCheckableCheckRequestEvent do: [ :event |
			(self hasFocus not and: [ self isFocusable ])
				ifTrue: [ event deny ] ].

	" In case the checkbox has been checked, update the list selection "
	cbox addEventHandlerOn: ToCheckableCheckEvent do: [ :event |
			| req |
			req := ToListClickOnNodeRequestEvent new
				       requestedAction: [
					       self onCheckableCheckEvent: event onNode: aNode ];
				       yourself.
			aNode dispatchAuthorisationRequest: req ].

	anElement addChild: cbox.
	innerElement := ToElement new
		                hMatchParent;
		                vFitContent.
	innerElement layout: BlLinearLayout horizontal.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	innerElement constraintsDo: [ :c | c linear vertical alignCenter ].
	anElement addChild: innerElement.
	^ innerElement
]

{ #category : #'t - checkbox based selection manager' }
TToCheckboxBasedSelectionManager >> onCheckableCheckEvent: anEvent onNode: aNode [

	anEvent checked ifFalse: [ ^ aNode holder selected: false ].
	self spaceDo: [ :sp |
		anEvent sourceEvent: sp mouseProcessor lastMouseDownEvent ].
	self notifyClickOnNode: aNode fromEvent: anEvent
]

{ #category : #'t - checkbox based selection manager' }
TToCheckboxBasedSelectionManager >> onUseCheckboxChangedWith: aBoolean [

	aBoolean
		ifTrue: [ self addCheckboxSelectionManagement ]
		ifFalse: [ self removeCheckboxSelectionManagement ].
	self notifyDataSourceChanged
]

{ #category : #'t - checkbox based selection manager' }
TToCheckboxBasedSelectionManager >> removeCheckboxSelectionManagement [

	checkBoxSelectionHandler ifNil: [ ^ self ].
	self selectionMode selectOnClick: true.
	self removeEventHandler: checkBoxSelectionHandler.
	checkBoxSelectionHandler := nil
]
