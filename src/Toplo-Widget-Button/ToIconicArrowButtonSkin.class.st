Class {
	#name : #ToIconicArrowButtonSkin,
	#superclass : #ToStandardIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'event handling' }
ToIconicArrowButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| tk inner |
			inner := BlElement new.
			e isNone ifFalse: [
					tk := e isUp
						      ifTrue: [ #'iconic-arrow-up' ]
						      ifFalse: [
								      e isDown
									      ifTrue: [ #'iconic-arrow-down' ]
									      ifFalse: [
											      e isRight
												      ifTrue: [ #'iconic-arrow-right' ]
												      ifFalse: [ #'iconic-arrow-left' ] ] ].
					inner := e valueOfTokenNamed: tk ].
			e innerImage: inner.
			e extent: (e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint ]
]
