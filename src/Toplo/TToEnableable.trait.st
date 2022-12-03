Trait {
	#name : #TToEnableable,
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing enablement' }
TToEnableable >> disable [

	self states addState: BlElementState disabled
]

{ #category : #'t - accessing enablement' }
TToEnableable >> disabled: aBoolean [

	aBoolean value
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'t - accessing enablement' }
TToEnableable >> enable [

	self states removeState: BlElementState disabled
]

{ #category : #'t - accessing enablement' }
TToEnableable >> enabled: aBoolean [

	aBoolean value
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #'t - accessing enablement' }
TToEnableable >> isDisabled [
	<return: #Boolean>

	^ self states hasState: BlElementState disabled
]

{ #category : #'t - accessing enablement' }
TToEnableable >> isEnabled [

	^ self isDisabled not
]
