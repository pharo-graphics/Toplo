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
ToButtonBasicDresser >> almostClicked: anElement [

	anElement border: (BlBorder paint: Color gray width: 2).
	downBorder := anElement border 
]

{ #category : #'api - hooks' }
ToButtonBasicDresser >> clicked: anElement [

	downBorder := nil.
	self readyToClick: anElement
]

{ #category : #'api - hooks' }
ToButtonBasicDresser >> escaped: anElement [

	downBorder := nil
	
]

{ #category : #'api - hooks' }
ToButtonBasicDresser >> initialState: anElement [

	initialBorder ifNil: [ 
		initialBorder := anElement border.
		^ self ].
	anElement border: initialBorder
]

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


	"
	updating initialBorder do not work with the following : 
	anElement when: BlElementBorderChangedEvent do: [ initialBorder := anElement border ].
	A finest management should be implemented but do we need that ?
	It means that the border of a button can't be changed after the dresser has been installed on the button
	"
	self initialState: anElement.
	downBorder := nil.

	anElement
		when: BlMouseEnterEvent
		do: [ :anEvent | self readyToClick: anElement ].

	anElement
		when: BlMouseLeaveEvent
		do: [ :anEvent | self initialState: anElement ].

	anElement
		when: BlMouseDownEvent
		do: [ :anEvent | self almostClicked: anElement ].

	anElement
		when: BlClickEvent
		do: [ :anEvent | self clicked: anElement ].

	anElement
		when: BlMouseUpSomewhereEvent
		do: [ :anEvent | self escaped: anElement ]
]

{ #category : #'api - hooks' }
ToButtonBasicDresser >> readyToClick: anElement [

	anElement border: (downBorder ifNil: [ (BlBorder paint: Color gray width: 1) ])
]
