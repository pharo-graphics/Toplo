Trait {
	#name : #TToOrientable,
	#instVars : [
		'verticalRequested'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - orientable - orientation' }
TToOrientable >> beHorizontal [

	verticalRequested := false.
	self isHorizontal ifTrue: [ ^ self ].
	self orientation: BlLinearLayoutHorizontalOrientation new.
	self requestLayout 
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

	verticalRequested := true.
	self isVertical ifTrue: [ ^ self ].
	self orientation: BlLinearLayoutVerticalOrientation new.
	self requestLayout 
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> direction [

	^ self layout direction
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> direction: aDirection [

	(self layout direction isLeftToRight and: [ aDirection isLeftToRight]) ifTrue: [ ^ self ].
	self layout direction: aDirection.
	self dispatchEvent: ToLayoutDirectionChangedEvent new.
	self requestLayout
]

{ #category : #'t - orientable - orientation' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self beHorizontal ]
		ifFalse: [ self beVertical ]
]

{ #category : #'t - orientable - orientation' }
TToOrientable >> isHorizontal [

	^ self layout isHorizontal
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

{ #category : #'t - orientable - accessing' }
TToOrientable >> orientation [

	^ self layout orientation
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> orientation: aBlLayoutOrientation [

	(self layout orientation isHorizontal and: [ aBlLayoutOrientation isHorizontal]) ifTrue: [ ^ self ].
	self layout orientation: aBlLayoutOrientation.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestLayout
]

{ #category : #'t - orientable - accessing' }
TToOrientable >> verticalRequested [ 

	^ verticalRequested ifNil: [ verticalRequested :=  self orientation isVertical ]
]
