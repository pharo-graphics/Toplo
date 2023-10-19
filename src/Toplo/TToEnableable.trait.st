Trait {
	#name : 'TToEnableable',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 't - enableable' }
TToEnableable >> disabled: aBoolean [

	aBoolean 
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : 't - enableable' }
TToEnableable >> enabled: aBoolean [

	aBoolean 
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]
