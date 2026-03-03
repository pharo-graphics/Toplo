Trait {
	#name : #TToOrientable,
	#category : #'Toplo-Core'
}

{ #category : #'t - orientable' }
TToOrientable >> beHorizontal [

	self horizontal: true
]

{ #category : #'t - orientable' }
TToOrientable >> beVertical [

	self vertical: true
]

{ #category : #'t - orientable' }
TToOrientable >> horizontal: aBoolean [

	aBoolean
		ifTrue: [
			self isHorizontal ifTrue: [ ^ self ].
			self layout beHorizontal ]
		ifFalse: [
			self isVertical ifTrue: [ ^ self ].
			self layout beVertical ].
	self requestConfiguration.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestNewSkin
]

{ #category : #'t - orientable' }
TToOrientable >> isHorizontal [

	^ self layout isHorizontal
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
TToOrientable >> orientation [

	^ self layout orientation
]

{ #category : #'t - orientable' }
TToOrientable >> orientation: aBlLayoutOrientation [

	self layout orientation = aBlLayoutOrientation ifTrue: [ ^ self ].
	self layout orientation: aBlLayoutOrientation.
	self requestConfiguration.
	self dispatchEvent: ToLayoutOrientationChangedEvent new.
	self requestNewSkin 
]

{ #category : #'t - orientable' }
TToOrientable >> vertical: aBoolean [

	self horizontal: aBoolean not
]
