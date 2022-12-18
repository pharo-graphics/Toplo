Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLayoutableButton',
	#classTraits : 'TToLayoutableButton classTrait',
	#instVars : [
		'label',
		'menuItemIcon',
		'ensureIconLeftAlignment'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> defaultDresser [ 

	^ ToButtonMenuItemDresser new
]

{ #category : #initialization }
ToButtonMenuItem >> emptyIconImage [

	^ BlElement new
		  id: #'empty-icon-image';
		  size: 16 @ 16;
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c linear vertical alignCenter.
			  c linear horizontal alignCenter ];
		  yourself
]

{ #category : #initialization }
ToButtonMenuItem >> emptyIconImageExtent [

	^ 16 @ 16
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> ensureIconLeftAlignment [

	^ ensureIconLeftAlignment ifNil: [ ensureIconLeftAlignment := true ]
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> ensureIconLeftAlignment: aBoolean [

	ensureIconLeftAlignment := aBoolean.
	aBoolean
		ifTrue: [ 
			self icon ifNil: [ 
				self icon: ToImage new.
				self iconImage size: self emptyIconImageExtent  ] ]
		ifFalse: [ self icon hasInnerImage ifFalse: [ self icon: nil ] ].

	self privateUpdateChildren
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
	self iconImage size: self emptyIconImageExtent.
	
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
