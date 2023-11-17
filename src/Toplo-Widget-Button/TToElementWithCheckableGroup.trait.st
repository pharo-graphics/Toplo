Trait {
	#name : 'TToElementWithCheckableGroup',
	#instVars : [
		'group'
	],
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 't - element with checkable group' }
TToElementWithCheckableGroup >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

{ #category : 't - element with checkable group' }
TToElementWithCheckableGroup >> group [

	^ group
]

{ #category : 't - element with checkable group' }
TToElementWithCheckableGroup >> group: aCheckableGroup [

	self withIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].
	group := aCheckableGroup.
	group ifNil: [ ^ self ].
	self when: ToCheckableCheckRequest do: [ :event | aCheckableGroup checkRequestEvent: event ].
	self when: ToCheckableChangedEvent do: [ :event | aCheckableGroup checkableChangedEvent: event ].

]

{ #category : 't - element with checkable group' }
TToElementWithCheckableGroup >> removeFromGroup [

	self group remove: self
]
