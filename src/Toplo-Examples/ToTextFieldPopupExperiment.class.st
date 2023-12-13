Class {
	#name : 'ToTextFieldPopupExperiment',
	#superclass : 'Object',
	#category : 'Toplo-Examples',
	#package : 'Toplo-Examples'
}

{ #category : 'instance creation' }
ToTextFieldPopupExperiment class >> open [

	<script>
	self new open
]

{ #category : 'instance creation' }
ToTextFieldPopupExperiment >> open [

	| e |
	e := BlElement new
		     size: 200 @ 200;
		     background: Color red;
		     yourself.
	e addEventHandler: (BlEventHandler
			 on: BlTextInputEvent
			 do: [ :anEvent | self popupTextFieldWith: anEvent text on: e ]).
	e requestFocus.
	e openInInnerWindow 
]

{ #category : 'instance creation' }
ToTextFieldPopupExperiment >> popupTextFieldWith: aString on: anElement [

	| tf win windowHandler |
	windowHandler := ToAnchoredWindowManager new.
	windowHandler builder: [ :anchWin :element |
		tf := ToTextField new.
		tf editorDo: [:ed | ed when: AlbTextEditedEvent do: [ :event | event text traceCr ] ].
		tf text: aString.
		tf requestFocus.
		tf navigator
			moveTo: aString size;
			apply.
		anchWin root addChild: tf ].
	windowHandler element: anElement.
	win := windowHandler newWindowEvent: nil.
	win popup
]

{ #category : 'see class side' }
ToTextFieldPopupExperiment >> seeClassSide [ 
]
