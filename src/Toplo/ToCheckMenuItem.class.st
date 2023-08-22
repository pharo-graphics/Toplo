Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToCheckMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToCheckableButtonDresser new)
]

{ #category : #'t - skinable - initialization' }
ToCheckMenuItem >> defaultSkin [ 

	^ ToCheckboxItemSkin new
]

{ #category : #'as yet unclassified' }
ToCheckMenuItem >> initialize [

	super initialize.
	self initializeCheckable 
]
