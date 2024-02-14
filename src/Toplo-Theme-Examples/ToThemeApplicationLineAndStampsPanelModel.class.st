Class {
	#name : #ToThemeApplicationLineAndStampsPanelModel,
	#superclass : #ToThemeApplicationPanelModel,
	#instVars : [
		'previousStamp',
		'body',
		'elements'
	],
	#category : #'Toplo-Theme-Examples'
}

{ #category : #'as yet unclassified' }
ToThemeApplicationLineAndStampsPanelModel >> allStampsVariation [

	^ self shouldBeImplemented
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> applyStamp: aStampText [

	self previousStamp ifNotNil: [ self elements do: [ :each | each removeStamp: self previousStamp ] ].
	self elements do: [ :each | each addStamp: aStampText ].
	self previousStamp: aStampText
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> body [

	body ifNotNil: [ ^ body ].
	body := ToPane new
		        vertical: true;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		clipChildren: false;
		        yourself.
	self allStampsVariation do: [ :each |
		each ifNotNil: [
			body addChild: (ToLabel new
					 text: each;
					 addStamp: #H2;
					 yourself) ].
		body addChild: (self makeLineWithStamp: each) ].
	^ body
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> elements [

	^ elements 
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> initialize [

	super initialize.
	elements := {  }
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> makeElements [

	^ self shouldBeImplemented
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> makeLineWithStamp: aStamp [

	| line elementsLine |
	line := ToPane new
		        layoutDo: [ :l | l cellSpacing: 4 ];
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		clipChildren: false;
		        yourself.
	elementsLine := self makeElements.
	aStamp ifNotNil: [
		elementsLine do: [ :each | each addStamp: aStamp ] ].
	line addChildren: elementsLine.
	elements := self elements , elementsLine.
	^ line
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> previousStamp [

	^ previousStamp
]

{ #category : #accessing }
ToThemeApplicationLineAndStampsPanelModel >> previousStamp: anObject [

	previousStamp := anObject
]
