Trait {
	#name : #TToOrientable,
	#category : #'Toplo-Core'
}

{ #category : #'t - orientable' }
TToOrientable >> beEndToStart [

	self direction: BlLayoutDirection rightToLeft 
]

{ #category : #'t - orientable' }
TToOrientable >> beHorizontal [

	self horizontal: true
]

{ #category : #'t - orientable' }
TToOrientable >> beLeftToRight [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - orientable' }
TToOrientable >> beRightToLeft [

	self direction: BlLayoutDirection rightToLeft
]

{ #category : #'t - orientable' }
TToOrientable >> beStartToEnd [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - orientable' }
TToOrientable >> beVertical [

	self vertical: true
]

{ #category : #'t - orientable' }
TToOrientable >> direction [

	^ self targetLayout direction
]

{ #category : #'t - orientable' }
TToOrientable >> direction: aDirection [

	self targetLayout direction = aDirection ifTrue: [ ^ self ].
	self targetLayout direction: aDirection.
	self requestConfiguration.
	self requestNewSkin.
	self dispatchEvent: ToLayoutDirectionChangedEvent new
]

{ #category : #'t - orientable' }
TToOrientable >> endToStart: aBoolean [

	self startToEnd: aBoolean not
]

{ #category : #'t - orientable' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [
			self isHorizontal ifTrue: [ ^ self ].
			self targetLayout beHorizontal ]
		ifFalse: [
			self isVertical ifTrue: [ ^ self ].
			self targetLayout beVertical ].
	self requestConfiguration.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestNewSkin
]

{ #category : #'t - orientable' }
TToOrientable >> isEndToStart [

	^ self isStartToEnd not
]

{ #category : #'t - orientable' }
TToOrientable >> isHorizontal [

	^ self layout isHorizontal
]

{ #category : #'t - orientable' }
TToOrientable >> isLeftToRight [

	^ self direction isLeftToRight
]

{ #category : #'t - orientable' }
TToOrientable >> isRightToLeft [

	^ self direction isRightToLeft
]

{ #category : #'t - orientable' }
TToOrientable >> isStartToEnd [

	^ self isLeftToRight
]

{ #category : #'t - orientable' }
TToOrientable >> isVertical [

	^ self isHorizontal not
]

{ #category : #'t - orientable' }
TToOrientable >> isVertical: aBoolean [

	self vertical: aBoolean
]

{ #category : #'t - orientable' }
TToOrientable >> leftToRight: aBoolean [

	aBoolean
		ifTrue: [ self beLeftToRight ]
		ifFalse: [ self beRightToLeft ]
]

{ #category : #'t - orientable' }
TToOrientable >> orientation [

	^ self targetLayout orientation
]

{ #category : #'t - orientable' }
TToOrientable >> orientation: aBlLayoutOrientation [

	self targetLayout orientation = aBlLayoutOrientation ifTrue: [ ^ self ].
	self targetLayout orientation: aBlLayoutOrientation.
	self requestConfiguration.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestNewSkin 
]

{ #category : #'t - orientable' }
TToOrientable >> rightToLeft: aBoolean [

	self leftToRight: aBoolean not
]

{ #category : #'t - orientable' }
TToOrientable >> startToEnd: aBoolean [

	aBoolean
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ]
]

{ #category : #'t - orientable' }
TToOrientable >> targetLayout [

	^ self layout
]

{ #category : #'t - orientable' }
TToOrientable >> vertical: aBoolean [

	self horizontal: aBoolean not
]
