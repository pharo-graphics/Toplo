Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#instVars : [
		'checked'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #accessing }
ToToggleButton >> checked [

	^ checked
]

{ #category : #accessing }
ToToggleButton >> checked: aBoolean [

	checked := aBoolean
]

{ #category : #'t - clickable' }
ToToggleButton >> clickEvent: anEvent [

	super clickEvent: anEvent.
	checked := checked not
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	checked := false
]
