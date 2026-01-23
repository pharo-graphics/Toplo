Class {
	#name : #ToCheckableState,
	#superclass : #Object,
	#instVars : [
		'owner',
		'group',
		'checked',
		'withIndeterminate',
		'eventHandler',
		'switchToNextCheckStateOnClick'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableState >> allowIndeterminate [

	^ withIndeterminate ifNil: [ withIndeterminate := false  ]
]

{ #category : #accessing }
ToCheckableState >> allowIndeterminate: aBoolean [

	withIndeterminate := aBoolean
]

{ #category : #accessing }
ToCheckableState >> checked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #'checking protocol' }
ToCheckableState >> checked: aBooleanOrIndeterminate requestBefore: requestBefore [

	| current req |
	aBooleanOrIndeterminate ifNil: [ Error signal: 'nil not allowed' ].
	(aBooleanOrIndeterminate isSymbol and: [
		 owner allowIndeterminate not ]) ifTrue: [
			Error signal:
				'a symbol not allowed except when indeterminate is explicitly allowed ' ].
	current := checked.
	aBooleanOrIndeterminate = current ifTrue: [ ^ self ].
	owner isDisabled ifTrue: [ ^ self ].
	owner group ifNotNil: [ :grp |
			(grp allowChangeWith: aBooleanOrIndeterminate forCheckable: owner)
				ifFalse: [ ^ self ] ].

	requestBefore ifTrue: [
			req := ToCheckableCheckRequestEvent new
				       requestedAction: [
					       self privateNotifyChecked: aBooleanOrIndeterminate ];
				       yourself.
			^ owner dispatchRequest: req ].
	self privateNotifyChecked: aBooleanOrIndeterminate
]

{ #category : #'checking protocol' }
ToCheckableState >> ensureChecked: aBooleanOrIndeterminate [

	self checked: aBooleanOrIndeterminate requestBefore: false
]

{ #category : #accessing }
ToCheckableState >> eventHandler [

	^ eventHandler
]

{ #category : #accessing }
ToCheckableState >> eventHandler: anEventHandler [

	eventHandler := anEventHandler
]

{ #category : #accessing }
ToCheckableState >> group [

	^ group
]

{ #category : #accessing }
ToCheckableState >> group: aGroup [

	group := aGroup
]

{ #category : #testing }
ToCheckableState >> isChecked [

	" since checked can be nil, test is with = "
	^ self checked = true
]

{ #category : #testing }
ToCheckableState >> isIndeterminate [

	^ self checked isSymbol
]

{ #category : #testing }
ToCheckableState >> isUnchecked [

	" since checked can be nil, test is with = "
	^ self checked = false
]

{ #category : #'checking protocol' }
ToCheckableState >> nextCheckValue [

	self allowIndeterminate ifTrue: [ " unchecked -> indeterminate -> checked"
		owner isIndeterminate ifTrue: [ ^ true ].
		owner isChecked ifTrue: [ ^ false ].
		^ #indeterminate ].
	^ self checked not
]

{ #category : #'t - checkable  - protocol' }
ToCheckableState >> notifyChanged [ 

	owner dispatchEvent: (ToCheckableChangedEvent new
			 checked: self isChecked;
			 yourself)
]

{ #category : #accessing }
ToCheckableState >> owner [

	^ owner
]

{ #category : #accessing }
ToCheckableState >> owner: aCheckable [

	owner := aCheckable
]

{ #category : #'checking protocol' }
ToCheckableState >> privateChecked: aBooleanOrIndeterminate [
	" notice a change of the state and send an event for the skin.
	Sent locally from the checkable>>checked: method and can be sent from
	the checkableGroup of the checkable."

	checked = aBooleanOrIndeterminate ifTrue: [ ^ self ].
	checked := aBooleanOrIndeterminate.
	" finally dispatch the event used to generate the state for the skin.
	implementation note: we need this additional event for the skin.
	This event can be used if one need to handle the look change or a 
	change in a checkable group (when an item in a group is checked, 
	the others may be unchecked according to the group strategy). If one
	need to handle the case where a checkable is unchecked because another
	group item is checked, then one can use this event 
	(example: ToAccordionElement)"
	owner dispatchEvent: (ToCheckableCheckEvent checked: checked)
]

{ #category : #'checking protocol' }
ToCheckableState >> privateNotifyChecked: aBooleanOrIndeterminate [

	checked = aBooleanOrIndeterminate ifTrue: [ ^ self ].
	self privateChecked: aBooleanOrIndeterminate.
	self notifyChanged 
]

{ #category : #'checking protocol' }
ToCheckableState >> requestChecked: aBooleanOrIndeterminate [ 

	self checked: aBooleanOrIndeterminate requestBefore: true
]

{ #category : #'checking protocol' }
ToCheckableState >> switchToNextCheckState [

	self requestChecked: self nextCheckValue 
]

{ #category : #'checking protocol' }
ToCheckableState >> switchToNextCheckStateOnClick [

	^ switchToNextCheckStateOnClick ifNil: [
		  switchToNextCheckStateOnClick := true ]
]

{ #category : #'checking protocol' }
ToCheckableState >> switchToNextCheckStateOnClick: aBoolean [

	" true by default.
	With false, it prevents from automatically switch to next state 
	to let the user decide when to do it.
	see https://github.com/pharo-graphics/Toplo/issues/336 "
	switchToNextCheckStateOnClick := aBoolean
]
