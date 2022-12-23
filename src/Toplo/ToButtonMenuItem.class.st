Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToButton + TToWidgetWithState',
	#classTraits : 'TToButton classTrait + TToWidgetWithState classTrait',
	#instVars : [
		'#label',
		'#icon',
		'#leftColumnWidth',
		'#rowLayingOut'
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
	self icon whenInnerImageReplacedDo: [ self announce: ToMenuPresentationChangedAnnouncement new ].
	self label whenTextReplacedDo:[ self announce: ToMenuPresentationChangedAnnouncement new ].
	self whenLabelFirstChangedDo: [ self announce: ToMenuPresentationChangedAnnouncement new ].
	self whenJustifiedChangedDo: [ self announce: ToMenuPresentationChangedAnnouncement new ].

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

{ #category : #'t - button initialization' }
ToButtonMenuItem >> rowLayingOut [

	^ rowLayingOut 
]

{ #category : #'t - button initialization' }
ToButtonMenuItem >> rowLayingOut: aListOfElements [

	rowLayingOut := aListOfElements.
	self privateUpdateRowLayingOut 
]

{ #category : #accessing }
ToButtonMenuItem >> withoutLeftColumn [

	self leftColumnWidth: 0
]
