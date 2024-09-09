Class {
	#name : #ToChoiceItem,
	#superclass : #ToCheckMenuItem,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-Menu-Choice menu deprecated'
}

{ #category : #testing }
ToChoiceItem class >> isDeprecated [

	^ true
]

{ #category : #testing }
ToChoiceItem >> closeOnMouseEvent [

	^ true
]

{ #category : #accessing }
ToChoiceItem >> data [

	^ data
]

{ #category : #accessing }
ToChoiceItem >> data: anObject [

	data := anObject
]

{ #category : #initialization }
ToChoiceItem >> initialize [

	super initialize.
	self  addEventHandler: (BlEventHandler
			 on: ToCheckableChangedEvent
			 do: [ :event | self button checked: event checked ])
]
