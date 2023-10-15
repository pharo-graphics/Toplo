Class {
	#name : 'ToPaneNodeExampleEventHandler',
	#superclass : 'ToSkinnableEventHandler',
	#instVars : [
		'nodeButton',
		'changeBackground'
	],
	#category : 'Toplo-Examples',
	#package : 'Toplo-Examples'
}

{ #category : 'accessing' }
ToPaneNodeExampleEventHandler >> changeBackground [

	^ changeBackground ifNil: [ changeBackground := true ]
]

{ #category : 'accessing' }
ToPaneNodeExampleEventHandler >> changeBackground: aBoolean [

	changeBackground := aBoolean
]

{ #category : 'mouse handlers' }
ToPaneNodeExampleEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	self changeBackground ifTrue: [
		anEvent currentTarget background: (Color lightGray alpha: 0.2) ].
	nodeButton := ToButton new labelText: 'Do something'; yourself.
	nodeButton withStamp: #primary.
	nodeButton requestSkin.
	nodeButton whenClickedDo: [ self inform: 'CLICK' ].
	nodeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight ].
	anEvent currentTarget addChild: nodeButton.
	nodeButton position: 0 @ -10
]

{ #category : 'mouse handlers' }
ToPaneNodeExampleEventHandler >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent.
	self changeBackground ifTrue: [ anEvent currentTarget background: (Color transparent) ].
	nodeButton ifNotNil: [
		nodeButton removeFromParent.
		nodeButton := nil ]
]
