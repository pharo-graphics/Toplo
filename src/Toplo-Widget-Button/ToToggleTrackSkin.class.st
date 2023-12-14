Class {
	#name : 'ToToggleTrackSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-Button-Switch',
	#package : 'Toplo-Widget-Button',
	#tag : 'Switch'
}

{ #category : 'as yet unclassified' }
ToToggleTrackSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
		e background: (e isChecked
				 ifTrue: [ e tokenValueNamed: #'color-primary' ]
				 ifFalse: [ e tokenValueNamed: #'color-bg-container' ]).
		e layout: BlLinearLayout new.
		e padding: (BlInsets all: 2).
		e innerButton size: 16 asPoint.
		e innerButton background: Color white.
		e innerButton margin: (BlInsets left: 4 right: 4) ]
]
