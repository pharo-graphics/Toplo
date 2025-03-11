Class {
	#name : #ToCheckableData,
	#superclass : #Object,
	#instVars : [
		'owner',
		'group',
		'checked',
		'withIndeterminate',
		'eventHandler'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableData >> allowIndeterminate [

	^ withIndeterminate ifNil: [ withIndeterminate := false  ]
]

{ #category : #accessing }
ToCheckableData >> allowIndeterminate: aBoolean [

	withIndeterminate := aBoolean
]

{ #category : #accessing }
ToCheckableData >> checked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #'checking protocol' }
ToCheckableData >> checked: aBooleanOrIndeterminate [ 

	| current |
	aBooleanOrIndeterminate ifNil: [ Error signal: 'nil not allowed' ].
	(aBooleanOrIndeterminate isSymbol and: [ owner allowIndeterminate not ])
		ifTrue: [
			Error signal:
				'a symbol not allowed except when indeterminate is explicitly allowed ' ].
	owner isDisabled ifTrue: [ ^ self ].
	current := checked.
	owner group ifNotNil: [ :grp |
		(grp allowChangeWith: aBooleanOrIndeterminate forCheckable: owner)
			ifFalse: [ ^ self ] ].
	aBooleanOrIndeterminate = current ifTrue: [ ^ self ].
	self privateChecked: aBooleanOrIndeterminate.
	self notifyChanged
]

{ #category : #accessing }
ToCheckableData >> eventHandler [

	^ eventHandler
]

{ #category : #accessing }
ToCheckableData >> eventHandler: anEventHandler [

	eventHandler := anEventHandler
]

{ #category : #accessing }
ToCheckableData >> group [

	^ group
]

{ #category : #accessing }
ToCheckableData >> group: aGroup [

	group := aGroup
]

{ #category : #testing }
ToCheckableData >> isChecked [

	" since checked can be nil, test is with = "
	^ self checked = true
]

{ #category : #testing }
ToCheckableData >> isIndeterminate [

	^ self checked isSymbol
]

{ #category : #testing }
ToCheckableData >> isUnchecked [

	" since checked can be nil, test is with = "
	^ self checked = false
]

{ #category : #'checking protocol' }
ToCheckableData >> nextCheckValue [

	self allowIndeterminate ifTrue: [ " unchecked -> indeterminate -> checked"
		owner isIndeterminate ifTrue: [ ^ true ].
		owner isChecked ifTrue: [ ^ false ].
		^ #indeterminate ].
	^ self checked not
]

{ #category : #'t - checkable  - protocol' }
ToCheckableData >> notifyChanged [ 

	owner dispatchEvent: (ToCheckableChangedEvent new
			 checked: self isChecked;
			 yourself)
]

{ #category : #accessing }
ToCheckableData >> owner [

	^ owner
]

{ #category : #accessing }
ToCheckableData >> owner: aCheckable [

	owner := aCheckable
]

{ #category : #'checking protocol' }
ToCheckableData >> privateChecked: aBooleanOrIndeterminate [
	" notice a change of the state and send an event for the skin.
	Sent locally from the checkable>>checked: method and can be sent from
	the checkableGroup of the checkable."

	checked = aBooleanOrIndeterminate ifTrue: [ ^ self ].
	checked := aBooleanOrIndeterminate.
	" finally dispatch the event used to generate the state for the skin.
	implementation note: we need this additional event for the skin.
	This event can be used if one need to handle the look change "
	owner dispatchEvent: (ToCheckableCheckEvent checked: checked)
]

{ #category : #'checking protocol' }
ToCheckableData >> registerHolder: anElement [

	owner addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event | anElement dispatchEvent: event copy ]).
	owner addEventHandler: (BlEventHandler
			 on: ToCheckableChangedEvent
			 do: [ :event | anElement dispatchEvent: event copy ])
]

{ #category : #'checking protocol' }
ToCheckableData >> switchToNextCheckState [

	self checked: self nextCheckValue 
]
