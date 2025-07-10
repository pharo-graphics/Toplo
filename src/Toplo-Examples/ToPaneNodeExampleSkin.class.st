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
	nodeButton clickAction: [
		self inform: 'CLICK' ].
	nodeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight ].
	nodeButton position: 0 @ -5
]

{ #category : #'event handling' }
ToPaneNodeExampleSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
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
			| p1 p2 p3 badge blab |
			e beHorizontal.
			e hMatchParent.
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
			badge := BlElement new layout: BlFrameLayout new.
			blab := ToLabel text: 'x'.
			blab withNullSkin.
			blab foreground: Color white.
			blab constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ].
			badge addChild: blab.
			badge background: Color red.
			badge geometry: BlCircleGeometry new.
			badge extent: 20 asPoint.
			badge constraintsDo: [ :c |
					c ignoreByLayout.
					c anchors add:
						(badge centerAnchor on: e topRightAnchor + (-5 @ 5)) ].
			e addChild: badge.
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

{ #category : #'event handling' }
ToPaneNodeExampleSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent target isEnabled ifFalse: [ ^ self ].
	nodeButton ifNotNil: [
		nodeButton removeFromParent.
		nodeButton := nil ]
]
