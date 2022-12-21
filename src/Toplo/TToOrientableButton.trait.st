Trait {
	#name : #TToOrientableButton,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button orientation' }
TToOrientableButton >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'t - button orientation' }
TToOrientableButton >> beVertical [

	self horizontal: false
]

{ #category : #'t - button orientation' }
TToOrientableButton >> horizontal [

	^ self layout isHorizontal
]

{ #category : #'t - button orientation' }
TToOrientableButton >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout   
]

{ #category : #initialization }
TToOrientableButton >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - button orientation' }
TToOrientableButton >> isHorizontal [

	^ self horizontal
]

{ #category : #'t - button orientation' }
TToOrientableButton >> orientation [

	^ self layout orientation
]

{ #category : #'t - button orientation' }
TToOrientableButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout 
]
