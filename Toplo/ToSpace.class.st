"
I'm a replacement for `BlSpace`. The idea is to simplify and to remove complex implicit computations that are implemented in `BlSpace`. 
For now:
- I don't use layout resizing propagation rules at all (compare `BlSpace>>#doStyle` and `ToSpace>>#doStyle`)

## Comments from `BlSpace`
I am the logical representation of a window in Bloc regardless of the current Host in use.
Here are some of the important objects I use and talk to:
- {{gtClass:BlCursor}}
- {{gtClass:BlTime}}
- Various {{gtClass:BlBaseEventProcessor}} subclasses broker different{{gtClass:BlEvent}}types
- {{gtClass:BlSpaceFrame}}

## Gracefully closing the image when a space is closed
A common use case is to quit the application when some particular space is closed. To do this, we provide {{gtClass:BlSpaceShutdownOnCloseListener}} which can be added to any space as an event handler. It listens for a {{gtClass:BlSpaceClosedEvent}}, which is sent after a space is closed. See the listener class for configuration options.

"
Class {
	#name : #ToSpace,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TBlSpaceProperties + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlSpaceProperties classTrait + TBlDebug classTrait',
	#instVars : [
		'id',
		'host',
		'hostSpace',
		'extent',
		'position',
		'root',
		'resizable',
		'borderless',
		'dirtyAreas',
		'eventDispatcher',
		'eventListener',
		'eventRecorder',
		'mouseProcessor',
		'focusProcessor',
		'keyboardProcessor',
		'focusChain',
		'dragboard',
		'nextPulseRequested',
		'currentCursor',
		'session',
		'focused',
		'title',
		'fullscreen',
		'fullsize',
		'layoutError',
		'tasks',
		'time',
		'touchProcessor',
		'frame',
		'gestureProcessor',
		'elementsNeedingPaint',
		'elementsNeedingLayout',
		'telemetry',
		'reference',
		'elementsNeedingStyle',
		'elementsNeedingPropertiesComputation',
		'iconStencil'
	],
	#classVars : [
		'UniqueIdGenerator'
	],
	#category : #'Toplo-Space'
}

