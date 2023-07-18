Class {
	#name : #ToToggleTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'onElement',
		'offElement',
		'bulletElement'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToToggleTrackElement >> bulletElement [

	^ bulletElement
]

{ #category : #accessing }
ToToggleTrackElement >> bulletElement: anElement [

	bulletElement := anElement
]

{ #category : #initialization }
ToToggleTrackElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraints minWidth: 35.
	self vFitContent
]

{ #category : #accessing }
ToToggleTrackElement >> offElement [

	^ offElement
]

{ #category : #accessing }
ToToggleTrackElement >> offElement: anElement [

	offElement := anElement
]

{ #category : #accessing }
ToToggleTrackElement >> onElement [

	^ onElement
]

{ #category : #accessing }
ToToggleTrackElement >> onElement: anElement [

	onElement := anElement
]

{ #category : #accessing }
ToToggleTrackElement >> pusher [

	^ self onElement
		  ifNil: [ self bulletElement childAt: 1 ]
		  ifNotNil: [ self bulletElement childAt: 2 ]
]
