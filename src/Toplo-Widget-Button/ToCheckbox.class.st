Class {
	#name : 'ToCheckbox',
	#superclass : 'ToButton',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'group',
		'checked',
		'withIndeterminate'
	],
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 'skin' }
ToCheckbox >> defaultBlankCheckboxImage [

	^ (self tokenValue: #'checkbox-image-builder') value
]

{ #category : 'skin' }
ToCheckbox >> defaultBorder [ 

	^ self tokenValue: #'color-border-checkable'
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
ToCheckbox >> newRawSkin [ 

	^ ToCheckboxSkin new
]

{ #category : 'skin' }
ToCheckbox >> pressedBorder [ 

	^ self defaultBorder
]

{ #category : 't - checkable - accessing' }
ToCheckbox >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : 't - checkable - accessing' }
ToCheckbox >> rawChecked: anObject [

	checked := anObject
]

{ #category : 't - checkable - group' }
ToCheckbox >> rawGroup [

	^ group
]

{ #category : 't - checkable - group' }
ToCheckbox >> rawGroup: aGroup [

	group = aGroup ifNil: [ ^ self ].
	group := aGroup
]

{ #category : 'skin' }
ToCheckbox >> uninstallRawStyle [

	super uninstallRawStyle.
	self icon: nil
]

{ #category : 't - checkable  - protocol' }
ToCheckbox >> withIndeterminate [

	^ withIndeterminate ifNil: [ withIndeterminate:= false ]
]

{ #category : 't - checkable  - protocol' }
ToCheckbox >> withIndeterminate: aBoolean [

	withIndeterminate:= aBoolean
]
