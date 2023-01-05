Class {
	#name : #ToTextFieldDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - install/uninstall  hook' }
ToTextFieldDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	anElement innerElement geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	anElement padding: (BlInsets all: 0).
	anElement margin: (BlInsets all: 0).
	anElement innerElement margin: (BlInsets all: 2).
	anElement innerElement padding: (BlInsets all: 0).

	anElement addEventHandler: (BlEventHandler
				on: BlMouseDownEvent 
				do: [ :evt | anElement innerElement dispatchEvent: evt ]).

	anElement innerElement
		when: BlBlurEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: anElement theme editor borderColor
					 width: 1) ].

	anElement innerElement
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
