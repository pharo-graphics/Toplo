Trait {
	#name : #TToOrientable,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - orientable - orientation' }
TToOrientable >> beHorizontal [

	self isHorizontal ifTrue: [ ^ self ].
	self layoutStrategy beHorizontal.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self launchRequestLayout 
]

{ #category : #'t - orientable - direction' }
TToOrientable >> beLeftToRight [

	self isLeftToRight ifTrue: [ ^ self ].
	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - orientable - direction' }
TToOrientable >> beRightToLeft [

	self isRightToLeft ifTrue: [ ^ self ].
	self direction: BlLayoutDirection rightToLeft
]

{ #category : #'t - orientable - orientation' }
TToOrientable >> beVertical [

	self isVertical ifTrue: [ ^ self ].
	self layoutStrategy beVertical.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self launchRequestLayout	
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> direction [

	^ self layoutStrategy direction
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> direction: aDirection [

	(self layoutStrategy direction isLeftToRight and: [ aDirection isLeftToRight]) ifTrue: [ ^ self ].
	self layoutStrategy direction: aDirection.
	self dispatchEvent: ToLayoutDirectionChangedEvent new.
	self launchRequestLayout
]

{ #category : #'t - orientable - orientation' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self beHorizontal ]
		ifFalse: [ self beVertical ]
]

{ #category : #'t - orientable - orientation' }
TToOrientable >> isHorizontal [

	^ self layoutStrategy isHorizontal
]

{ #category : #'t - orientable - direction' }
TToOrientable >> isLeftToRight [

	^ self direction isLeftToRight
]

{ #category : #'t - orientable - direction' }
TToOrientable >> isRightToLeft [

	^ self direction isRightToLeft
]

{ #category : #'t - orientable - orientation' }
TToOrientable >> isVertical [

	^ self isHorizontal not
]

{ #category : #'t - orientable - private' }
TToOrientable >> launchRequestLayout [

	self childrenDo: [ :child | child requestLayout ].
	self requestLayout
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> layoutStrategy [

	^ self explicitRequirement 

	
]

{ #category : #'t - orientable - direction' }
TToOrientable >> leftToRight: aBoolean [

	aBoolean = self isLeftToRight ifTrue: [ ^ self ].
	aBoolean ifTrue: [ self beLeftToRight ] ifFalse: [ self beRightToLeft ]
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> orientation [

	^ self layoutStrategy orientation
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> orientation: aBlLayoutOrientation [

	(self layoutStrategy orientation isHorizontal and: [ aBlLayoutOrientation isHorizontal]) ifTrue: [ ^ self ].
	self layoutStrategy orientation: aBlLayoutOrientation.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self launchRequestLayout
]
