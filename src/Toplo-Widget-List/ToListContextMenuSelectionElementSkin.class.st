Class {
	#name : #ToListContextMenuSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #'event handling' }
ToListContextMenuSelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry:
			((e valueOfTokenNamed: #'primary-selection-geometry-class')
				 cornerRadius: (e valueOfTokenNamed: #'border-radius-SM')).
		e inner geometry:
			((e valueOfTokenNamed: #'primary-selection-geometry-class')
				 cornerRadius: (e valueOfTokenNamed: #'border-radius-SM')).
		e inner border: (BlBorder paint: Color white width: 2).
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'border-color-primary-selection')
				 width: (e valueOfTokenNamed: #'border-width-primary-selection')).
		e padding: (BlInsets all: (e valueOfTokenNamed: #'list-context-menu-selection-border-gap')) ]
]
