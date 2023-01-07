Trait {
	#name : #TToOrientable,
	#category : #'Toplo-Core'
}

{ #category : #'t - orientable presentation' }
TToOrientable >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'t - orientable presentation' }
TToOrientable >> beLeftToRight [ 

	self layout leftToRight
 
]

{ #category : #'t - orientable presentation' }
TToOrientable >> beRightToLeft [

	self layout rightToLeft
 
]

{ #category : #'t - orientable presentation' }
TToOrientable >> beVertical [

	self horizontal: false
]

{ #category : #'t - orientable presentation' }
TToOrientable >> horizontal [

	^ self layout isHorizontal
]

{ #category : #'t - orientable presentation' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout.
	self orientationChanged
]

{ #category : #'t - orientable presentation' }
TToOrientable >> isHorizontal [

	^ self horizontal
]

{ #category : #'t - orientable presentation' }
TToOrientable >> isLeftToRight [

	^ self direction isLeftToRight
]

{ #category : #'t - orientable presentation' }
TToOrientable >> isRightToLeft [

	^ self direction isRightToLeft
]

{ #category : #'t - orientable presentation' }
TToOrientable >> orientation [

	^ self layout orientation
]

{ #category : #'t - orientable presentation' }
TToOrientable >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout.
	self orientationChanged
]

{ #category : #'t - orientable presentation' }
TToOrientable >> orientationChanged [

	self announce: (ToOrientationChanged new widget: self)
]

{ #category : #'t - orientable presentation' }
TToOrientable >> whenOrientationChangedDo: aBlock [

	self whenAnnouncement: ToOrientationChanged do: aBlock
]
