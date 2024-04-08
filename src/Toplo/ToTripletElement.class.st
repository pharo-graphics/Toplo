Class {
	#name : #ToTripletElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'startContainer',
		'middleContainer',
		'endContainer',
		'startFiller',
		'endFiller',
		'startElement',
		'middleElement',
		'endElement',
		'endFlexible',
		'startFlexible',
		'startAlignment',
		'endAlignment'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToTripletElement >> defaultEventHandler [

	^ ToTripletElementEventHandler new
]

{ #category : #initialization }
ToTripletElement >> defaultLayout [ 

	^ BlLinearLayout horizontal.

]

{ #category : #accessing }
ToTripletElement >> endAlignment [

	^ endAlignment
]

{ #category : #accessing }
ToTripletElement >> endAlignment: aNumber [

	endAlignment = aNumber ifTrue: [ ^ self ].
	endAlignment := aNumber.
	endAlignment ifNotNil: [
		self isHorizontal
			ifTrue: [
				endContainer constraintsDo: [ :c |
					c horizontal exact: endAlignment.
					c vertical fitContent ].
				self endElement ifNotNil: [ :ee |
					ee constraintsDo: [ :c | c frame horizontal alignRight ] ] ]
			ifFalse: [
				endContainer constraintsDo: [ :c |
					c vertical exact: endAlignment.
					c horizontal fitContent ].
				self endElement ifNotNil: [ :ee |
					ee constraintsDo: [ :c | c frame horizontal alignBottom ] ] ] ]
]

{ #category : #accessing }
ToTripletElement >> endContainer [

	^ endContainer
]

{ #category : #accessing }
ToTripletElement >> endElement [

	^ endElement
]

{ #category : #accessing }
ToTripletElement >> endElement: anElement [

	anElement = endElement ifTrue: [ ^ self ].
	endElement ifNotNil: [ :s | s removeFromParent].
	endElement := anElement.
	anElement ifNil: [ ^ self ].
	endContainer addChild: anElement
]

{ #category : #accessing }
ToTripletElement >> endFiller [

	^ endFiller
]

{ #category : #accessing }
ToTripletElement >> endFlexible [

	^ endFlexible
]

{ #category : #accessing }
ToTripletElement >> endFlexible: aBoolean [

	endFlexible = aBoolean ifTrue: [ ^ self ].
	endFlexible := aBoolean.	
	endFlexible
		ifTrue: [
			self endFiller constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			self endFiller constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ] ]
]

{ #category : #testing }
ToTripletElement >> hasEndElement [

	^ endElement notNil
]

{ #category : #testing }
ToTripletElement >> hasMiddleElement [

	^ middleElement notNil
]

{ #category : #testing }
ToTripletElement >> hasStartElement [

	^ startElement notNil
]

{ #category : #initialization }
ToTripletElement >> initialize [

	super initialize.
	
	startFlexible := false.
	endFlexible := false.
	startFiller := BlElement new
		          size: 0 @ 0;
		          id: #'start-filler';
		          layout: BlFrameLayout new;
		          constraintsDo: [ :c |
			          c horizontal fitContent.
			          c vertical fitContent ];
		          yourself.
	endFiller := BlElement new
		          size: 0 @ 0;
		          id: #'end-filler';
		          layout: BlFrameLayout new;
		          constraintsDo: [ :c |
			          c horizontal fitContent.
			          c vertical fitContent ];
		          yourself.
	startContainer := BlElement new
		                 constraintsDo: [ :c |
			                 c horizontal fitContent.
			                 c vertical fitContent ];
		                 id: #'start-container';
		                 layout: BlFrameLayout new;
		                 yourself.
	middleContainer := BlElement new
		                  constraintsDo: [ :c |
			                  c horizontal fitContent.
			                  c vertical fitContent ];
		                  id: #'middle-container';
		                  layout: BlFrameLayout new;
		                  yourself.
	endContainer := BlElement new
		                  constraintsDo: [ :c |
			                  c horizontal fitContent.
			                  c vertical fitContent ];
		                  id: #'end-container';
		                  layout: BlFrameLayout new;
		                  yourself.
	self addChild: startContainer.
	self addChild: startFiller.
	self addChild: middleContainer.
	self addChild: endFiller.
	self addChild: endContainer.
	self fitContent.
	self addEventHandler: self defaultEventHandler
]

{ #category : #skin }
ToTripletElement >> installRawStyle [

	super installRawStyle.
	self childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	
]

{ #category : #testing }
ToTripletElement >> isEndFlexible [

	^ endFlexible 
]

{ #category : #testing }
ToTripletElement >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #testing }
ToTripletElement >> isStartFlexible [

	^ startFlexible 
]

{ #category : #'t - orientable - accessing' }
ToTripletElement >> layoutStrategy [

	^ self layout
]

{ #category : #accessing }
ToTripletElement >> middleContainer [

	^ middleContainer
]

{ #category : #accessing }
ToTripletElement >> middleElement [

	^ middleElement
]

{ #category : #accessing }
ToTripletElement >> middleElement: anElement [

	anElement = middleElement ifTrue: [ ^ self ].
	middleElement ifNotNil: [ :s | s removeFromParent].
	middleElement := anElement.
	anElement ifNil: [ ^ self ].
	middleContainer addChild: anElement
]

{ #category : #accessing }
ToTripletElement >> startAlignment [

	^ startAlignment 
]

{ #category : #accessing }
ToTripletElement >> startAlignment: aNumber [

	startAlignment = aNumber ifTrue: [ ^ self ].
	startAlignment := aNumber.
	startAlignment ifNotNil: [
		self isHorizontal
			ifTrue: [
				startContainer constraintsDo: [ :c |
					c horizontal exact: startAlignment.
					c vertical fitContent ] ]
			ifFalse: [
				startContainer constraintsDo: [ :c |
					c vertical exact: startAlignment.
					c horizontal fitContent ] ] ].

]

{ #category : #accessing }
ToTripletElement >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTripletElement >> startElement [

	^ startElement
]

{ #category : #accessing }
ToTripletElement >> startElement: anElement [

	anElement = startElement ifTrue: [ ^ self ].
	startElement ifNotNil: [ :s | startElement removeFromParent ].
	startElement := anElement.
	anElement ifNil: [ ^ self ].
	startContainer addChild: anElement
]

{ #category : #accessing }
ToTripletElement >> startFiller [

	^ startFiller
]

{ #category : #accessing }
ToTripletElement >> startFlexible [

	^ startFlexible 
]

{ #category : #accessing }
ToTripletElement >> startFlexible: aBoolean [

	startFlexible = aBoolean ifTrue: [ ^ self ].
	startFlexible := aBoolean.
	startFlexible
		ifTrue: [
			self startFiller constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			self startFiller constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ] ]
]
