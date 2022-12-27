Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLabeled + TToWidgetWithState',
	#classTraits : 'TToLabeled classTrait + TToWidgetWithState classTrait',
	#instVars : [
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

	" -1 means no default "
	^ -1 
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	leftColumnWidth := self defaultLeftColumnWidth.
	self initializeLabeled.
	"horizontal matchParent required here ** after ** initializeButton ( because of the #fitContent sent)"
	self constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical fitContent ].
	self whenLabelFirstChangedDo: [ self announcePresentationChanged ].
	self whenJustifiedChangedDo: [ self announcePresentationChanged ].

	self initializeDresser

]

{ #category : #accessing }
ToButtonMenuItem >> leftColumnWidth [

	^ leftColumnWidth 
]

{ #category : #accessing }
ToButtonMenuItem >> leftColumnWidth: anInteger [

	leftColumnWidth := anInteger.
	self announce: ToLabeledPresentationChangedAnnouncement new
]

{ #category : #'t - labeled initialization' }
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
