Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToPair + TToLabeledIcon + TToOrientable + TToWidgetWithState',
	#classTraits : 'TToPair classTrait + TToLabeledIcon classTrait + TToOrientable classTrait + TToWidgetWithState classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToButtonMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	self isJustified ifFalse: [ 
		self columnWidth > 0 ifFalse: [ 
			self columnWidth: aMenu globalColumnWidth ] ]
]

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> defaultDresser [ 

	^ ToBasicMenuItemDresser next: (ToButtonMenuItemDresser new)
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [

	self class initializeSlots: self.
	super initialize.

	self initializePair.
	"horizontal matchParent required here ** after ** initializeButton ( because of the #fitContent sent)"
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

	self initializeDresser
]
