Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #skin }
ToCheckbox >> defaultBlankCheckboxImage [

	| bar im |
	bar := ToElement new id: #bar.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 4.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	im := ToElement new.
	im layout: BlFrameLayout new.
	im size: 16 asPoint.
	im addChild: bar.
	im geometry: (BlRoundedRectangleGeometry cornerRadius: 4) .
	im margin: (BlInsets left: 2 right: 2).
	^ im
]

{ #category : #initialization }
ToCheckbox >> defaultBorder [ 

	^ BlBorder empty
]

{ #category : #initialization }
ToCheckbox >> defaultEventHandler [ 

	^ ToCheckableEventHandler new 
]

{ #category : #initialization }
ToCheckbox >> hoveredBorder [ 

	^ self defaultBorder
]

{ #category : #skin }
ToCheckbox >> initializeRawStyle [ 

	super initializeRawStyle.
	self iconImage: self defaultBlankCheckboxImage 

	
]

{ #category : #initialization }
ToCheckbox >> pressedBorder [ 

	^ self defaultBorder
]

{ #category : #skin }
ToCheckbox >> rawSkin [ 

	^ ToCheckboxSkin new
]
