Trait {
	#name : #TToOrientable,
	#category : #'Toplo-Core'
}

{ #category : #'t - orientable presentation' }
TToOrientable >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'t - orientable direction' }
TToOrientable >> beLeftToRight [ 

	self isLeftToRight ifTrue: [ ^ self ].
	self layout leftToRight.
	self directionChanged 
 
]

{ #category : #'t - orientable direction' }
TToOrientable >> beRightToLeft [

	self isRightToLeft ifTrue: [ ^ self ].
	self layout rightToLeft.
	self directionChanged 

 
]

{ #category : #'t - orientable orientation' }
TToOrientable >> beVertical [

	self isVertical ifTrue: [ ^ self ].
	self horizontal: false
]

{ #category : #'t - orientable direction' }
TToOrientable >> directionChanged [

	self announce: (ToDirectionChanged new widget: self)
]

{ #category : #'t - orientable orientation' }
TToOrientable >> horizontal [

	^ self layout isHorizontal
]

{ #category : #'t - orientable orientation' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout.
	self orientationChanged
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

{ #category : #'t - orientable orientation' }
TToOrientable >> orientation [

	^ self layout orientation
]

{ #category : #'t - orientable orientation' }
TToOrientable >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout.
	self orientationChanged
]

{ #category : #'t - orientable orientation' }
TToOrientable >> orientationChanged [

	self announce: (ToOrientationChanged new widget: self)
]

{ #category : #'t - orientable direction' }
TToOrientable >> whenDirectionChangedDo: aBlock [

	self whenAnnouncement: ToDirectionChanged do: aBlock
]

{ #category : #'t - orientable orientation' }
TToOrientable >> whenOrientationChangedDo: aBlock [

	self whenAnnouncement: ToOrientationChanged do: aBlock
]
