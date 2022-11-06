Trait {
	#name : #TToEnableable,
	#category : #'Toplo-Core'
}

{ #category : #'api - enablement' }
TToEnableable >> disable [
	self states addState: BlElementState disabled
]

{ #category : #'api - enablement' }
TToEnableable >> disabled: aBoolean [
	aBoolean value
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'api - enablement' }
TToEnableable >> enable [
	self states removeState: BlElementState disabled
]

{ #category : #'api - enablement' }
TToEnableable >> enabled: aBoolean [
	aBoolean value
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #'api - enablement' }
TToEnableable >> isDisabled [
	<return: #Boolean>

	^ self states hasState: BlElementState disabled
]

{ #category : #'api - enablement' }
TToEnableable >> isEnabled [
	^ self isDisabled not
]
