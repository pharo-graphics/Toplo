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
		'startFlexible',
		'endFlexible',
		'endGap',
		'startGap',
		'startAlignment',
		'endAlignment',
		'endInterspace',
		'startInterspace'
	],
	#category : #'Toplo-Core'
}

{ #category : #layout }
ToTripletElement >> configureLayout [

	self isHorizontal
		ifTrue: [
			self startGap size = (startInterspace @ 0) ifFalse: [
				self startGap size: startInterspace @ 0 ].
			self endGap size = (endInterspace @ 0) ifFalse: [
				self endGap size: endInterspace @ 0 ].
			self endElement ifNotNil: [ :ee |
				ee constraints frame horizontal alignRight ] ]
		ifFalse: [
			self startGap size = (0 @ startInterspace) ifFalse: [
				self startGap size: 0 @ startInterspace ].
			self endGap size = (0 @ endInterspace) ifFalse: [
				self endGap size: 0 @ endInterspace ].
			self endElement ifNotNil: [ :ee |
				ee constraints frame vertical alignBottom ] ].

]

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
					c vertical fitContent ] ]
			ifFalse: [
				endContainer constraintsDo: [ :c |
					c vertical exact: endAlignment.
					c horizontal fitContent ] ] ]
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

{ #category : #accessing }
ToTripletElement >> endGap [

	^ endGap
]

{ #category : #accessing }
ToTripletElement >> endInterspace [

	^ endInterspace
]

{ #category : #accessing }
ToTripletElement >> endInterspace: aNumber [

	endInterspace := aNumber.
	self requestLayout
]

{ #category : #accessing }
ToTripletElement >> flexible [

	^ self startFlexible and: [ self endFlexible ]
]

{ #category : #accessing }
ToTripletElement >> flexible: aBoolean [

	self startFlexible: aBoolean.
	self endFlexible: aBoolean
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
	startInterspace := 0.
	endInterspace := 0.
	startGap := self newFiller
		               id: #'start-gap';
		               yourself.
	endGap := self newFiller
		             id: #'end-gap';
		             yourself.

	startFiller := self newFiller
		               id: #'start-filler';
		               yourself.
	endFiller := self newFiller
		             id: #'end-filler';
		             yourself.
		
	startContainer := self newBaseContainer
		                  id: #'start-container';
		                  yourself.
	middleContainer := self newBaseContainer
		                   id: #'middle-container';
		                   yourself.
	endContainer := self newBaseContainer
		                id: #'end-container';
		                yourself.
		
	self addChild: startContainer.
	self addChild: startGap.
	self addChild: startFiller.
	self addChild: middleContainer.
	self addChild: endFiller.
	self addChild: endGap.
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

{ #category : #'instance creation' }
ToTripletElement >> newBaseContainer [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  layout: BlLinearLayout new;
		  yourself
]

{ #category : #'instance creation' }
ToTripletElement >> newFiller [

	^ BlElement new
		  size: 0 @ 0;
		  layout: BlLinearLayout new;
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  yourself
]

{ #category : #layout }
ToTripletElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self configureLayout.
	super onLayout: aBounds context: aBlElementBoundsUpdateContext
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
					c horizontal fitContent ] ] ]
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

{ #category : #accessing }
ToTripletElement >> startGap [

	^ startGap
]

{ #category : #accessing }
ToTripletElement >> startInterspace [

	^ startInterspace
]

{ #category : #accessing }
ToTripletElement >> startInterspace: aNumber [

	startInterspace := aNumber.
	self requestLayout
]
