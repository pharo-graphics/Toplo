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
	owner dispatchEvent: (ToCheckableChangedEvent new
			 checked: checked;
			 yourself)
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

	| prev request |
	request := aBooleanOrIndeterminate.
	checked = request ifTrue: [ ^ self ].
	prev := checked.
	checked := request.
	" finally dispatch the event used to generate the state for the skin "
	owner dispatchEvent: (ToCheckableCheckEvent current: request previous: prev)
]

{ #category : #'checking protocol' }
ToCheckableData >> registerHolder: anElement [

	owner addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event | anElement dispatchEvent: event ])
]

{ #category : #'checking protocol' }
ToCheckableData >> switchToNextCheckState [

	self checked: self nextCheckValue 
]
