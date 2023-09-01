Class {
	#name : #ToSelectItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Select'
}

{ #category : #'t - initialization dresser' }
ToSelectItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToSelectItemDresser next: ToTripletDresser new)
]

{ #category : #'as yet unclassified' }
ToSelectItem >> initialize [

	super initialize.
	self initializeCheckable.
	self whenClickedDo: [ self switchToNextState ] 
]
