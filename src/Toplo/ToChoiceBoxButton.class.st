Class {
	#name : #ToChoiceBoxButton,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToMenu',
	#classTraits : 'TToMenu classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - initialization dresser' }
ToChoiceBoxButton >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToChoiceBoxButtonDresser new)
]

{ #category : #initialization }
ToChoiceBoxButton >> initialize [

	super initialize.

	self initializeMenu.
	self menuWindow  widget: self.
	self whenClickedDo: [ self popupOrClose ].

]

{ #category : #'t - menu initialization' }
ToChoiceBoxButton >> menuWindowClass [

	^ ToMenuWindow
]
