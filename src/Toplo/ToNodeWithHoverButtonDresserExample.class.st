Class {
	#name : #ToNodeWithHoverButtonDresserExample,
	#superclass : #ToMouseHandlingDresser,
	#instVars : [
		'nodeButton',
		'changeBackground'
	],
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToNodeWithHoverButtonDresserExample >> changeBackground [

	^ changeBackground ifNil: [ changeBackground := true ]
]

{ #category : #accessing }
ToNodeWithHoverButtonDresserExample >> changeBackground: aBoolean [

	changeBackground := aBoolean
]

{ #category : #'events handling' }
ToNodeWithHoverButtonDresserExample >> hover: anElement event: anEvent [

	super hover: anElement event: anEvent.
	self changeBackground ifTrue: [ anElement background: (Color lightGray alpha: 0.2) ].
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
ToNodeWithHoverButtonDresserExample >> leaved: anElement event: anEvent [

	super leaved: anElement event: anEvent.
	self changeBackground ifTrue: [ anElement background: (Color transparent) ].
	nodeButton ifNotNil: [
		nodeButton removeFromParent.
		nodeButton := nil ]
]

{ #category : #'api - install/uninstall  hook' }
ToNodeWithHoverButtonDresserExample >> onInstalledIn: anElement [

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
