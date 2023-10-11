Trait {
	#name : #TToCheckbox,
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - checkbox - group' }
TToCheckbox >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

{ #category : #'t - checkbox - group' }
TToCheckbox >> group [

	^ group
]

{ #category : #'t - checkbox - group' }
TToCheckbox >> group: aCheckableGroup [

	self withIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].

	self when: ToCheckableCheckRequest do: [ :event | aCheckableGroup checkRequestEvent: event ].
	group := aCheckableGroup
]

{ #category : #'t - checkbox - group' }
TToCheckbox >> removeFromGroup [

	self group remove: self
]
