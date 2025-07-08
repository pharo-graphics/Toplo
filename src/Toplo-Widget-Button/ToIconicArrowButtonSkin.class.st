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
						      e isDown
							      ifTrue: [ #'iconic-arrow-down' ]
							      ifFalse: [
									      e isRight
										      ifTrue: [ #'iconic-arrow-right' ]
										      ifFalse: [ #'iconic-arrow-left' ] ] ].
			e innerImage: (e valueOfTokenNamed: tk).
			e extent: (e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint ]
]
