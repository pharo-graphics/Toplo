Class {
	#name : #ToTextFieldDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - hooks' }
ToTextFieldDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	anElement innerElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	anElement padding: (BlInsets all: 1).

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
					 width: 2) ].

	anElement border: (BlBorder
			 paint: anElement theme editor borderColor
			 width: 1).

	anElement innerElement background: Color white
]

{ #category : #'api - hooks' }
ToTextFieldDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]
