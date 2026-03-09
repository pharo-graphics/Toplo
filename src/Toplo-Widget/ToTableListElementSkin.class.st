Class {
	#name : #ToTableListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-Table'
}

{ #category : #'event handling' }
ToTableListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| pad |
			" the padding should be empty if no scrollbar "
			pad := BlInsets empty.
			e haveVisibleScrollbar ifTrue: [
					| gap |
					gap := (e valueOfTokenNamed: #'scrollbar-breadth')
					       +
					       (2 * (e valueOfTokenNamed: #'scrollbar-padding-breadth')).
					pad := e isVertical
						       ifTrue: [ pad withRight: gap ]
						       ifFalse: [ pad withBottom: gap ] ].
			e padding: pad ]
]
