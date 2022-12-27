Class {
	#name : #ToMenu,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToMenu',
	#classTraits : 'TToMenu classTrait',
	#instVars : [
		'rightIcon'
	],
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

{ #category : #accessing }
ToMenu >> rightIcon [

	^ rightIcon ifNil: [ 
		  rightIcon := (ToImage inner: self rightIconImage)
			               hExact: 15;
			               in: [ :im | im layout alignCenterRight ];
			               yourself ]
]

{ #category : #accessing }
ToMenu >> rowLayingOut [ 
	self isSubmenu ifTrue: [ 
		^ { 
			  self element.
			  interspace.
			  self label.
			  self privateMatchParentFill.
			  self rightIcon } select: #notNil ].

	^ super rowLayingOut
]
