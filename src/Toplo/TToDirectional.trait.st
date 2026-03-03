Trait {
	#name : #TToDirectional,
	#category : #'Toplo-Core'
}

{ #category : #'t - directional' }
TToDirectional >> beEndToStart [

	self direction: BlLayoutDirection rightToLeft 
]

{ #category : #'t - directional' }
TToDirectional >> beLeftToRight [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - directional' }
TToDirectional >> beRightToLeft [

	self direction: BlLayoutDirection rightToLeft
]

{ #category : #'t - directional' }
TToDirectional >> beStartToEnd [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - directional' }
TToDirectional >> direction [

	^ self layout direction
]

{ #category : #'t - directional' }
TToDirectional >> direction: aDirection [

	self layout direction = aDirection ifTrue: [ ^ self ].
	self layout direction: aDirection.
	self requestConfiguration.
	self requestNewSkin.
	self dispatchEvent: ToLayoutDirectionChangedEvent new
]

{ #category : #'t - directional' }
TToDirectional >> endToStart: aBoolean [

	self startToEnd: aBoolean not
]

{ #category : #'t - directional' }
TToDirectional >> isEndToStart [

	^ self isStartToEnd not
]

{ #category : #'t - directional' }
TToDirectional >> isLeftToRight [

	^ self direction isLeftToRight
]

{ #category : #'t - directional' }
TToDirectional >> isRightToLeft [

	^ self direction isRightToLeft
]

{ #category : #'t - directional' }
TToDirectional >> isStartToEnd [

	^ self isLeftToRight
]

{ #category : #'t - directional' }
TToDirectional >> leftToRight: aBoolean [

	aBoolean
		ifTrue: [ self beLeftToRight ]
		ifFalse: [ self beRightToLeft ]
]

{ #category : #'t - directional' }
TToDirectional >> rightToLeft: aBoolean [

	self leftToRight: aBoolean not
]

{ #category : #'t - directional' }
TToDirectional >> startToEnd: aBoolean [

	aBoolean
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ]
]
