Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToCheckMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToCheckableButtonDresser next: ToTripletDresser new)
]

{ #category : #'t - skinable - initialization' }
ToCheckMenuItem >> defaultSkin [ 

	^ ToCheckboxItemSkin new
]

{ #category : #initialization }
ToCheckMenuItem >> initialize [

	super initialize.
	self initializeCheckable 
]