{ #category : #'private - change' }
ToSpace class >> extractRoots: aSetOfElements [
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
ToSpace class >> initialize [
	UniqueIdGenerator := BlUniqueIdGenerator new
]

{ #category : #'debug - simulation' }
ToSpace class >> locationInside: anElement [
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
ToSpace class >> locationOutside: anElement [
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
ToSpace class >> simulateClickOn: anElement [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	<return: #Point>
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateClickOutside: anElement [
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
ToSpace class >> simulateDoubleClickOn: anElement [
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
ToSpace class >> simulateDragOn: anElement by: aBlVector [
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
			BlMouseDownEvent primary position: aPosition.
			BlMouseMoveEvent primary position: aPosition + aDelta.
			BlMouseUpEvent primary position: aPosition + aDelta }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateEvent: anEvent on: anElement [
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
ToSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
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
ToSpace class >> simulateKeyDownOn: anElement key: aBlKeyboardKey [
	"Simulate a key down event"

	self
		simulateEvents: { BlKeyDownEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateKeyUpOn: anElement key: aBlKeyboardKey [
	"Simulate a key up event"

	self
		simulateEvents: { BlKeyUpEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateMouseDownOn: anElement [
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
ToSpace class >> simulateMouseDownOn: anElement at: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseDownEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateMouseMoveInside: anElement [
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	aPosition := self locationInside: anElement.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary
			position: aToPoint;
			delta: (aToPoint - aFromPoint)  }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateMouseMoveOutside: anElement [
	"Simulate a mouse move event at a random location outside of element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	aPosition := self locationOutside: anElement.
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateMouseUpOn: anElement [
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
ToSpace class >> simulateMouseUpOn: anElement at: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseUpEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
ToSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
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
ToSpace class >> simulateSecondaryClickOn: anElement [
	"Simulate a secondary click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	<return: #Point>
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a secondary click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent secondary position: aPosition.
			BlMouseUpEvent secondary position: aPosition }
		on: anElement.
		
	^ aPosition
]

{ #category : #'class initialization' }
ToSpace class >> spaceWithId: aSpaceId do: aBlock [
	^ self allSubInstances
		detect: [ :eachSpace | eachSpace id = aSpaceId ]
		ifFound: aBlock
		ifNone: [ nil ]
]

{ #category : #'api - adding children' }
ToSpace >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : #accessing }
ToSpace >> asReference [
	<return: #BlSpaceReference>

	^ reference ifNil: [ reference := BlAttachedCachedSpaceReference forSpace: self ]
]

{ #category : #'-- extensions-sparta --' }
ToSpace >> asSpartaForm [
	<return: #Form>

	^ self root asSpartaForm
]

{ #category : #'change - rendering' }
ToSpace >> beDirtyArea [
	self
		invalidRect: (BlBounds origin: 0.0 @ 0.0 extent: self root extent)
		from: self root
]

{ #category : #'window - properties' }
ToSpace >> borderless [
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace borderless ]
		ifAbsent: [ borderless ]
]

{ #category : #'window - properties' }
ToSpace >> borderless: aBoolean [
	borderless := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace borderless: aBoolean ].
]

{ #category : #'change - properties' }
ToSpace >> canComputeProperties: anElement [
	"Return true if properties of the given element can be computed"
	<return: #Boolean>

	^ anElement hasParent and: [ anElement parent needsPropertiesComputation not ]
]

{ #category : #'api - displaying' }
ToSpace >> center [
	"Tell host to change my position to be centered. Do nothing if host space is not present (e.g. not shown)."

	self hostSpace ifNotNil: [ :hw | hw center ]
]

{ #category : #'change - rendering' }
ToSpace >> clearDirtyAreas [
	"Clear all dirty areas.
	Default implementation simply removes all areas from the collection"

	self dirtyAreas removeAll.
	self elementsNeedingPaint removeAll
]

{ #category : #'api - displaying' }
ToSpace >> close [
	"Delegate closing work to the Universe"
	
	(BlParallelUniverse forHost: self host class) closeSpace: self
]

{ #category : #'cursor managing' }
ToSpace >> currentCursor [
	^ currentCursor 
]

{ #category : #'cursor managing' }
ToSpace >> currentCursor: aCursor [

	currentCursor ifNotNil: [ :cc | cc deactivateOn: self ].
	currentCursor := aCursor.
	currentCursor ifNil: [ ^ self updateCursor: BlCursor default ].
	currentCursor activateOn: self
]

{ #category : #initialization }
ToSpace >> defaultEventDispatcher [
	^ BlDirectEventDispatcher on: self
]

{ #category : #initialization }
ToSpace >> defaultEventListener [
	^ BlSpaceEventListener space: self
]

{ #category : #initialization }
ToSpace >> defaultEventRecorder [
	^ BlEmptyEventRecorder new
]

{ #category : #initialization }
ToSpace >> defaultExtent [
	^ 800@600
]

{ #category : #initialization }
ToSpace >> defaultRoot [
	^ BlElement new
		background: self defaultRootBackground;
		labeled: self defaultRootLabel;
		yourself
]

{ #category : #initialization }
ToSpace >> defaultRootBackground [
	^ Color white
]

{ #category : #initialization }
ToSpace >> defaultRootLabel [
	^ 'Root element'
]

{ #category : #initialization }
ToSpace >> defaultTitle [
	^ ''
]

{ #category : #'window - properties' }
ToSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace densityDpi ]
		"Without an actual window we can only guess"
		ifAbsent: [ 96.0 ]
]

{ #category : #'api - tasks' }
ToSpace >> dequeueTask: aBlTask [
	self taskQueue dequeue: aBlTask.
	self requestNextPulse
]

{ #category : #'host space - accessing' }
ToSpace >> detachHostSpace [
	"Detach my current host space if I have one"

	hostSpace := nil
]

{ #category : #accessing }
ToSpace >> dirtyAreas [
	<return: #SequenceableCollection of: #BlBounds>

	^ dirtyAreas
]

{ #category : #pulse }
ToSpace >> dispatchTimeEvent: aSpaceStepEventClass during: aBlock [
	| aStartTime |
	
	aStartTime := self time now.
	aBlock cull: self.
	self eventDispatcher dispatchEvent:
			(aSpaceStepEventClass new
				start: aStartTime;
				end: self time now;
				yourself)
]

{ #category : #'change - properties' }
ToSpace >> doComputeProperties [
	| theElementToProcess |
	
	"if everything is clean, do nothing"
	(self needsPropertiesComputation)
		ifFalse: [ ^ self ].

	"only care about element that are attached to this space"
	theElementToProcess := self extractAttachedElements: self elementsNeedingPropertiesComputation.

	"first we should make sure that all parents have resolved properties"
	theElementToProcess := self extractUnresolvedToComputeProperties: theElementToProcess.

	"then we should eliminate child elements if their parent is already on the list"
	theElementToProcess := self extractRoots: theElementToProcess.
	
	self elementsNeedingPropertiesComputation removeAll.
	
	((theElementToProcess includes: self root) or: [ self root needsPropertiesComputation ])
		ifTrue: [ self doComputePropertiesFromRoot: self root ]
		ifFalse: [ self doComputePropertiesOf: theElementToProcess ]
]

{ #category : #'change - properties' }
ToSpace >> doComputeProperties: anElement withGlobalProperties: aGlobalResolvedProperties [
	self
		assert: [ anElement hasParent ]
		description: [ 'Can not compute properties of an element without parent' ].

	self
		assert: [ anElement parent needsPropertiesComputation not ]
		description: [ 'Parent properties must be computed' ].

	self
		doComputeProperties: anElement
		withParentProperties: anElement parent properties maybeResolvedProperties propertiesToPropagateToChildren
		withGlobalProperties: aGlobalResolvedProperties
]

{ #category : #'change - properties' }
ToSpace >> doComputeProperties: anElement withParentProperties: aParentResolvedProperties withGlobalProperties: aGlobalResolvedProperties [
	| theResolvedProperties thePropagatableProperties |

	self
		assert: [ aParentResolvedProperties isKindOf: BlElementPropagatableProperties ]
		description: [ 'Parent properties must be propagatable' ].
		
	self
		assert: [ aGlobalResolvedProperties isKindOf: BlElementPropagatableProperties ]
		description: [ 'Global properties must be propagatable' ].

	theResolvedProperties := anElement properties
		resolveWithParentProperties: aParentResolvedProperties
		orGlobal: aGlobalResolvedProperties.

	thePropagatableProperties := theResolvedProperties propertiesToPropagateToChildren.

	anElement childrenDo: [ :eachChild |
		self
			doComputeProperties: eachChild
			withParentProperties: thePropagatableProperties 
			withGlobalProperties: aGlobalResolvedProperties ].

	"we need to merge properties starting from global"
	((aGlobalResolvedProperties
		mergedWithProperties: aParentResolvedProperties)
			mergedWithProperties: theResolvedProperties)
				applyOnElement: anElement.

	anElement properties flushPropertiesToRemove
]

{ #category : #'change - properties' }
ToSpace >> doComputePropertiesFromRoot: aRootElement [
	| theGlobalResolvedProperties |

	aRootElement properties
		resolveWithParentProperties: BlElementResolvedProperties new
		orGlobal: BlElementResolvedProperties new.
	
	theGlobalResolvedProperties := aRootElement properties maybeResolvedProperties propertiesToPropagateToChildren.
	
	self
		doComputeProperties: aRootElement
		withParentProperties: theGlobalResolvedProperties
		withGlobalProperties: theGlobalResolvedProperties
]

{ #category : #'change - properties' }
ToSpace >> doComputePropertiesOf: aCollectionOfElements [
	| theGlobalResolvedProperties |

	self
		assert: [ (aCollectionOfElements includes: self root) not ]
		description: [ 'Must not include root' ].

	theGlobalResolvedProperties := self root properties maybeResolvedProperties propertiesToPropagateToChildren.
	aCollectionOfElements do: [ :eachElement |
		"it is possible that properties manipulate the graphical scene,
		therefore we have to check it here again"
		eachElement hasParent
			ifTrue: [
				self
					doComputeProperties: eachElement
					withGlobalProperties: theGlobalResolvedProperties ] ]
]

{ #category : #'change - layout' }
ToSpace >> doLayout [
	| layoutCounter maxLayoutCount |

	self
		assert: [ self isLayoutRequested ]
		description: [ 'Root element must request layout in order to update it' ].

	[
		layoutCounter := 0.
		maxLayoutCount := 100.

		[ self hasLayoutError not and: [ self isLayoutRequested and: [ layoutCounter < maxLayoutCount ] ] ]
			whileTrue: [
				self doUpdateLayout.
				layoutCounter := layoutCounter + 1.
				layoutCounter = 50
					ifTrue: [ 'Warning: Layout was performed 50 times per frame!' traceCr ] ].

		self root dispatchLayoutDone

	"I prevent infinite spawn of debuggers"
	] on: Error do: [ :anError |
		layoutError := anError.
		[ layoutError debug ] ensure: [ layoutError := nil ] ].
]

{ #category : #'change - style' }
ToSpace >> doStyle [
	| theElementsToStyle |
	
	self needsStyleComputation
		ifFalse: [ ^ self ].
	
	"only care about element that are attached to this space"
	theElementsToStyle := self elementsNeedingStyle.

	"first we should make sure that all parents are styled"
	theElementsToStyle := self extractUnstyled: theElementsToStyle.

	"then we should eliminate child elements if their parent is already on the list"
	theElementsToStyle := self extractRoots: theElementsToStyle.
	
	self elementsNeedingStyle removeAll.
	
	theElementsToStyle do: [ :eachElement | self doStyle: eachElement ]
]

{ #category : #'change - style' }
ToSpace >> doStyle: anElement [
	anElement applyStyles
]

{ #category : #'focus managing' }
ToSpace >> doUpdateFocus [
	(self focusOwner notNil and: [ self focusOwner isAttachedToSceneGraph not ])
		ifTrue: [
			focusChain
				deepestAttachedElementDo: [ :aNewFocusOwner |
					aNewFocusOwner requestFocusDueTo: BlFocusDueToRemovedFromSpaceReason uniqueInstance ]
				ifAbsent: [ self focusProcessor focusOwner: nil ] ].

	self focusOwner
		ifNil: [ self initializeFocus ]
]

{ #category : #'change - layout' }
ToSpace >> doUpdateLayout [
	| elementsToLayout aBlElementBoundsUpdater |
	
	self elementsNeedingLayout copy do: [ :eachElement |
		eachElement privatePreviousMeasurementSpec
			ifNil: [
				self elementsNeedingLayout remove: eachElement.
				eachElement requestLayout ] ].
	
	elementsToLayout := self elementsNeedingLayout reject: [ :eachElement |
		| shouldIgnore |
		
		shouldIgnore := false.
		
		self elementsNeedingLayout do: [ :eachPotentialParent |
			(eachElement hasParent: eachPotentialParent)
				ifTrue: [
					eachElement
						allParentsTo: eachPotentialParent
						do: [ :eachParent | eachParent privateRequestingLayout: true ].
					shouldIgnore := true ] ].
		
		shouldIgnore ].
	
	"we should clear the elements needing layout before we compute layout to support multiple layout passes"
	self elementsNeedingLayout removeAll.
	
	elementsToLayout := elementsToLayout
		collect: [ :eachElement | eachElement -> eachElement compositionDepth ] as: Array.
	elementsToLayout := (elementsToLayout sort: [ :a :b | a value > b value ]) collect: [ :each | each key ].

	aBlElementBoundsUpdater := BlElementBoundsUpdater new.

	elementsToLayout do: [ :eachElement |
		self doUpdateLayoutBoundary: eachElement context: aBlElementBoundsUpdater ].
	
	self root isLayoutRequested
		ifTrue: [ self doUpdateLayout: self root context: aBlElementBoundsUpdater ].
		
	aBlElementBoundsUpdater commitChanges
]

{ #category : #'change - layout' }
ToSpace >> doUpdateLayout: anElement context: aBlElementBoundsUpdater [
	"Perform layout of a given element (e.g. root or glass)"

	| currentExtent |
	"First, we measure..."
	currentExtent := self extent.
	anElement measure: (BlExtentMeasurementSpec new
		widthSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec exact: currentExtent x)
			usedSize:  0.0
			resizer: BlLayoutResizer matchParent);
		heightSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec exact: currentExtent y)
			usedSize:  0.0
			resizer: BlLayoutResizer matchParent)).

	"...then, we layout in measured during previous step bounds"
	anElement
		applyLayoutIn: anElement measuredBounds asRectangle
		context: aBlElementBoundsUpdater

]

{ #category : #'change - layout' }
ToSpace >> doUpdateLayoutBoundary: anElement context: aBlElementBoundsUpdater [
	"Perform layout of a given element (e.g. root or glass)"

	"first we measure.."
	anElement measure: anElement privatePreviousMeasurementSpec.

	"...then we layout in measured during previous step bounds"
	anElement applyLayoutIn: (anElement position extent: anElement measuredBounds extent) context: aBlElementBoundsUpdater
]

{ #category : #accessing }
ToSpace >> dragboard [
	^ dragboard
]

{ #category : #accessing }
ToSpace >> dragboard: anObject [
	dragboard := anObject
]

{ #category : #'change - layout' }
ToSpace >> elementsNeedingLayout [
	^ elementsNeedingLayout
]

{ #category : #'change - rendering' }
ToSpace >> elementsNeedingPaint [
	^ elementsNeedingPaint
]

{ #category : #'change - layout' }
ToSpace >> elementsNeedingPropertiesComputation [
	^ elementsNeedingPropertiesComputation ifNil: [ elementsNeedingPropertiesComputation := Set new ]
]

{ #category : #'change - layout' }
ToSpace >> elementsNeedingStyle [
	^ elementsNeedingStyle
		ifNil: [ elementsNeedingStyle := Set new ]
]

{ #category : #'api - tasks' }
ToSpace >> enqueueTask: aBlTask [
	aBlTask onEnqueued: self.
	self taskQueue enqueue: aBlTask.
	self requestNextPulse
]

{ #category : #'api - tasks' }
ToSpace >> enqueueTasksFrom: aTaskQueue [
	aTaskQueue tasks do: [ :eachTask | eachTask onEnqueued: self ].	
	self taskQueue enqueueFrom: aTaskQueue.
	self requestNextPulse
]

{ #category : #pulse }
ToSpace >> ensureSession [
	"Check current session and perform required operations if it changed since last frame"

	session == Smalltalk session
		ifTrue: [ ^ self ].

	self onSessionChanged: Smalltalk session
]

{ #category : #'event management accessing' }
ToSpace >> eventDispatcher [
	^ eventDispatcher
]

{ #category : #accessing }
ToSpace >> eventListener [
	^ eventListener
]

{ #category : #accessing }
ToSpace >> eventListener: anObject [
	eventListener := anObject
]

{ #category : #accessing }
ToSpace >> eventRecorder [
	<return: #BlSpaceEventRecorder>

	^ eventRecorder
]

{ #category : #accessing }
ToSpace >> eventRecorder: anEventRecorder [
	eventRecorder := anEventRecorder
]

{ #category : #'window - properties' }
ToSpace >> extent [
	<return: #Point>

	^ self windowExtent
]

{ #category : #'window - properties' }
ToSpace >> extent: aNewExtent [
	self windowExtent: aNewExtent
]

{ #category : #'private - change' }
ToSpace >> extractAttachedElements: aSetOfElements [
	^ aSetOfElements select: [ :eachElement |
		eachElement isAttachedToSceneGraph
			and: [ eachElement space == self ] ]
]

{ #category : #'private - change' }
ToSpace >> extractParents: aSetOfElements suchThat: aConditionBlock [
	| theElementToProcess |

	theElementToProcess := Set new.

	aSetOfElements do: [ :eachElement |
		eachElement
			topMostParentSuchThat: aConditionBlock
			ifFound: [ :aNotYetResolvedParent | theElementToProcess add: aNotYetResolvedParent ]
			ifNone: [ theElementToProcess add: eachElement ] ].

	^ theElementToProcess
]

{ #category : #'private - change' }
ToSpace >> extractRoots: aSetOfElements [
	^ self class extractRoots: aSetOfElements
]

{ #category : #'change - properties' }
ToSpace >> extractUnresolvedToComputeProperties: aSetOfElements [
	^ self
		extractParents: aSetOfElements
		suchThat: [ :eachParent | eachParent needsPropertiesComputation ]
]

{ #category : #'change - style' }
ToSpace >> extractUnstyled: aSetOfElements [
	^ self
		extractParents: aSetOfElements
		suchThat: [ :eachParent | eachParent needsStyle ]
]

{ #category : #'focus managing' }
ToSpace >> focusOwner [
	<return: #BlElement>

	^ focusChain ifNotNil: [ :aFocusChain | aFocusChain last ]
]

{ #category : #'focus managing' }
ToSpace >> focusOwner: anElement [
	focusChain := anElement ifNotNil: [ BlFocusChain of: anElement ]
]

{ #category : #'accessing - processors' }
ToSpace >> focusProcessor [
	<return: #BlFocusProcessor>

	^ focusProcessor
]

{ #category : #'accessing - processors' }
ToSpace >> focusProcessor: aFocusProcessor [
	focusProcessor := aFocusProcessor
]

{ #category : #'window - properties' }
ToSpace >> focused [
	<return: #Boolean>

	^ focused
]

{ #category : #'window - properties' }
ToSpace >> focused: aBoolean [
	focused := aBoolean
]

{ #category : #accessing }
ToSpace >> frame [
	<return: #BlSpaceFrame>

	^ frame
]

{ #category : #drawing }
ToSpace >> fullDrawOn: anCanvas [
	anCanvas fullDraw: self root
]

{ #category : #'window - properties' }
ToSpace >> fullscreen [
	"Return true if an underlying window is in fullscreen mode,
	false otherwise"
	<return: #Boolean>

	^ self 
		hostSpaceDo: [ :aHostSpace | aHostSpace fullscreen ]
		ifAbsent: [ fullscreen ]
]

{ #category : #'window - properties' }
ToSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	fullscreen := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace fullscreen: aBoolean ]
]

{ #category : #'window - properties' }
ToSpace >> fullsize [
	"Return true if an underlying window is in fullsize mode,
	false otherwise.
	Fullsize means that the content of a window is rendered underneath the title bar, which is transparent
	and has no window title"
	<return: #Boolean>

	^ self 
		hostSpaceDo: [ :aHostSpace | aHostSpace fullsize ]
		ifAbsent: [ fullsize ]
]

{ #category : #'window - properties' }
ToSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"

	fullsize := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace fullsize: aBoolean ]
]

{ #category : #'accessing - processors' }
ToSpace >> gestureProcessor [
	<return: #BlGestureProcessor>

	^ gestureProcessor
]

{ #category : #'focus managing' }
ToSpace >> grabFocus [
	self focused: true
]

{ #category : #testing }
ToSpace >> hasDirtyAreas [
	"Return true if space has dirty areas and therefore needs to be rendered,
	false otherwise"
	<return: #Boolean>
	
	^ self dirtyAreas isNotEmpty
]

{ #category : #'focus managing' }
ToSpace >> hasFocus: anElement [
	"Return true if a given element is within the focus chain"
	
	self focusOwner
		ifNil: [ ^ false ].
		
	self focusOwner == anElement
		ifTrue: [ ^ true ].
		
	^ self focusOwner hasParent: anElement
]

{ #category : #'host space - accessing' }
ToSpace >> hasHostSpace [
	"Return true if I have a host space, false otherwise"
	<return: #Boolean>

	^ self hostSpace isNotNil
]

{ #category : #testing }
ToSpace >> hasLayoutError [
	"Return true if there was a layout error, false otherwise"
	<return: #Boolean>

	^ layoutError isNotNil
]

{ #category : #testing }
ToSpace >> hasOwner [
	"To be polymorphic with BlElement's traversal API.
	Space does not have an owner"
	<return: #Boolean>
	
	^ false
]

{ #category : #'window - properties' }
ToSpace >> height [
	<return: #Number>

	^ self extent y
]

{ #category : #'api - displaying' }
ToSpace >> hide [
	self hostSpace ifNotNil: [ :hw | hw hide ]
]

{ #category : #'host space - accessing' }
ToSpace >> host [
	^ host
]

{ #category : #'host space - accessing' }
ToSpace >> host: aHost [
	"Change the host of this space. Asynchronous. If the space is opened, first destroy the host window and then open the space with a new host"
	| aDetachedEventHandler |

	aDetachedEventHandler := nil.

	aDetachedEventHandler := BlEventHandler
		on: BlSpaceDetachedEvent
		do: [ :anEvent |
			self removeEventHandler: aDetachedEventHandler.
			host := aHost.
			self universe attachSpace: self ].

	self isOpened
		ifTrue: [ self universe detachSpace: self ]
		ifFalse: [ host := aHost ]
]

{ #category : #'host space - accessing' }
ToSpace >> hostSpace [
	^ hostSpace
]

{ #category : #'host space - accessing' }
ToSpace >> hostSpace: aHostSpace [
	"Assign a host space window that will be a source of UI events
	and will provide a rendering surface on which I will be rendered.
	aHostSpace must not be nil"

	self
		assert: [ aHostSpace isNotNil ]
		description: [ 'Host space must not be nil!' ].

	hostSpace := aHostSpace.
	self hostSpaceChanged.
]

{ #category : #'host space - accessing' }
ToSpace >> hostSpaceChanged [
	"When host space changed we might want to adapt sizes"
	self windowExtent: self windowExtent.
	"host space changed => renderer changed, we want to redraw the whole space"
	self beDirtyArea
]

{ #category : #'host space - accessing' }
ToSpace >> hostSpaceDo: aBlock [
	^ self hostSpaceDo: aBlock ifAbsent: [ self ]
]

{ #category : #'host space - accessing' }
ToSpace >> hostSpaceDo: aBlock ifAbsent: anAbsentBlock [
	self hasHostSpace
		ifFalse: [ ^ anAbsentBlock value ].

	self hostSpace needsRebuild
		ifTrue: [ ^ anAbsentBlock value ].
		
	^ aBlock cull: self hostSpace
]

{ #category : #'window - properties' }
ToSpace >> icon [
	"Return an object that understands #asElement, or nil"
	^ iconStencil
]

{ #category : #'window - properties' }
ToSpace >> icon: aStencil [
	"aStencil is an object that undestands #asElement and returns ${class:BlElement}$"
	
	iconStencil = aStencil ifTrue: [ ^ self ].
	
	iconStencil := aStencil.
	
	self fireEvent: (BlSpaceIconChangedEvent new iconStencil: aStencil)
]

{ #category : #accessing }
ToSpace >> id [
	<return: #Number>
	
	^ id
]

{ #category : #initialization }
ToSpace >> initDispatcher [
	self eventDispatcher addEventFilter: self eventListener
]

{ #category : #initialization }
ToSpace >> initialize [
	super initialize.
	
	id := UniqueIdGenerator generateUniqueId.
	
	host := BlHost pickHost.
	nextPulseRequested := true.
	session := Smalltalk session.
	dirtyAreas := OrderedCollection new.
	elementsNeedingPaint := Set new.
	elementsNeedingLayout := Set new.
	elementsNeedingStyle := Set new.
	elementsNeedingPropertiesComputation := Set new.
	
	eventDispatcher := self defaultEventDispatcher.
	eventListener := self defaultEventListener.
	eventRecorder := self defaultEventRecorder.
	self initDispatcher.
	
	mouseProcessor := BlMouseProcessor space: self.
	focusProcessor := BlFocusProcessor space: self.
	keyboardProcessor := BlKeyboardProcessor space: self.
	touchProcessor := BlTouchProcessor space: self.
	gestureProcessor := BlGestureProcessor space: self.

	tasks := BlSpaceTaskQueue space: self.
	time := BlTime real.
	frame := BlSpaceFrame new.
	telemetry := BlNullTelemetry uniqueInstance.

	root := self defaultRoot.

	self extent: self defaultExtent.

	self resizable: true.
	self borderless: false.
	self fullscreen: false.
	self fullsize: false.
	self title: self defaultTitle.
	self focused: false.

	self updateCursor: BlCursor default.

	self root space: self
]

{ #category : #'focus managing' }
ToSpace >> initializeFocus [
	self root isFocusable
		ifTrue: [ self root requestFocus ]
]

{ #category : #'-- extensions-spec2 --' }
ToSpace >> inspectionPreview: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Preview'>

	^ self root inspectionPreview: aBuilder
]

{ #category : #'-- extensions-spec2 --' }
ToSpace >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ self root inspectionTree: aBuilder
]

{ #category : #'change - rendering' }
ToSpace >> invalidRect: aBlBounds from: anElement [
	self makeDirty: aBlBounds.
	self requestNextPulse.
	
	self hostSpaceDo: [ :aHostSpace | aHostSpace requestRedraw ]
]

{ #category : #testing }
ToSpace >> isFocused [
	^ self focused
]

{ #category : #'change - layout' }
ToSpace >> isLayoutRequested [
	"Indicates whether or not root element's layout needs to be updated next frame"
	<return: #Boolean>
	
	^ self root isLayoutRequested or: [ self elementsNeedingLayout isNotEmpty ]
]

{ #category : #testing }
ToSpace >> isOpened [
	"Return true if the space was shown (by sending #show message), false otherwise.
	Please note, that an opened space can be hidden which does not influence the result of #isOpened"
	<return: #Boolean>

	^ (BlParallelUniverse existsForHost: self host class)
		and: [ (BlParallelUniverse forHost: self host class) hasSpace: self ]
]

{ #category : #testing }
ToSpace >> isVisible [
	^ self hasHostSpace
		ifTrue: [ self hostSpace isVisible ]
		ifFalse: [ false ]
]

{ #category : #'accessing - processors' }
ToSpace >> keyboardProcessor [
	<return: #BlKeyboardProcessor>

	^ keyboardProcessor
]

{ #category : #'accessing - processors' }
ToSpace >> keyboardProcessor: aKeyboardProcessor [
	keyboardProcessor := aKeyboardProcessor
]

{ #category : #'window - properties' }
ToSpace >> knowsPosition [
	"Return true if this space knows its position.
	By default, spaces don't know their position and allow the window manager to choose one.
	Setting an explicit position during space creation will result in a window created at a specified position"
	<return: #Boolean>

	^ position notNil
]

{ #category : #'focus managing' }
ToSpace >> looseFocusFor: anElement [
			
	self
		deprecated: 'Please use loseFocusFor: instead.'
		transformWith:
			'`@receiver looseFocusFor: `@statements1'
				-> '`@receiver loseFocusFor: `@statements1'.
				
	self loseFocusFor: anElement
]

{ #category : #'focus managing' }
ToSpace >> loseFocusFor: anElement [
	self focusProcessor loseFor: anElement
]

{ #category : #'change - rendering' }
ToSpace >> makeDirty: aBlBounds [

	self
		assert: [ aBlBounds isKindOf: BlBounds ]
		description: [ 'Only BlBounds can be used as dirty area' ].

	aBlBounds expanded.
	self dirtyAreas
		ifEmpty: [ self dirtyAreas add: aBlBounds copy ]
		ifNotEmpty: [ :aCollection | aCollection first merge: aBlBounds ].
]

{ #category : #'change - rendering' }
ToSpace >> markNeedsCompositionPaint: anElement from: aSourceElement [
	self beDirtyArea.
	self hostSpaceDo: [ :aHostSpace | aHostSpace requestRedraw ].
	self requestNextPulse
]

{ #category : #'change - rendering' }
ToSpace >> markNeedsPaint: anElement from: aSourceElement [
	self beDirtyArea.
	self elementsNeedingPaint add: anElement.
	self hostSpaceDo: [ :aHostSpace | aHostSpace requestRedraw ].
	self requestNextPulse
]

{ #category : #'api - displaying' }
ToSpace >> maximize [
	self hostSpace ifNotNil: [ :hw | hw maximize ]
]

{ #category : #'api - displaying' }
ToSpace >> maximized [
	self hostSpace ifNotNil: [ :hw | ^ hw maximized ].
	^ false
]

{ #category : #pulse }
ToSpace >> measureTextParagraph: aBlTextParagraph ifNotAvailable: aBlock [
	self
		hostSpaceDo: [ :aHostSpace | aHostSpace measureTextParagraph: aBlTextParagraph ]
		ifAbsent: aBlock
]

{ #category : #'api - displaying' }
ToSpace >> minimize [
	self hostSpace ifNotNil: [ :hw | hw minimize ]
]

{ #category : #'api - displaying' }
ToSpace >> minimized [
	self hostSpace ifNotNil: [ :hw | ^ hw minimized ].
	^ false
]

{ #category : #'accessing - processors' }
ToSpace >> mouseProcessor [
	<return: #BlMouseProcessor>

	^ mouseProcessor
]

{ #category : #'accessing - processors' }
ToSpace >> mouseProcessor: aMouseProcessor [
	mouseProcessor := aMouseProcessor
]

{ #category : #'change - properties' }
ToSpace >> needsPropertiesComputation [
	<return: #Boolean>
	
	^ self elementsNeedingPropertiesComputation isNotEmpty
		or: [ self root needsPropertiesComputation ]
]

{ #category : #'change - properties' }
ToSpace >> needsPropertiesComputation: anElement [
	"Return true if a given element or any of its children wants properties computation"
	<return: #Boolean>

	^ self elementsNeedingPropertiesComputation
		anySatisfy: [ :eachElement | 
			(eachElement = anElement
				or: [ eachElement hasParent: anElement ])
					and: [ anElement hasParent
						and: [ anElement parent needsPropertiesComputation not ] ] ]
]

{ #category : #'change - style' }
ToSpace >> needsStyleComputation [
	<return: #Boolean>
	
	^ self elementsNeedingStyle isNotEmpty
]

{ #category : #'change - style' }
ToSpace >> needsStyleComputation: anElement [
	"Return true if a given element or any of its children wants style computation"
	<return: #Boolean>
	
	^ self elementsNeedingStyle
		anySatisfy: [ :eachElement | eachElement = anElement or: [ eachElement hasParent: anElement ] ]
]

{ #category : #pulse }
ToSpace >> onSessionChanged: aNewSession [
	session := aNewSession.
	self beDirtyArea.
	self requestNextPulse.
	
	self root onSessionChanged: aNewSession
]

{ #category : #'window - properties' }
ToSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace position ]
		ifAbsent: [ position ifNil: [ 0@0 ] ]
]

{ #category : #'window - properties' }
ToSpace >> position: aPoint [
	"Request to change window's position to a given point in screen coordinates"

	self setPosition: aPoint.
	self hostSpaceDo: [ :aHostSpace | aHostSpace position: aPoint ]
]

{ #category : #printing }
ToSpace >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< '(';
		print: title;
		<< ')'
]

{ #category : #pulse }
ToSpace >> processPulse [
	self ensureSession.
	
	self pulseRequested
		ifFalse: [ ^ self ].
	
	"flip to false beforehand to be able to know if the next pulse was needed during the frame"
	nextPulseRequested := false.

	self telemetry
		reset;
		timeSync: 'Frame'
			during: [ self frame runOn: self ];
		emit.
]

{ #category : #pulse }
ToSpace >> pulse [
	self processPulse
]

{ #category : #'change - rendering' }
ToSpace >> pulseRequested [
	"Return true if space pulse was requested, false otherwise"
	<return: #Boolean>

	^ nextPulseRequested
]

{ #category : #'api - adding children' }
ToSpace >> removeChild: anElement [
	"Remove a given element from the space root"
	
	self root removeChild: anElement
]

{ #category : #pulse }
ToSpace >> render [
	"Render this space in my host window if it is assigned, otherwise do nothing"

	self
		hostSpaceDo: [ :aHostSpace | aHostSpace render: self ]
		"if there is no host we should clear dirty areas, otherwise
		it may lead to memory leaks"
		ifAbsent: [ self clearDirtyAreas ]
]

{ #category : #'focus managing' }
ToSpace >> requestFocusFor: anElement dueTo: aFocusReason [
	self
		assert: [ anElement space = self ]
		description: [ 'anElement must be attached to the scenegraph owned by this space' ].
		
	self focusProcessor requestFor: anElement dueTo: aFocusReason
]

{ #category : #'change - layout' }
ToSpace >> requestLayout: anElement [
	elementsNeedingLayout add: anElement.
	self requestNextPulse
]

{ #category : #'change - rendering' }
ToSpace >> requestNextPulse [
	nextPulseRequested := true
]

{ #category : #'change - properties' }
ToSpace >> requestPropertiesComputation: anElement [
	self elementsNeedingPropertiesComputation add: anElement.
	self requestNextPulse
]

{ #category : #'change - style' }
ToSpace >> requestStyle: anElement [		
	self elementsNeedingStyle add: anElement.
	self requestNextPulse
]

{ #category : #'window - properties' }
ToSpace >> resizable [
	"Return true if underlying window is resizable, false otherwise"
	<return: #Boolean>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace resizable ]
		ifAbsent: [ resizable ]
]

{ #category : #'window - properties' }
ToSpace >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
	
	resizable := aBoolean.
	self hostSpaceDo: [ :aHostSpace | aHostSpace resizable: aBoolean ]
]

{ #category : #accessing }
ToSpace >> root [
	"Return my current root element.
	root can not be nil"
	
	^ root
]

{ #category : #accessing }
ToSpace >> root: anElement [
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

	root := anElement
]

{ #category : #accessing }
ToSpace >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #pulse }
ToSpace >> runTasks [
	"Run animations and other runnable tasks"

	self taskQueue runOn: self
]

{ #category : #accessing }
ToSpace >> session [
	^ session
]

{ #category : #'private - accessing' }
ToSpace >> setExtent: anExtent [
	"Actually change space and root extent to a given one"

	extent := anExtent.
	self root requestLayout
]

{ #category : #'private - accessing' }
ToSpace >> setPosition: aPoint [
	"Actually change space, root and glass extent to a given one"

	position := aPoint
]

{ #category : #'api - displaying' }
ToSpace >> show [
	"Open me in a window and show it to the user"

	"delegate showing work to the Universe"	
	(BlParallelUniverse forHost: self host class) openSpace: self
]

{ #category : #'api - displaying' }
ToSpace >> showSpace: aSpace [
	"I show a given space either inside of me or let it open by default"
	aSpace show
]

{ #category : #accessing }
ToSpace >> space [
	^self
]

{ #category : #'api - tasks' }
ToSpace >> taskQueue [
	<return: #BlSpaceTaskQueue>
	
	^ tasks
]

{ #category : #accessing }
ToSpace >> telemetry [
	<return: #BlTelemetry>
	
	^ telemetry
]

{ #category : #accessing }
ToSpace >> telemetry: aBlTelemetry [
	telemetry := aBlTelemetry
]

{ #category : #accessing }
ToSpace >> time [
	<return: #BlTime>
	
	^ time
]

{ #category : #accessing }
ToSpace >> time: aBlTime [
	time := aBlTime
]

{ #category : #'window - properties' }
ToSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace title ]
		ifAbsent: [ title ]
]

{ #category : #'window - properties' }
ToSpace >> title: aString [
	"Change window's title"

	title := aString.
	self hostSpaceDo: [ :aHostSpace | aHostSpace title: aString ]
]

{ #category : #'api - displaying' }
ToSpace >> toBack [
	self hostSpace ifNotNil: [ :hw | hw toBack ]
]

{ #category : #'api - displaying' }
ToSpace >> toFront [
	self hostSpace ifNotNil: [ :hw | hw toFront ]
]

{ #category : #accessing }
ToSpace >> topMostParent [
	^ self root
]

{ #category : #'accessing - processors' }
ToSpace >> touchProcessor [
	<return: #BlTouchProcessor>

	^ touchProcessor
]

{ #category : #'focus managing' }
ToSpace >> ungrabFocus [
	self focused: false
]

{ #category : #accessing }
ToSpace >> universe [
	<return: #BlParallelUniverse>

	^ BlParallelUniverse forHost: self host class
]

{ #category : #'cursor managing' }
ToSpace >> updateCursor: aBlCursor [
	self hostSpaceDo: [ :aHostSpace | aHostSpace cursor: aBlCursor ]
]

{ #category : #'window - properties' }
ToSpace >> width [
	<return: #Number>

	^ self extent x
]

{ #category : #'window - properties' }
ToSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"

	<return: #Point>
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace logicalSize width @ aHostSpace logicalSize height ]
		ifAbsent: [ extent ]
]

{ #category : #'window - properties' }
ToSpace >> windowExtent: anExtent [
	"Request to change a window size to aNewExtent.
	Note, that window size may be different from renderer size on high dpi (retina) displays"

	self setExtent: anExtent.
	self hostSpaceDo: [ :aHostSpace | aHostSpace windowExtent: anExtent ]
]

{ #category : #'window - properties' }
ToSpace >> windowScale [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace scaleFactor ]
		ifAbsent: [ 1.0 asPoint ]
]

{ #category : #'-- extensions-bloc-dev-tool --' }
ToSpace >> withHalos [
	"self root addEventFilter: BlDevHalosEventListener new"
]
