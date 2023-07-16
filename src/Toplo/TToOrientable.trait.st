Trait {
	#name : #TToOrientable,
	#category : #'Toplo-Core'
}

{ #category : #'t - orientable orientation' }
TToOrientable >> beHorizontal [

	self isHorizontal ifTrue: [ ^ self ].
	self horizontal: true
]

{ #category : #'t - orientable direction' }
TToOrientable >> beLeftToRight [

	self isLeftToRight ifTrue: [ ^ self ].
	self layout leftToRight
]

{ #category : #'t - orientable direction' }
TToOrientable >> beRightToLeft [

	self isRightToLeft ifTrue: [ ^ self ].
	self layout rightToLeft
]

{ #category : #'t - orientable orientation' }
TToOrientable >> beVertical [

	self isVertical ifTrue: [ ^ self ].
	self horizontal: false
]

{ #category : #accessing }
TToOrientable >> direction [

	^ self layout direction
]

{ #category : #accessing }
TToOrientable >> direction: aDirection [

	self layout direction: aDirection.
	self requestLayout
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
	self requestLayout
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

	self layout orientation: aBlLayoutOrientation.
	self requestLayout
]

{ #category : #'t - orientable direction' }
TToOrientable >> whenDirectionChangedDo: aBlock [

	self layout whenDirectionChangedDo: aBlock
]

{ #category : #'t - orientable orientation' }
TToOrientable >> whenOrientationChangedDo: aBlock [

	self layout whenOrientationChangedDo: aBlock
]
