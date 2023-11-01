Class {
	#name : 'ToCheckbox',
	#superclass : 'ToButton',
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 'skin' }
ToCheckbox >> defaultBlankCheckboxImage [

	| bar im |
	bar := ToElement new id: #bar.
	bar withoutSkin.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 3.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	bar margin: (BlInsets left: 2 right: 2).
	bar geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	im := ToElement new.
	im layout: BlFrameLayout new.
	im size: 16 asPoint.
	im addChild: bar.
	im geometry: self iconGeometry.
	im withoutSkin.
	^ im
]

{ #category : 'skin' }
ToCheckbox >> defaultBorder [ 

	^ BlBorder empty
]

{ #category : 'skin' }
ToCheckbox >> defaultImageBorder [

	^ self defaultImageColor
]

{ #category : 'skin' }
ToCheckbox >> defaultImageColor [

	^ Color blue
]

{ #category : 'skin' }
ToCheckbox >> hoveredBorder [ 

	^ self defaultBorder
]

{ #category : 'skin' }
ToCheckbox >> iconDefaultBorder [ 

	^ BlBorder paint: (Color lightGray alpha: 0.2) width: 1
]

{ #category : 'skin' }
ToCheckbox >> iconGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : 'skin' }
ToCheckbox >> iconHoveredBorder [ 

	^ BlBorder paint: (Color lightGray) width: 1
]

{ #category : 'skin' }
ToCheckbox >> imageCheckedBorder [ 

	^ BlBorder paint: self defaultImageBorder width: 6
]

{ #category : 'skin' }
ToCheckbox >> imageIndeterminateBorder [ 

	^ BlBorder paint: self defaultImageBorder width: 0
]

{ #category : 'skin' }
ToCheckbox >> imageUncheckedBorder [ 

	^ BlBorder paint: self defaultImageBorder width: 0
]

{ #category : 'skin' }
ToCheckbox >> indeterminateChild [

	^ self iconImage childWithId: #bar
]

{ #category : 'skin' }
ToCheckbox >> installRawStyle [

	super installRawStyle.

	self iconImage: self defaultBlankCheckboxImage.
	self icon geometry: self iconGeometry
]

{ #category : 'skin' }
ToCheckbox >> pressedBorder [ 

	^ self defaultBorder
]

{ #category : 'skin' }
ToCheckbox >> rawSkin [ 

	^ ToCheckboxSkin new
]
