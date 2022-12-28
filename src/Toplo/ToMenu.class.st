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

{ #category : #accessing }
ToMenu >> layingOut [ 
	self isSubmenu ifTrue: [ 
		^ { 
			  self element.
			  interspace.
			  self label.
			  self privateJustificationFill.
			  self rightIcon } select: #notNil ].

	^ super layingOut
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
			               constraintsDo: [ :c | 
				               c linear vertical alignCenter.
				               c linear horizontal alignCenter ];
			               in: [ :im | im layout alignCenterRight ];
			               yourself ]
]
