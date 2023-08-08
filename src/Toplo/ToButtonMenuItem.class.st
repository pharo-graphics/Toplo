Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#instVars : [
		'#icon => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#extra => ToSkinnableSlot'
	],
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

{ #category : #'t - triplet accessing' }
ToButtonMenuItem >> first [

	^ icon
]

{ #category : #'t - triplet accessing' }
ToButtonMenuItem >> first: anElement [

	icon := anElement
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [ 

	super initialize.
	self initializeTriplet
]

{ #category : #'t - initialization dresser' }
ToButtonMenuItem >> preInitializeDresser [ 

	super preInitializeDresser.

	self initializeTriplet.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

]

{ #category : #'t - triplet accessing' }
ToButtonMenuItem >> second [

	^ label
]

{ #category : #'t - triplet accessing' }
ToButtonMenuItem >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet accessing' }
ToButtonMenuItem >> third [

	^ extra
]

{ #category : #'t - triplet accessing' }
ToButtonMenuItem >> third: anElement [

	extra := anElement

]
