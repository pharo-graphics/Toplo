Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckable + TToCheckableWithIndeterminate',
	#classTraits : 'TToCheckable classTrait + TToCheckableWithIndeterminate classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToCheckMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToCheckBoxDresser new)
]
