Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLabelAndIconWithSkinHolder',
	#classTraits : 'TToLabelAndIconWithSkinHolder classTrait',
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

	^ nil
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [ 

	super initialize.
	self initializeLabeledIconWithSkin

]

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> preInitializeDresser [ 

	super preInitializeDresser.

	self initializeTriplet.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

]
