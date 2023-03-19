Class {
	#name : #ToPaneNodeDresserExample,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'nodeButton'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'events handling' }
ToPaneNodeDresserExample >> hover: anElement event: anEvent [

	super hover: anElement event: anEvent.
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
ToPaneNodeDresserExample >> leaved: anElement [

	super leaved: anElement.
	nodeButton ifNotNil: [
		nodeButton removeFromParent.
		nodeButton := nil ]
]

{ #category : #'api - install/uninstall  hook' }
ToPaneNodeDresserExample >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement
		clipChildren: false;
		outskirts: BlOutskirts outside;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		margin: (BlInsets all: 6);
		padding: (BlInsets all: 6);
		hMatchParent;
		vFitContent
]
