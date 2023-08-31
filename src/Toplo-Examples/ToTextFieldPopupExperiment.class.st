Class {
	#name : #ToTextFieldPopupExperiment,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToTextFieldPopupExperiment class >> open [

	<script>
	self new open
]

{ #category : #'instance creation' }
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
	e openInSpace
]

{ #category : #'instance creation' }
ToTextFieldPopupExperiment >> popupTextFieldWith: aString on: anElement [
	
	| tf w |
	w := ToPopupWindow new.
	tf := ToTextField new.
	tf whenTextEditedDo: [ :event | event text traceCr ].
	tf text: aString.
	tf requestFocus.
	tf navigator
		moveTo: aString size;
		apply.
	w root addChild: tf.
	w widget: anElement.
	w popup 
]

{ #category : #'see class side' }
ToTextFieldPopupExperiment >> seeClassSide [ 
]
