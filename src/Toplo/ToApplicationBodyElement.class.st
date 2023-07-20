Class {
	#name : #ToApplicationBodyElement,
	#superclass : #ToElement,
	#instVars : [
		'contextMenuLayer',
		'popupLayer',
		'rootLayer',
		'layerHolder',
		'overlayLayer'
	],
	#category : #'Toplo-Application'
}

{ #category : #'private - change' }
ToApplicationBodyElement class >> extractRoots: aSetOfElements [
	| theElementsToCheck theElementsToProcess |
	
	theElementsToCheck := aSetOfElements as: Stack.
	theElementsToProcess := Set new.
	
	[ theElementsToCheck isEmpty ] whileFalse: [
		| eachElement |
		
		eachElement := theElementsToCheck pop.
		(theElementsToCheck anySatisfy: [ :eachPotentialParent | eachElement hasParent: eachPotentialParent ])
			ifFalse: [ theElementsToProcess add: eachElement ] ].

	^ theElementsToProcess
]

{ #category : #'class initialization' }
ToApplicationBodyElement class >> initialize [
	UniqueIdGenerator := BlUniqueIdGenerator new
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> locationInside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := theBounds atRandom.
		
	self
		assert: [ theBounds containsPoint: aPosition ]
		description: [ 'Point({1}) must be inside of the bounds({2})' format: { aPosition . theBounds } ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> locationOutside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height asInteger atRandom).
		theBounds bottomLeft + (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height asInteger atRandom).
	}	atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> pulseUntilEmptyTaskQueue: aSpace timeout: aDuration [
	"Wait until a BlSpace doesn't have available tasks to execute. 
	
	Inspired on BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:"

	| deadline |
	deadline := aSpace time now + aDuration.
	
	aSpace time
		every: 5 milliSeconds
		while: [
			(aSpace taskQueue isEmpty or: [
				aSpace time now >= deadline ]) not ]
		do: [ aSpace pulse ].

	aSpace pulse.

	^ aSpace taskQueue isEmpty
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateClickOn: anElement [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"

	^ self simulateClickOn: anElement button: BlMouseButton primary
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateClickOn: anElement button: aButton [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence."

	| aPosition |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			(BlMouseDownEvent button: aButton) position: aPosition; yourself.
			(BlMouseUpEvent button: aButton) position: aPosition; yourself }
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateClickOutside: anElement [
	"Simulate a click event in outside of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	
	aPosition := self locationOutside: anElement.
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateDoubleClickOn: anElement [
	"Simulate a double click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a double click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition.
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition. }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateDragOn: anElement by: aBlVector [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition aDelta |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	aDelta := (anElement localBoundsToGlobal: (BlBounds origin: 0.0@0.0 extent: aBlVector)) extent.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition; yourself.
			BlMouseMoveEvent primary position: aPosition + aDelta; delta: aDelta; yourself.
			BlMouseUpEvent primary position: aPosition + aDelta; yourself }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	"Simulate a drag in the center of a given element by
	performing mouse down, mouse move, and mouse up events."

	| aPosition aDelta |
	anElement forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvent:
			(BlMouseDownEvent primary
				position: aPosition;
				yourself)
		on: anElement.

	aSequenceOfBlVectors do: [ :each |
		aDelta := (anElement localBoundsToGlobal:
			(BlBounds origin: 0.0@0.0 extent: each)) extent.
		aPosition := aPosition + aDelta.
		self
			simulateEvent:
				(BlMouseMoveEvent primary
					position: aPosition "+ aDelta";
					delta: aDelta;
					yourself)
			on: anElement ].

	self
		simulateEvent:
			(BlMouseUpEvent primary
				position: aPosition "+ aDelta";
				delta: aDelta;
				yourself)
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateEvent: anEvent on: anElement [
	"I simulate a given low level space UI event such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element.
	Note: I create a temporary space if provided element does not have one. if you need to simulate
	a sequence of dependent events it is better to use #simulateEvents:on: directy"

	self simulateEvents: { anEvent } on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateEvents: aCollectionOfEvents on: anElement [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element"
	
	"we should update timestamps"
	aCollectionOfEvents do: [ :anEvent | anEvent timestamp: DateAndTime now ].
	
	anElement isAttachedToSceneGraph
		ifTrue: [
			| aSpace |
			"element may be removed from the space."
			aSpace := anElement space.
			aSpace pulse.
			aCollectionOfEvents do: [ :anEvent | aSpace dispatchEvent: anEvent ].
			aSpace dispatchEvent: BlSpaceEventsProcessedEvent new.
			aSpace pulse ]
		ifFalse: [ 
			| temporarySpace topMostElement |
			topMostElement := anElement topMostParent.
			[ 
				temporarySpace := self new.
				temporarySpace root addChild: topMostElement.
				temporarySpace pulse.
				aCollectionOfEvents do: [ :anEvent | temporarySpace dispatchEvent: anEvent ].
				temporarySpace dispatchEvent: BlSpaceEventsProcessedEvent new.
				temporarySpace pulse
			] ensure: [ topMostElement removeFromParent ] ]
	
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateKeyDownOn: anElement key: aBlKeyboardKey [
	"Simulate a key down event"

	self
		simulateEvents: { BlKeyDownEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateKeyUpOn: anElement key: aBlKeyboardKey [
	"Simulate a key up event"

	self
		simulateEvents: { BlKeyUpEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseDownOn: anElement [
	"Simulate a mouse down event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseDownEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseDownOn: anElement at: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseDownEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseMoveInside: anElement [
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	aPosition := self locationInside: anElement.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseMoveOn: anElement at: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary
			position: aToPoint;
			delta: (aToPoint - aFromPoint)  }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseMoveOutside: anElement [
	"Simulate a mouse move event at a random location outside of element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	aPosition := self locationOutside: anElement.
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseUpOn: anElement [
	"Simulate a mouse up event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseUpEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseUpOn: anElement at: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseUpEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateMouseWheelOn: anElement by: aBlVector [
	"Simulate a mouse wheel event in the middle of a given element"
	| aPosition aBlocEvent |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"Bloc event"
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.
	
	self
		simulateEvent: aBlocEvent
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
ToApplicationBodyElement class >> simulateSecondaryClickOn: anElement [
	"Simulate a secondary click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	
	^ self simulateClickOn: anElement button: BlMouseButton secondary
]

{ #category : #'class initialization' }
ToApplicationBodyElement class >> spaceWithId: aSpaceId do: aBlock [
	^ self allSubInstances
		detect: [ :eachSpace | eachSpace id = aSpaceId ]
		ifFound: aBlock
		ifNone: [ nil ]
]

{ #category : #accessing }
ToApplicationBodyElement >> contextMenuLayer [
	"Return my current root element.
	root can not be nil"
	
	^ contextMenuLayer
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultContextMenuElevation [

	^ 50
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultContextMenuLayer [

	^ BlElement new
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultContextMenuElevation);
		  labeled: 'Context menu layer';
		  yourself
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultLayerHolder [

	^ BlElement new
		  layout: BlFrameLayout new;
		  labeled: 'Top';
		  yourself
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultOverlayElevation [

	^ 40
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultOverlayLayer [

	^ BlElement new
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultOverlayElevation);
		  labeled: 'Overlay layer';
		  yourself
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultPopupElevation [

	^ 100
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultPopupLayer [

	^ BlElement new
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultPopupElevation);
		  labeled: 'Popup layer';
		  yourself
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultRoot [

	^ BlElement new
		  background: self defaultRootBackground;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultRootElevation);
		  labeled: self defaultRootLabel;
		  yourself
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultRootBackground [
	^ Color white
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultRootElevation [

	^ 0
]

{ #category : #initialization }
ToApplicationBodyElement >> defaultRootLabel [
	^ 'Root element'
]

{ #category : #'private - change' }
ToApplicationBodyElement >> extractRoots: aSetOfElements [
	^ self class extractRoots: aSetOfElements
]

{ #category : #'event handling' }
ToApplicationBodyElement >> findMouseEventTargetAt: aPoint [

	"Return the deepest child element among all my children or myself that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child is found and if I can not be event target either"

	<return: #BlElement or: nil>
	self children sortedByElevation reversed do: [ :eachChild | 
		| found |
		found := eachChild findMouseEventTargetAt: aPoint.
		(found notNil and: [ found ~~ eachChild ]) ifTrue: [
			^ found ] ].
	^ nil
]

{ #category : #'event handling' }
ToApplicationBodyElement >> findMousePickTargetFromEvent: anEvent [

	"Return the deepest child element among all my children or myself that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child is found and if I can not be event target either"

	<return: #BlElement or: nil>
	| layers |
	layers := self layerHolder children sortedByElevation reversed.
	layers do: [ :layer |
		(layer findMouseEventTargetAt: anEvent position) ifNotNil: [ :found |
			" test the layer because if the result is the layer then it means that no element has been found "
			found ~~ layer ifTrue: [ 
				" ok, dispatch outside event through all the space elements "
				self processMouseOutsideFrom: anEvent pickedIn: found.
				^ found ] ] ].
	" no element found at all: all elements receive a outside event"
	self layerHolder dispatchMousePickedOutside: anEvent asMouseOutsideEvent.
	^ self layerHolder
]

{ #category : #testing }
ToApplicationBodyElement >> hasInParentChain: anElement [

	^ anElement = self
]

{ #category : #initialization }
ToApplicationBodyElement >> initialize [
	super initialize.

	layerHolder := self defaultLayerHolder.
	overlayLayer := self defaultOverlayLayer.
	popupLayer := self defaultPopupLayer.
	contextMenuLayer := self defaultContextMenuLayer.
	rootLayer := self defaultRoot.

	self layerHolder addChild: self root.
	self layerHolder addChild: self overlayLayer.
	self layerHolder addChild: self contextMenuLayer.
	self layerHolder addChild: self popupLayer

]

{ #category : #accessing }
ToApplicationBodyElement >> layerHolder [
	"Return my current root element.
	root can not be nil"
	
	^ layerHolder
]

{ #category : #accessing }
ToApplicationBodyElement >> overlayLayer [
	"Return my current root element.
	root can not be nil"
	
	^ overlayLayer
]

{ #category : #accessing }
ToApplicationBodyElement >> popupLayer [
	"Return my current root element.
	root can not be nil"
	
	^ popupLayer
]

{ #category : #'event handling' }
ToApplicationBodyElement >> processMouseOutsideFrom: anEvent pickedIn: aPickedElement [
	" As an example, I'm used, to manage popup closing in case of a 
	mouse up/down outside the popup window.
	I send a mouse up/down outside event to element outside aPickedElement "

	| evt |
	" clone and initialize the original mouse up/down event "
	evt := anEvent clone.
	evt target: aPickedElement.
	" dispatch the mouse outside event to all alements of the scene graph "
	self layerHolder childrenDo: [ :aChildElement |
		aChildElement dispatchMousePickedOutside: evt asMouseOutsideEvent ]
]

{ #category : #accessing }
ToApplicationBodyElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ rootLayer
]

{ #category : #accessing }
ToApplicationBodyElement >> root: anElement [
	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'anElement must not be nil' ].

	self
		assert: [ anElement space isNil ]
		description: [ 'New root must not be already have a space assigned!' ].

	anElement
		space: self;
		size: self extent.

	rootLayer := anElement
]

{ #category : #accessing }
ToApplicationBodyElement >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #accessing }
ToApplicationBodyElement >> topMostParent [
	^ self root
]
