Class {
	#name : #ToNodeWithHoverButtonDresserExample,
	#superclass : #ToWidgetDresser,
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

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
	super hover: anElement event: anEvent.
	self changeBackground ifTrue: [
		anElement background: (Color lightGray alpha: 0.2) ].
	nodeButton := ToButton new labelText: 'Do something'.
	nodeButton geometry: (BlRoundedRectangleGeometry cornerRadius: 12).
	nodeButton whenClickedDo: [ self inform: 'CLICK' ].
	nodeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight ].
	nodeButton background: Color yellow.
	anElement addChild: nodeButton.
	nodeButton padding: (BlInsets all: 4).
	nodeButton position: 0 @ -10
]

{ #category : #'events handling' }
ToNodeWithHoverButtonDresserExample >> leaved: anElement event: anEvent [

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith:
			'`@receiver leaved: `@anElement event: `@anEvent'
				-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.
	super leaved: anElement event: anEvent.
	self changeBackground ifTrue: [ anElement background: (Color transparent) ].
	nodeButton ifNotNil: [
		nodeButton removeFromParent.
		nodeButton := nil ]
]

{ #category : #'events handling' }
ToNodeWithHoverButtonDresserExample >> mouseEnterEvent: anEvent in: anElement [

	super mouseEnterEvent: anEvent in: anElement.
	self changeBackground ifTrue: [
		anElement background: (Color lightGray alpha: 0.2) ].
	nodeButton := ToButton new labelText: 'Do something'; yourself.
	nodeButton addStyleTag: #primary.
	nodeButton whenClickedDo: [ self inform: 'CLICK' ].
	nodeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight ].
	anElement addChild: nodeButton.
	nodeButton position: 0 @ -10
]

{ #category : #'events handling' }
ToNodeWithHoverButtonDresserExample >> mouseLeaveEvent: anEvent in: anElement [

	super mouseLeaveEvent: anEvent in: anElement.
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
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		margin: (BlInsets all: 6);
		padding: (BlInsets all: 6);
		hMatchParent;
		vFitContent
]
