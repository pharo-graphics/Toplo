Class {
	#name : #ToColorNodeDresserExample,
	#superclass : #ToNodeDresser,
	#instVars : [
		'nodeButton'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'events handling' }
ToColorNodeDresserExample >> addedToSelection: anElement [

	selected := true.

]

{ #category : #'events handling' }
ToColorNodeDresserExample >> hover: anElement event: anEvent [

	nodeButton := ToButton new labelText: 'Do something'.
	nodeButton whenClickedDo: [ self inform: 'CLICK' ].
	nodeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight ].
	nodeButton background: Color yellow.
	anElement addChild: nodeButton.
	nodeButton padding: (BlInsets all: 4).
	nodeButton relocate: 0 @ -10
]

{ #category : #'events handling' }
ToColorNodeDresserExample >> leaved: anElement [

	nodeButton ifNotNil: [ nodeButton removeFromParent. nodeButton := nil ]
]

{ #category : #'events handling' }
ToColorNodeDresserExample >> leftClicked: anElement event: anEvent [

]

{ #category : #'events handling' }
ToColorNodeDresserExample >> leftPressed: anElement event: anEvent [

]

{ #category : #'events handling' }
ToColorNodeDresserExample >> onElementAttached: anElement inInfinite: aToInfinite [
]

{ #category : #'events handling' }
ToColorNodeDresserExample >> onElementDetached: anElement inInfinite: aToInfinite [
]

{ #category : #'api - install/uninstall  hook' }
ToColorNodeDresserExample >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement
		clipChildren: false;
		outskirts: BlOutskirts outside;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		margin: (BlInsets all: 6);
		padding: (BlInsets all: 6);
		hMatchParent;
		height: 50
]

{ #category : #'events handling' }
ToColorNodeDresserExample >> removedFromSelection: anElement [

	selected := false.

]
