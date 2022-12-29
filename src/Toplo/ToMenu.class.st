Class {
	#name : #ToMenu,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToMenu',
	#classTraits : 'TToMenu classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToMenu >> defaultDresser [

	^ ToBasicMenuItemDresser next: ToMenuDresser new
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.

	self initializeMenu.
	self menuWindow  widget: self.
	self whenClickedDo: [ self popupOrClose ].

]

{ #category : #'t - menu initialization' }
ToMenu >> menuWindowClass [

	^ ToMenuWindow
]
