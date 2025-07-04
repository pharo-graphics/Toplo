Class {
	#name : #ToSkinDemo2Button,
	#superclass : #BlElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'clicked'
	],
	#category : #'Toplo-Demo-Skin Demo - 2'
}

{ #category : #'as yet unclassified' }
ToSkinDemo2Button class >> exampleBasic [

	self new
		position: 50 asPoint;
		openInSpace
]

{ #category : #'as yet unclassified' }
ToSkinDemo2Button class >> exampleWithAccessor [

	| button |
	button := self new
		          position: 50 asPoint;
		          clicked: true.
	button openInSpace
]

{ #category : #'as yet unclassified' }
ToSkinDemo2Button class >> exampleWithSideElementChangingClick [

	| button side space |
	button := self new
		          position: 50 asPoint;
		          clicked: true.

	side := BlElement new
		        position: 170 @ 50;
		        background: Color lightBlue;
				  addChild: (BlTextElement text: button clicked asRopedText );
		        addEventHandlerOn: BlClickEvent do: [ :e |
			        button clicked: button clicked not.
			        side firstChild text: button clicked asRopedText ];
		        yourself.

	space := BlSpace new.
	space root addChildren: {
			button.
			side }.
	space show
]

{ #category : #public }
ToSkinDemo2Button >> click [ 

	clicked := clicked not
]

{ #category : #public }
ToSkinDemo2Button >> clicked [ 

	^ clicked
]

{ #category : #'as yet unclassified' }
ToSkinDemo2Button >> clicked: aBoolean [

	clicked := aBoolean.
	"self requestNewSkin" "<- added to refresh skin when clicked is changed 'manually' "
]

{ #category : #initialization }
ToSkinDemo2Button >> initialize [

	super initialize.
	
	clicked := false.
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consume.
		self click ].

	self initializeForToplo
]

{ #category : #'as yet unclassified' }
ToSkinDemo2Button >> newRawSkin [ 

	^ ToSkinDemo2ButtonSkin new
]
