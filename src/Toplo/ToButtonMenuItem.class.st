Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLayoutableButton + TToWidgetWithState',
	#classTraits : 'TToLayoutableButton classTrait + TToWidgetWithState classTrait',
	#instVars : [
		'label',
		'icon',
		'iconColumnWidth',
		'rowLayout'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> defaultDresser [ 

	^ ToBasicMenuItemDresser next: (ToButtonMenuItemDresser next: ToMenuItemRowDresser new)
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

{ #category : #accessing }
ToButtonMenuItem >> iconColumnWidth [

	^ iconColumnWidth 
]

{ #category : #accessing }
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
	self initializeClickBehavior.
	self initializeDresser.

]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> label [

	^ label
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> label: aLabel [

	label := aLabel
	
]

{ #category : #'t - button private' }
ToButtonMenuItem >> privateUpdateChildren [

	| subs |
	self removeChildren.
	subs := self rowLayout.
	subs ifNil: [ ^ self ].
	subs do: [ :s | 
		s constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].
	self addChildren: subs
]

{ #category : #'t - button initialization' }
ToButtonMenuItem >> rowLayout [

	^ rowLayout 
]

{ #category : #'t - button initialization' }
ToButtonMenuItem >> rowLayout: aListOfElements [

	rowLayout := aListOfElements.
	self privateUpdateChildren 
]
