Trait {
	#name : #TToWithOrientableLayout,
	#category : #'Toplo-Core'
}

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beEndToStart [

	self direction: BlLayoutDirection rightToLeft 
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> beHorizontal [

	self horizontal: true
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beLeftToRight [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beRightToLeft [

	self direction: BlLayoutDirection rightToLeft
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beStartToEnd [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> beVertical [

	self vertical: true
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> direction [

	^ self targetLayout direction
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> direction: aDirection [

	self targetLayout direction = aDirection ifTrue: [ ^ self ].
	self targetLayout direction: aDirection.
	self requestNewConfigurationPass.
	self requestNewSkin.
	self dispatchEvent: ToLayoutDirectionChangedEvent new
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> endToStart: aBoolean [

	self startToEnd: aBoolean not
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> horizontal: aBoolean [

	aBoolean
		ifTrue: [
			self isHorizontal ifTrue: [ ^ self ].
			self targetLayout beHorizontal ]
		ifFalse: [
			self isVertical ifTrue: [ ^ self ].
			self targetLayout beVertical ].
	self requestNewConfigurationPass.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestNewSkin 
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> isEndToStart [

	^ self isStartToEnd not
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> isHorizontal [

	^ self layout isHorizontal
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> isLeftToRight [

	^ self direction isLeftToRight
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> isRightToLeft [

	^ self direction isRightToLeft
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> isStartToEnd [

	^ self isLeftToRight
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> isVertical [

	^ self isHorizontal not
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> leftToRight: aBoolean [

	aBoolean
		ifTrue: [ self beLeftToRight ]
		ifFalse: [ self beRightToLeft ]
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> orientation [

	^ self targetLayout orientation
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> orientation: aBlLayoutOrientation [

	self targetLayout orientation = aBlLayoutOrientation ifTrue: [ ^ self ].
	self targetLayout orientation: aBlLayoutOrientation.
	self requestNewConfigurationPass.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestNewSkin 
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> rightToLeft: aBoolean [

	self leftToRight: aBoolean not
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> startToEnd: aBoolean [

	aBoolean
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ]
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> targetLayout [

	^ self layout
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> vertical: aBoolean [

	self horizontal: aBoolean not
]
