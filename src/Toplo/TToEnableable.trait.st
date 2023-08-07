Trait {
	#name : #TToEnableable,
	#instVars : [
		'enabled'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - enableable accessing' }
TToEnableable >> disable [

	self enabled ifFalse: [ ^ self ].
	enabled := false.
	self dispatchEvent: (ToElementEnablementEvent new
			 enabled: false;
			 yourself)
]

{ #category : #'t - enableable accessing' }
TToEnableable >> disabled: aBoolean [

	aBoolean value
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'t - enableable accessing' }
TToEnableable >> enable [

	self enabled ifTrue: [ ^ self ].
	enabled := true.
	self dispatchEvent: (ToElementEnablementEvent new
			 enabled: true;
			 yourself)
]

{ #category : #'t - enableable accessing' }
TToEnableable >> enabled [

	^ enabled ifNil: [ enabled := true ]
]

{ #category : #'t - enableable accessing' }
TToEnableable >> enabled: aBoolean [

	aBoolean value
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #'t - enableable accessing' }
TToEnableable >> isDisabled [
	<return: #Boolean>

	^ self enabled not
]

{ #category : #'t - enableable accessing' }
TToEnableable >> isEnabled [

	^ self enabled
]
