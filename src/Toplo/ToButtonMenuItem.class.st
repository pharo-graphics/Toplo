Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToPair + TToLabeledIcon + TToOrientable',
	#classTraits : 'TToPair classTrait + TToLabeledIcon classTrait + TToOrientable classTrait',
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

{ #category : #'t - skin accessing' }
ToButtonMenuItem >> defaultSkin [ 

	^ ToButtonSkin new
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [ 

	super initialize.

]

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> preInitializeDresser [ 

	super preInitializeDresser.

	self initializePair.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

]
