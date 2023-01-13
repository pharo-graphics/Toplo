Class {
	#name : #ToTextFieldDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - install/uninstall  hook' }
ToTextFieldDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	anElement padding: (BlInsets empty).
	anElement margin: (BlInsets empty).
	anElement margin: (BlInsets all: 2).
	anElement padding: (BlInsets empty).

	anElement addEventHandler: (BlEventHandler
				on: BlMouseDownEvent 
				do: [ :evt | anElement infinite dispatchEvent: evt ]).

	anElement infinite
		when: BlBlurEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: anElement theme editor borderColor
					 width: 1) ].

	anElement infinite
		when: BlFocusEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: anElement theme editor focusedBorderColor
					 width: 1) ].

	anElement border: (BlBorder
			 paint: anElement theme editor borderColor
			 width: 1).

	anElement innerElement background: Color white
]
