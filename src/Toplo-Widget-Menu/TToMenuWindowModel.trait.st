Trait {
	#name : #TToMenuWindowModel,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'t - menu window model' }
TToMenuWindowModel >> closeWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> hasInlineWindow [

	^ self manager ifNotNil: [:m | m hasInlineWindow] ifNil: [ false ]
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> isInline [

	self
		deprecated: 'Use #hasInlineWindow instead'
		transformWith: '`@rcvr isInline' -> '`@rcvr hasInlineWindow'.
	^ self hasInlineWindow
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> isSubmenu [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> isTopMenu [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> menuWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> menuWindowDo: aValuable [

	self menuWindow ifNil: [ ^ self ].
	aValuable value: self menuWindow
]
