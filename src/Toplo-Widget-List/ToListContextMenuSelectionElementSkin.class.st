Class {
	#name : #ToListContextMenuSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : 'Toplo-Widget-List-Context-menu'
}

{ #category : #'event handling' }
ToListContextMenuSelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry:
			((e tokenValueNamed: #'primary-selection-geometry-class')
				 cornerRadius: (e tokenValueNamed: #'border-radius-SM')).
		e inner geometry:
			((e tokenValueNamed: #'primary-selection-geometry-class')
				 cornerRadius: (e tokenValueNamed: #'border-radius-SM')).
		e inner border: (BlBorder paint: Color white width: 2).
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'border-color-primary-selection')
				 width: (e tokenValueNamed: #'border-width-primary-selection')).
		e padding: (BlInsets
				 horizontal: (e tokenValueNamed: #'list-padding-H')
				 vertical: (e tokenValueNamed: #'list-padding-V')) ]
]
