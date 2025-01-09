Class {
	#name : #ToWorkingCollapseElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Collapse'
}

{ #category : #'event handling' }
ToWorkingCollapseElementSkin >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]

{ #category : #'event handling' }
ToWorkingCollapseElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]
