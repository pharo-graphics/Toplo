Trait {
	#name : #TToEnableable,
	#instVars : [
		'#enabled => ObservableSlot'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - enableable accessing' }
TToEnableable >> disable [

	enabled := false
]

{ #category : #'t - enableable accessing' }
TToEnableable >> disabled: aBoolean [

	aBoolean value
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'t - enableable accessing' }
TToEnableable >> enable [

	enabled := true
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

{ #category : #initialization }
TToEnableable >> initialize [

	self class initializeSlots: self.
	super initialize.
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

{ #category : #'t - enableable change hook' }
TToEnableable >> whenEnabledChangedDo: aBlock [

	self property: #enabled whenChangedDo: aBlock
]
