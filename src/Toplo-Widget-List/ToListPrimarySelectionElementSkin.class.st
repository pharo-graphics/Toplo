Class {
	#name : 'ToListPrimarySelectionElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-List-Selection',
	#package : 'Toplo-Widget-List',
	#tag : 'Selection'
}

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
		" I must take into account the focused state of the infinite element to start with the right background "
		e listElement infinite focused
			ifTrue: [ 
				e background: (e tokenValueNamed: #'color-primary-selection-focused') ]
			ifFalse: [
				e background: (e tokenValueNamed: #'color-primary-selection-unfocused') ].
		e padding: (BlInsets
				 horizontal: (e tokenValueNamed: #'list-padding-H')
				 vertical: (e tokenValueNamed: #'list-padding-V')) ]
]
