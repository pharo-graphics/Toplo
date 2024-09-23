Class {
	#name : #ToTraceListPrimarySelectionElementSkin,
	#superclass : #ToListBasicSelectionElementSkin,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToTraceListPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| color traceSelectionModel |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')).
		e border: BlBorder empty.
		traceSelectionModel := e listElement userData at:
			                       #traceSelectionModel.
		" since the selection option is separate, e nodes size is always 1 "
		(traceSelectionModel containsIndex: e nodes anyOne holder position)
			ifTrue: [ color := Color red ]
			ifFalse: [
			color := e valueOfTokenNamed: #'color-primary-selection-focused' ].
		e background: color ]
]
