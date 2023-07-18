Class {
	#name : #ToToogleTrackLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'event handling' }
ToToogleTrackLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| onWidth offWidth pWidth |
		onWidth := 0.
		offWidth := 0.
		pWidth := e pusher width.
		e onElement ifNotNil: [ :o | onWidth := o width ].
		e offElement ifNotNil: [ :o | offWidth := o width ].
		e width: ((pWidth + (onWidth max: offWidth)) max: 35)]
]
