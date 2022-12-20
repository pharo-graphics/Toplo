Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLayoutableButton + TToWidgetWithState',
	#classTraits : 'TToLayoutableButton classTrait + TToWidgetWithState classTrait',
	#instVars : [
		'#label',
		'#icon',
		'#rowLayout',
		'#leftColumnWidth'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToButtonMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	aMenu globalLeftColumnWidth isZero ifTrue: [^ self ].
	self leftColumnWidth = self defaultLeftColumnWidth ifFalse: [ ^ self ].
	self leftColumnWidth: aMenu globalLeftColumnWidth
]

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> defaultDresser [ 

	^ ToBasicMenuItemDresser next: (ToButtonMenuItemDresser next: ToMenuItemRowDresser new)
]

{ #category : #initialization }
ToButtonMenuItem >> defaultLeftColumnWidth [

	^ -1 
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
ToButtonMenuItem >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	leftColumnWidth := self defaultLeftColumnWidth.
	self initializeButton.
	"horizontal matchParent required here ** after ** initializeButton "
	self constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical fitContent ].
	self whenPresentationChangedDo: [ self announce: ToMenuPresentationChangedAnnouncement new ].
	self initializeClickBehavior.
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

{ #category : #accessing }
ToButtonMenuItem >> leftColumnWidth [

	^ leftColumnWidth 
]

{ #category : #accessing }
ToButtonMenuItem >> leftColumnWidth: anInteger [

	leftColumnWidth := anInteger.
	self announce: ToMenuPresentationChangedAnnouncement new
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

{ #category : #accessing }
ToButtonMenuItem >> withoutLeftColumn [

	self leftColumnWidth: 0
]
