Class {
	#name : #ToPaneNodeExampleSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'nodeButton'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToPaneNodeExampleSkin >> createNodeButton [

	| label |
	label := ToLabel text: 'Do something'.
	" ensure that the button label skin will not receive selected skin event "
	label preventSelectionSkinEvents.
	nodeButton := ToButton new
		              label: label;
		              yourself.
	nodeButton whenClickedDo: [ :event |
		event consume.
		self inform: 'CLICK' ].
	nodeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight ].
	nodeButton position: 0 @ -5
]

{ #category : #'event handling' }
ToPaneNodeExampleSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e | 
		" hovered skin can be dispatched whereas no leaved look event has been dispatched 
		(in case of click event as an example)"
		nodeButton ifNil: [
			self createNodeButton.
			e addChild: nodeButton ] ]
]

{ #category : #'event handling' }
ToPaneNodeExampleSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| p1 p2 p3 |
		e beHorizontal.
		e
			clipChildren: false;
			outskirts: BlOutskirts outside;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			margin: (BlInsets all: 6);
			padding: (BlInsets all: 6).

		p1 := ToPane vertical
			      background: Color blue;
			      width: 50;
			      yourself.
		p2 := ToPane vertical
			      background: (Color blue alpha: 0.6);
			      width: 100;
			      yourself.
		p3 := ToPane vertical
			      background: (Color blue alpha: 0.3);
			      hMatchParent;
			      yourself.
		e addChildren: {
				p1.
				p2.
				p3 }.
		e height: 60.
		e hMatchParent ]
]

{ #category : #'event handling' }
ToPaneNodeExampleSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent target isEnabled ifFalse: [ ^ self ].
	nodeButton ifNotNil: [
		nodeButton removeFromParent.
		nodeButton := nil ]
]
