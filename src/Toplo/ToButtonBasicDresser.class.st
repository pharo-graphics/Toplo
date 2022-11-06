Class {
	#name : #ToButtonBasicDresser,
	#superclass : #ToElementCompanion,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - hooks' }
ToButtonBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	anElement border: (BlBorder empty).
	anElement padding: (BlInsets top: 0 left: 0 bottom: 0 right: 2 ).

	anElement 
		when: BlMouseEnterEvent 
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: Color gray
					 width: 1) ].
	anElement 
		when: BlMouseLeaveEvent 
		do: [ :anEvent | 
			anElement border: BlBorder empty]
]
