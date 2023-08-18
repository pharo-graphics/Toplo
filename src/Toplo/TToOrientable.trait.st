Trait {
	#name : #TToOrientable,
	#instVars : [
		'verticalRequested'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - orientable orientation' }
TToOrientable >> beHorizontal [

	verticalRequested := false.
	self isHorizontal ifTrue: [ ^ self ].
	self orientation: BlLinearLayoutHorizontalOrientation new.
	self requestLayout 
]

{ #category : #'t - orientable direction' }
TToOrientable >> beLeftToRight [

	self isLeftToRight ifTrue: [ ^ self ].
	self direction: BlLayoutDirection leftToRight
]

{ #category : #'t - orientable direction' }
TToOrientable >> beRightToLeft [

	self isRightToLeft ifTrue: [ ^ self ].
	self direction: BlLayoutDirection rightToLeft
]

{ #category : #'t - orientable orientation' }
TToOrientable >> beVertical [

	verticalRequested := true.
	self isVertical ifTrue: [ ^ self ].
	self orientation: BlLinearLayoutVerticalOrientation new.
	self requestLayout 
]

{ #category : #accessing }
TToOrientable >> direction [

	^ self layout direction
]

{ #category : #accessing }
TToOrientable >> direction: aDirection [

	self layout direction = aDirection ifTrue: [ ^ self ].
	self layout direction: aDirection.
	self dispatchEvent: ToLayoutDirectionChangedEvent new.
	self requestLayout
]

{ #category : #'t - orientable orientation' }
TToOrientable >> horizontal [

	^ self layout isHorizontal
]

{ #category : #'t - orientable orientation' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self beHorizontal ]
		ifFalse: [ self beVertical ]
]

{ #category : #'t - orientable orientation' }
TToOrientable >> isHorizontal [

	^ self horizontal
]

{ #category : #'t - orientable direction' }
TToOrientable >> isLeftToRight [

	^ self direction isLeftToRight
]

{ #category : #'t - orientable direction' }
TToOrientable >> isRightToLeft [

	^ self direction isRightToLeft
]

{ #category : #'t - orientable orientation' }
TToOrientable >> isVertical [

	^ self isHorizontal not
]

{ #category : #accessing }
TToOrientable >> orientation [

	^ self layout orientation
]

{ #category : #accessing }
TToOrientable >> orientation: aBlLayoutOrientation [

	self layout orientation = aBlLayoutOrientation ifTrue: [ ^ self ].
	self layout orientation: aBlLayoutOrientation.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestLayout
]

{ #category : #'t - labeled icon' }
TToOrientable >> verticalRequested [

	" useful in case the layout is changed to set the right direction"
	^ verticalRequested ifNil: [ verticalRequested := self isVertical ]
]
