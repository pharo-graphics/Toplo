Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLayoutableButton',
	#classTraits : 'TToLayoutableButton classTrait',
	#instVars : [
		'label',
		'icon',
		'iconColumnFill',
		'iconColumnWidth',
		'labelColumnFill'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - button initialization' }
ToButtonMenuItem >> childrenLayout [

	^ (self isLabelFirst
		   ifTrue: [ 
			   { 
				   self label.
				   labelColumnFill.
				   self icon } ]
		   ifFalse: [ 
			   { 
				   self icon.
				   iconColumnFill.
				   labelColumnFill.
				   self label } ]) select: #notNil
]

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> defaultDresser [ 

	^ ToBasicMenuItemDresser next: ToButtonMenuItemDresser new
]

{ #category : #initialization }
ToButtonMenuItem >> defaultIconColumnWidth [

	^ 20 
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> icon [

	^ icon
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> icon: anImage [

	icon := anImage 
]

{ #category : #initialization }
ToButtonMenuItem >> iconColumnWidth [

	^ iconColumnWidth 
]

{ #category : #initialization }
ToButtonMenuItem >> iconColumnWidth: anInteger [

	iconColumnWidth := anInteger
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [

	super initialize.
	
	iconColumnWidth := self defaultIconColumnWidth.
	self initializeButton.
	"horizontal matchParent required here ** after ** initializeButton "
	self constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical fitContent ].
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

{ #category : #initialization }
ToButtonMenuItem >> shouldCheckIconColumnFill [ 

	^ self isIconFirst
	
]

{ #category : #initialization }
ToButtonMenuItem >> updateFilling [

	| w |
	" first the label column only if it is justified "
	(labelColumnFill isNil and: [ self isLayoutJustified ]) ifTrue: [ 
		labelColumnFill := self privateMatchParentFill.
		self privateUpdateChildren ].

	" then check the icon column "
	self shouldCheckIconColumnFill ifFalse: [ ^ self ].

	" check if there a need to fill after the icon  "
	(w := self iconColumnWidth - self iconImage width) > 0 ifFalse: [ 
		^ self ].

	" ok, now measure the gap "
	iconColumnFill ifNotNil: [ " adapt the existing fill "
		iconColumnFill width = w ifTrue: [ ^ self ].
		iconColumnFill constraintsDo: [ :c | c horizontal exact: w ].
		self privateUpdateChildren.
		^ self ].

	" first check, create the fill"
	iconColumnFill := BlElement new size: w @ 0.
	self privateUpdateChildren
]
