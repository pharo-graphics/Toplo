Class {
	#name : 'ToListPrimarySelectionElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-List-Selection',
	#package : 'Toplo-Widget-List',
	#tag : 'Selection'
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
		" I must take into account the focused state of the infinite element to start with the right background.
		If not done like that, then it works because the right state is applied after but with a flashing selection 
		background in case of extent change or in case of scrolling.
		(as an example, if the default is focused background and if the infinite state is unfocused) "
		e listElement infinite focused
			ifTrue: [ 
				e background: (e tokenValueNamed: #'color-primary-selection-focused') ]
			ifFalse: [
				e background: (e tokenValueNamed: #'color-primary-selection-unfocused') ].
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
