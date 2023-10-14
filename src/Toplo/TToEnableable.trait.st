Trait {
	#name : 'TToEnableable',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 't - enableable accessing' }
TToEnableable >> disabled: aBoolean [

	aBoolean 
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : 't - enableable accessing' }
TToEnableable >> enabled: aBoolean [

	aBoolean 
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]
