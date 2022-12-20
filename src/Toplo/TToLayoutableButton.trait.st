Trait {
	#name : #TToLayoutableButton,
	#instVars : [
		'#labelFirst => ObservableSlot'
	],
	#traits : 'TToButton',
	#classTraits : 'TToButton classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button orientation' }
TToLayoutableButton >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> beIconFirst [

	self labelFirst: false
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> beLabelFirst [

	self labelFirst: true
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> beVertical [

	self horizontal: false
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> horizontal [

	^ self layout isHorizontal
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout   
]

{ #category : #initialization }
TToLayoutableButton >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> isHorizontal [

	^ self horizontal
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> isLabelFirst [
	
	^ self labelFirst
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ] 
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self privateUpdateChildren.
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> orientation [

	^ self layout orientation
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout 
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> whenPresentationChangedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #labelFirst whenChangedDo: aBlock
]
