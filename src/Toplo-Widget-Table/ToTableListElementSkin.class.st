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
			pad := BlInsets empty.
			e haveVisibleScrollbar ifTrue: [
					pad := e isVertical
						       ifTrue: [
						       pad withRight:
							       (e valueOfTokenNamed: #'scrollbar-breadth') + 4 ]
						       ifFalse: [
						       pad withBottom:
							       (e valueOfTokenNamed: #'scrollbar-breadth') + 4 ] ].
			e padding: pad ]
]
