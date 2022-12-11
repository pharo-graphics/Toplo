Trait {
	#name : #TToOrientableButton,
	#traits : 'TToButton',
	#classTraits : 'TToButton classTrait',
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

	^ self buttonPane layout isHorizontal
]

{ #category : #'t - button orientation' }
TToOrientableButton >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self buttonPane layout beHorizontal ]
		ifFalse: [ self buttonPane layout beVertical ].
	self buttonPane requestLayout   
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

	^ self buttonPane layout orientation
]

{ #category : #'t - button orientation' }
TToOrientableButton >> orientation: aBlLayoutOrientation [

	self buttonPane layout orientation: aBlLayoutOrientation.
	self buttonPane requestLayout 
]

{ #category : #'t - button private' }
TToOrientableButton >> privateFill [

	| e |
	e := ToElement new id: #fill.
	self isHorizontal
		ifTrue: [ 
			e vExact: 4.
			e hMatchParent ]
		ifFalse: [ 
			e hExact: 4.
			e vMatchParent ].
	^ e
]
