Trait {
	#name : #TToEnableable,
	#instVars : [
		'enabled'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing enablement' }
TToEnableable >> disable [

	enabled := false
]

{ #category : #'t - accessing enablement' }
TToEnableable >> disabled: aBoolean [

	aBoolean value
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'t - accessing enablement' }
TToEnableable >> enable [

	enabled := true
]

{ #category : #'t - accessing enablement' }
TToEnableable >> enabled [

	^ enabled ifNil: [ enabled := true ]
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

	^ self enabled not
]

{ #category : #'t - accessing enablement' }
TToEnableable >> isEnabled [

	^ self enabled
]
