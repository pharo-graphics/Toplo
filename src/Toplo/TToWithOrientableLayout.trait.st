Trait {
	#name : #TToWithOrientableLayout,
	#category : #'Toplo-Core'
}

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beEndToStart [

	self isEndToStart ifTrue: [ ^ self ].
	self leftToRight: false.
	self requestLayout
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> beHorizontal [

	self horizontal: true
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beLeftToRight [

	self isLeftToRight ifTrue: [ ^ self ].
	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beRightToLeft [

	self isRightToLeft ifTrue: [ ^ self ].
	self direction: BlLayoutDirection rightToLeft
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> beStartToEnd [

	self isStartToEnd ifTrue: [ ^ self ].
	self leftToRight: true.
	self requestLayout
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> beVertical [

	self vertical: true
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> direction [

	^ self layout direction
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> direction: aDirection [

	(self layout direction isLeftToRight and: [
		 aDirection isLeftToRight ]) ifTrue: [ ^ self ].
	(self layout direction isRightToLeft and: [
		 aDirection isRightToLeft ]) ifTrue: [ ^ self ].
	self layout direction: aDirection.
	self dispatchEvent: ToLayoutDirectionChangedEvent new.
	self requestLayout
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
			self layout beHorizontal ]
		ifFalse: [
			self isVertical ifTrue: [ ^ self ].
			self layout beVertical ].
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestLayout
]

{ #category : #'t - with orientable layout - testing' }
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

{ #category : #'t - with orientable layout - testing' }
TToWithOrientableLayout >> isStartToEnd [

	^ self isLeftToRight
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> isVertical [

	^ self isHorizontal not
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> leftToRight: aBoolean [

	aBoolean = self isLeftToRight ifTrue: [ ^ self ].
	aBoolean ifTrue: [ self beLeftToRight ] ifFalse: [ self beRightToLeft ]
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> orientation [

	^ self layout orientation
]

{ #category : #'t - with orientable layout - accessing' }
TToWithOrientableLayout >> orientation: aBlLayoutOrientation [

	(self layout orientation isHorizontal and: [
		 aBlLayoutOrientation isHorizontal ]) ifTrue: [ ^ self ].
	(self layout orientation isVertical and: [
		 aBlLayoutOrientation isVertical ]) ifTrue: [ ^ self ].
	self layout orientation: aBlLayoutOrientation.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestLayout
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> rightToLeft: aBoolean [

	aBoolean = self isRightToLeft ifTrue: [ ^ self ].
	aBoolean ifTrue: [ self beRightToLeft ] ifFalse: [ self beLeftToRight ]
]

{ #category : #'t - with orientable layout - direction' }
TToWithOrientableLayout >> startToEnd: aBoolean [

	aBoolean
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ]
]

{ #category : #'t - with orientable layout - orientation' }
TToWithOrientableLayout >> vertical: aBoolean [

	self horizontal: aBoolean not
]
