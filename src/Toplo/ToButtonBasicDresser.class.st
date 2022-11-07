Class {
	#name : #ToButtonBasicDresser,
	#superclass : #ToElementCompanion,
	#instVars : [
		'downBorder',
		'initialBorder'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - hooks' }
ToButtonBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	anElement border: BlBorder empty.
	anElement padding: (BlInsets
			 top: 0
			 left: 0
			 bottom: 0
			 right: 2).

	downBorder := nil.
	initialBorder := anElement border.
	
	"
	updating initialBorder do not work with the following : 
	anElement when: BlElementBorderChangedEvent do: [ initialBorder := anElement border ].
	A finest management should be implemented but do we need that ?
	It means that the border of a button can't be changed after the dresser has been installed on the button
	"

	anElement
		when: BlMouseEnterEvent
		do: [ :anEvent | self showMouseIsOver: anElement ].

	anElement when: BlMouseDownEvent do: [ :anEvent | 
		self showAsAlmostClicked: anElement.
		downBorder := anElement border ].

	anElement when: BlClickEvent do: [ :anEvent | 
		downBorder := nil.
		self showMouseIsOver: anElement ].

	anElement
		when: BlMouseLeaveEvent
		do: [ :anEvent | self showInitialLookIn: anElement ].

	anElement
		when: BlMouseUpSomewhereEvent
		do: [ :anEvent | downBorder := nil ]
]

{ #category : #'api - hooks' }
ToButtonBasicDresser >> showAsAlmostClicked: anElement [

	anElement border: (BlBorder paint: Color gray width: 2)
]

{ #category : #'api - hooks' }
ToButtonBasicDresser >> showInitialLookIn: anElement [

	anElement border: initialBorder 
]

{ #category : #'api - hooks' }
ToButtonBasicDresser >> showMouseIsOver: anElement [

	anElement border: (downBorder ifNil: [ (BlBorder paint: Color gray width: 1) ])
]
