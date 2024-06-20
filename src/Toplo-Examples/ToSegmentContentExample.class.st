Class {
	#name : #ToSegmentContentExample,
	#superclass : #ToElement,
	#traits : 'TToSegmentedNodeContentElement',
	#classTraits : 'TToSegmentedNodeContentElement classTrait',
	#instVars : [
		'triplet'
	],
	#category : #'Toplo-Examples'
}

{ #category : #initialization }
ToSegmentContentExample >> initialize [ 

	super initialize.
	self layout: BlLinearLayout new.
	self fitContent.
	triplet := ToTripletElement new.
	triplet hMatchParent; vFitContent.
	self addChild: triplet.
	self initializeRemoveButton
]

{ #category : #initialization }
ToSegmentContentExample >> initializeRemoveButton [

	| but |
	but := ToButton new.
	but withNullSkin.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].
	but geometry: BlCircleGeometry new.

	but addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :event |
				 event consume.
				 self removeFromBar ]).

	" consume mouseUp/mouseDown to avoid unwanted opening/closing of the popup list element"
	but addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :event | event consume ]).
	but addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consume ]).

	but id: #removeButton.
	triplet startElement: but.
	triplet startInterspace: 5
]

{ #category : #accessing }
ToSegmentContentExample >> label [

	^ triplet middleElement
]

{ #category : #accessing }
ToSegmentContentExample >> label: aLabel [

	triplet middleElement: aLabel
]

{ #category : #initialization }
ToSegmentContentExample >> removeFromBar [

	self checkableBarElement checkableElementAccessor removeAt: self positionInSegmentedElement
]
