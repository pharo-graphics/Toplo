Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLabeled + TToWidgetWithState',
	#classTraits : 'TToLabeled classTrait + TToWidgetWithState classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToButtonMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	self isJustified ifFalse: [ 
		self leftColumnWidth > 0 ifFalse: [ 
			self leftColumnWidth: aMenu globalLeftColumnWidth ] ]
]

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> defaultDresser [ 

	^ ToBasicMenuItemDresser next: (ToButtonMenuItemDresser new)
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [

	self class initializeSlots: self.
	super initialize.

	self initializeLabeled.
	"horizontal matchParent required here ** after ** initializeButton ( because of the #fitContent sent)"
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	self initializeDresser
]
