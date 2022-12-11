Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToButton',
	#classTraits : 'TToButton classTrait',
	#instVars : [
		'label',
		'menuItemIcon'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToButtonMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.

]

{ #category : #'t - button initialization' }
ToButtonMenuItem >> childrenLayout [

	^ { 
		  self icon.
		  self label.
		  self privateFill.
		  }
]

{ #category : #initialization }
ToButtonMenuItem >> emptyIconImage [

	^ BlElement new size: 16@16;background: Color transparent; 
		constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ];
		yourself.
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> icon [

	^ menuItemIcon
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> icon: anImage [

	menuItemIcon := anImage 
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [

	super initialize.
	
	self initializeButton.
	"horizontal matchParent required here ** after ** initializeButton "
	self constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical fitContent ].
	self iconImage: self emptyIconImage.
	
	self initializeDresser 
	
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> label [

	^ label
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> label: aLabel [

	label := aLabel
	
]

{ #category : #window }
ToButtonMenuItem >> menuWindow [

	^ nil
]
