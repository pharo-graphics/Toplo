Trait {
	#name : #TToOrientable,
	#category : #'Toplo-Core'
}

{ #category : #'t - widget orientation' }
TToOrientable >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'t - widget orientation' }
TToOrientable >> beVertical [

	self horizontal: false
]

{ #category : #'t - widget orientation' }
TToOrientable >> horizontal [

	^ self layout isHorizontal
]

{ #category : #'t - widget orientation' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout.
	self orientationChanged
]

{ #category : #initialization }
TToOrientable >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - widget orientation' }
TToOrientable >> isHorizontal [

	^ self horizontal
]

{ #category : #'t - widget orientation' }
TToOrientable >> orientation [

	^ self layout orientation
]

{ #category : #'t - widget orientation' }
TToOrientable >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout.
	self orientationChanged
]

{ #category : #'t - widget orientation' }
TToOrientable >> orientationChanged [

	self announce: (ToOrientationChanged new widget: self)
]

{ #category : #'t - widget orientation' }
TToOrientable >> whenOrientationChangedDo: aBlock [

	self whenAnnouncement: ToOrientationChanged do: aBlock
]
