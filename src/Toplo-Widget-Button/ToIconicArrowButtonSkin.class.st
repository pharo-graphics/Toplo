Class {
	#name : #ToIconicArrowButtonSkin,
	#superclass : #ToIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'event handling' }
ToIconicArrowButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tk |
		tk := e isUp
			      ifTrue: [ #'iconic-arrow-up' ]
			      ifFalse: [
				      e isRight
					      ifTrue: [ #'iconic-arrow-right' ]
					      ifFalse: [ #'iconic-arrow-down' ] ].
		e innerImage: (e valueOfTokenNamed: tk).
		e size: (e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint ]
]
