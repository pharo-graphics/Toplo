Class {
	#name : 'ToListPrimarySelectionElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'event handling' }
ToListPrimarySelectionElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e tokenValueNamed: #'color-primary-selection-focused') ]
]

{ #category : 'event handling' }
ToListPrimarySelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry:
			((e tokenValueNamed: #'primary-selection-geometry-class')
				 cornerRadius: (e tokenValueNamed: #'border-radius-SM')).
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'border-color-primary-selection')
				 width: (e tokenValueNamed: #'border-width-primary-selection')).
		e background:
			(e tokenValueNamed: #'color-primary-selection-unfocused').
		e padding: (BlInsets
				 horizontal: (e tokenValueNamed: #'list-padding-H')
				 vertical: (e tokenValueNamed: #'list-padding-V')) ]
]

{ #category : 'event handling' }
ToListPrimarySelectionElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e tokenValueNamed: #'color-primary-selection-unfocused') ]
]
