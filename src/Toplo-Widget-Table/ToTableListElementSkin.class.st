Class {
	#name : #ToTableListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'event handling' }
ToTableListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| pad |
			" the padding should be empty if no scrollbar "
			pad := e padding.
			pad := pad withRight:
				       pad right - (e valueOfTokenNamed: #'list-padding-H').
			pad := pad withLeft:
				       pad left - (e valueOfTokenNamed: #'list-padding-H').
			pad := pad withTop:
				       pad top - (e valueOfTokenNamed: #'list-padding-V').
			pad := pad withBottom:
				       pad bottom - (e valueOfTokenNamed: #'list-padding-V').
			e padding: pad ]
]
