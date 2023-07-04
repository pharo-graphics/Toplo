Class {
	#name : #ToButtonLinkLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #private }
ToButtonLinkLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  width: 0;
		  yourself
]

{ #category : #testing }
ToButtonLinkLook >> hasBackground [

	^ false
]

{ #category : #'event handling' }
ToButtonLinkLook >> hoverStateEvent: anEvent [

	super hoverStateEvent: anEvent.
	"anEvent elementDo: [ :e |
		e background: Color transparent ]."

]

{ #category : #'event handling' }
ToButtonLinkLook >> initialStateEvent: anEvent [

	super initialStateEvent: anEvent.
"	anEvent elementDo: [ :e |
		e background: Color transparent ].
"
]

{ #category : #'event handling' }
ToButtonLinkLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
"	anEvent elementDo: [ :e |
		e background: Color transparent ].
"
]

{ #category : #'event handling' }
ToButtonLinkLook >> pressedStateEvent: anEvent [

	super pressedStateEvent: anEvent.
	"anEvent elementDo: [ :e |
		e background: Color transparent ].
"
]
